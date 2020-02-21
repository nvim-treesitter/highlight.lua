local api = vim.api

local nvim = require 'lib/nvim'
local get = nvim.get
local has = nvim.has
local exists = nvim.exists
local echo_err = nvim.echo_err

local define_colors = require 'lib/color_utils'.define_colors
local attach_to_buffer = require 'lib/runner'.attach_to_buffer

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
        api.nvim_buf_clear_namespace(buf, -1, 0, -1) -- doesnt seem to work

        local attributes = get_attr(colors)
        define_colors(attributes.highlight_groups, attributes.color_lang)

        attach_to_buffer(buf, attributes)
        table.insert(buffer_handles, buf)
    end
end

local function detach()
    local buf = api.nvim_win_get_buf(0)

    for i, handle in pairs(buffer_handles) do
        if buf == handle then
            api.nvim_buf_detach(buf)
            table.remove(buffer_handles, i)
            break
        end
    end
end

return {
    attach = attach,
    detach = detach
}

