local api = vim.api

local filetypes = require'lib/init' 
if not filetypes then
    return {
        attach = function() end,
        detach = function() end
    }
end

local parser_cmd = require 'lib/parser'
local has_parser = parser_cmd.has_parser

local install_parser = require 'lib/install'.install_parser

local init_ts_parser = require 'lib/runner'.init_ts_parser
local BUF_HANDLES = {}

local function on_detach(buf)
    for i, handle in pairs(BUF_HANDLES) do
        if buf == handle then
            table.remove(BUF_HANDLES, i)
            break
        end
    end
end

local function attach_to_buf(buf, attributes)
    api.nvim_command('setlocal syntax=off') -- reset the syntax and use only our api
    api.nvim_buf_clear_namespace(buf, -1, 0, -1)

    local update_highlight = init_ts_parser(buf, attributes)

    local has_attached = vim.api.nvim_buf_attach(buf, 0, {
        on_detach = on_detach,
        on_lines = update_highlight
    })

    if has_attached then table.insert(BUF_HANDLES, buf) end
end

local function get_attributes(name)
    local ext = string.match(name or '', '%.[^%./]*$') or ''
    ext = string.sub(ext, 2, -1)
    return filetypes[ext]
end

local function attach()
    local buf = api.nvim_win_get_buf(0)

    for i, handle in pairs(BUF_HANDLES) do
        if buf == handle then return end
    end

    local attributes = get_attributes(api.nvim_buf_get_name(buf))
    if attributes ~= nil and has_parser(attributes.parser_lang) then
        attach_to_buf(buf, attributes)
    end
end

return {
    attach = attach;
    install_parser = install_parser;
}
