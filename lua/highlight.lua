local api = vim.api

local nvim = require 'lib/nvim'
local get = nvim.get
local has = nvim.has
local exists = nvim.exists
local echo_err = nvim.echo_err

local HAS_GUI_COLORS = has('termguicolors')
local HAS_COLORS = true

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
        HAS_COLORS = false
        break
    end
end

local colors = {}

if HAS_COLORS and HAS_GUI_COLORS then
    colors = {
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
        fg = get('terminal_color_0'),
        bg = get('terminal_color_7')
    }
end

local filetypes = {
    lua = function() require 'highlighters/lua'.highlight(colors) end,
    js = function() require 'highlighters/javascript'.highlight(colors) end,
}

local function run()
    if not HAS_GUI_COLORS then
        return echo_err('termguicolors must be set to use this plugin')
    end

    if not HAS_COLORS then
        return echo_err('g:terminal_color_x must be set to use this plugin')
    end

    local name = api.nvim_buf_get_name(0)
    local ext = string.sub(string.match(name, '%.[^%./]*$'), 2, -1)
    local highlighter = filetypes[ext]
    if highlighter ~= nil then
        api.nvim_buf_clear_namespace(0, -1, 0, -1)
        highlighter()
    end
end

return { run = run }

