local nvim = require 'lib/nvim'
local get = nvim.get
local has = nvim.has
local err_msg = nvim.err_msg

-- TODO: has_parser() should handle path for windows to enable plugin on windows
if has('win32') then
    err_msg('windows is not supported at the moment')
    return false
end

local gui_colors = {
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

local colors = {
    black = get('terminal_color_0', 'black'), 
    red = get('terminal_color_1', 'red'), 
    green = get('terminal_color_2', 'green'), 
    yellow = get('terminal_color_3', 'yellow'), 
    blue = get('terminal_color_4', 'blue'), 
    purple = get('terminal_color_5', 'purple'), 
    cyan = get('terminal_color_6', 'cyan'), 
    white = get('terminal_color_7', 'white'), 
    visual_grey = get('terminal_color_8', 'grey'), 
    dark_red = get('terminal_color_9', 'darkred'), 
    dark_green = get('terminal_color_10', 'darkgreen'), 
    dark_yellow = get('terminal_color_11',' darkyellow'), 
    dark_blue = get('terminal_color_12', 'darkblue'), 
    dark_purple = get('terminal_color_13', 'darkpurple'), 
    dark_cyan = get('terminal_color_14', 'darkcyan'), 
    comment_grey = get('terminal_color_15', 'darkgrey'), 
    fg = get('terminal_color_7', 'white'),
    bg = get('terminal_color_0', 'black')
}

local filetypes = {
    js = require 'syntax/javascript'(colors)
}

local function define_colors(group_colors, color_lang)
    for group, data in pairs(group_colors) do
        local fg = " guifg=".. (data.fg or "NONE")
        local bg = " guibg=".. (data.bg or "NONE")
        local gui = " gui=".. (data.gui or "NONE")
        vim.api.nvim_command('hi '..color_lang..group.. gui.. bg.. fg)
    end
end

for _, attr in pairs(filetypes) do
    define_colors(attr.highlight_groups, attr.color_lang)
end

return filetypes
