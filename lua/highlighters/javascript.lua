local LANG = 'javascript'
local PARSER_FILE = 'parser/'..LANG..'.so'

local parser = nil

local function highlight(colors)
    vim.treesitter.require_language(LANG, PARSER_FILE)
    parser = vim.treesitter.get_parser(0, LANG)
    print(vim.inspect(parser))
end

return {
    highlight = highlight
}

