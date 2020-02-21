local function define_colors(group_colors, color_lang)
    for group, data in pairs(group_colors) do
        local fg = " guifg=".. (data.fg or "NONE")
        local bg = " guibg=".. (data.bg or "NONE")
        local gui = " gui=".. (data.gui or "NONE")
        vim.api.nvim_command('hi '..color_lang..group.. gui.. bg.. fg)
    end
end

return {
    define_colors = define_colors;
}
