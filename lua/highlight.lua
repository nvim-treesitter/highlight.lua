local api = vim.api

local nvim = require 'lib/nvim'
local get = nvim.get
local has = nvim.has
local exists = nvim.exists
local echo_err = nvim.echo_err

local init_ts_parser = require 'lib/runner'.init_ts_parser

if not has('termguicolors') then
    echo_err('termguicolors must be set to use this plugin')
    return {
        attach = function() end,
        detach = function() end
    }
end

local colorlist = {
    'g:terminal_color_0',
    'g:terminal_color_1',
    'g:terminal_color_2',
    'g:terminal_color_3',
    'g:terminal_color_4',
    'g:terminal_color_5',
    'g:terminal_color_6',
    'g:terminal_color_7',
    'g:terminal_color_8',
    'g:terminal_color_9',
    'g:terminal_color_10',
    'g:terminal_color_11',
    'g:terminal_color_12',
    'g:terminal_color_13',
    'g:terminal_color_14',
    'g:terminal_color_15'
}

for _, color in pairs(colorlist) do
    if not exists(color) then
        echo_err(color..' must be set to use this plugin')
        return {
            attach = function() end,
            detach = function() end
        }
    end
end

local colors = {
    black = get('terminal_color_0'), 
    red = get('terminal_color_1'), 
    green = get('terminal_color_2'), 
    yellow = get('terminal_color_3'), 
    blue = get('terminal_color_4'), 
    purple = get('terminal_color_5'), 
    cyan = get('terminal_color_6'), 
    white = get('terminal_color_7'), 
    visual_grey = get('terminal_color_8'), 
    dark_red = get('terminal_color_9'), 
    dark_green = get('terminal_color_10'), 
    dark_yellow = get('terminal_color_11'), 
    dark_blue = get('terminal_color_12'), 
    dark_purple = get('terminal_color_13'), 
    dark_cyan = get('terminal_color_14'), 
    comment_grey = get('terminal_color_15'), 
    fg = get('terminal_color_7'),
    bg = get('terminal_color_0')
}

local filetypes = {
    js = require 'syntax/javascript'.get_attributes
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

local function attach()
    local buf = api.nvim_win_get_buf(0)

    for i, handle in pairs(buffer_handles) do
        if buf == handle then return end
    end

    local name = api.nvim_buf_get_name(buf)
    if name == nil then return end

    local ext = string.match(name, '%.[^%./]*$')
    if ext == nil then return end

    ext = string.sub(ext, 2, -1)
    local get_attr = filetypes[ext]

    -- TODO: check if parser exists
    if get_attr ~= nil then
        api.nvim_command('setlocal syntax=off') -- reset the syntax and use only our api
        api.nvim_buf_clear_namespace(buf, -1, 0, -1)

        local attributes = get_attr(colors)
        define_colors(attributes.highlight_groups, attributes.color_lang)

        local update_highlight = init_ts_parser(buf, attributes)

        local has_attached = vim.api.nvim_buf_attach(buf, 0, {
            on_detach = on_detach,
            on_lines = update_highlight
        })
        if has_attached then table.insert(buffer_handles, buf) end
    end
end

return { attach = attach }
