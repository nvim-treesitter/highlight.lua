local api = vim.api

local config = require'lib/init'
if not config then return end

local init_ts_parser = require 'lib/runner'.init_ts_parser

local filetypes = {
    js = {
        init = false,
        attributes = require 'syntax/javascript'.get_attributes(config.colors)
    }
}

local buffer_handles = {}

local function define_colors(group_colors, color_lang)
    for group, data in pairs(group_colors) do
        local fg = " guifg=".. (data.fg or "NONE")
        local bg = " guibg=".. (data.bg or "NONE")
        local gui = " gui=".. (data.gui or "NONE")
        vim.api.nvim_command('hi '..color_lang..group.. gui.. bg.. fg)
    end
end

local function on_detach(buf)
    for i, handle in pairs(buffer_handles) do
        if buf == handle then
            table.remove(buffer_handles, i)
            break
        end
    end
end

local function get_ext(name)
    local ext = string.match(name or '', '%.[^%./]*$') or ''
    return string.sub(ext, 2, -1)
end

local function has_parser(lang)
    for path in string.gmatch(package.path, '[^;]*') do
        local parser = string.sub(path, 0, -10)..'parser/'..lang..'.so'
        if vim.loop.fs_access(parser, 'RX') then
            return true
        end
    end
    return false
end

local function attach()
    local buf = api.nvim_win_get_buf(0)

    for i, handle in pairs(buffer_handles) do
        if buf == handle then return end
    end

    local ext = get_ext(api.nvim_buf_get_name(buf))
    local ft = filetypes[ext]

    if ft ~= nil and has_parser(ft.attributes.parser_lang) then
        api.nvim_command('setlocal syntax=off') -- reset the syntax and use only our api
        api.nvim_buf_clear_namespace(buf, -1, 0, -1)

        local attributes = ft.attributes
        if not ft.init then
            define_colors(attributes.highlight_groups, attributes.color_lang)
            ft.init = true
        end

        local update_highlight = init_ts_parser(buf, attributes)

        local has_attached = vim.api.nvim_buf_attach(buf, 0, {
            on_detach = on_detach,
            on_lines = update_highlight
        })
        if has_attached then table.insert(buffer_handles, buf) end
    end
end

return { attach = attach }
