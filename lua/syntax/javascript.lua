local PARSER_LANG = 'javascript'
local COLOR_LANG = 'Js'

function setup_groups(colors)
   return {
       Function = { fg = colors.cyan, gui = 'italic' },
       Comment = { fg = colors.comment_grey, gui = 'italic' },
       Null = { fg = colors.dark_yellow },
       Regex = { fg = colors.cyan },
       RegexFlag = { gui = 'bold' },
       Error = { fg = colors.red },
       Parameters = { fg = colors.yellow },
       Identifier = { fg = colors.fg },
       EscapeSeq = { fg = colors.dark_green, gui = 'bold' },
       Class = { fg = colors.purple },
       Properties = { fg = colors.blue },
       Bracket = { fg = colors.cyan },
       Keyword = { fg = colors.cyan, gui = 'italic' },
       Var = { fg = colors.purple },
       Quote = { fg = colors.cyan },
       Paren = { fg = colors.fg },
       Operator = { fg = colors.cyan },
       Punc = { fg = colors.fg },
       New = { fg = colors.cyan, gui = 'italic' },
       String = { fg = colors.dark_green },
       FunctionCall = { fg = colors.blue },
       Argument = { fg = colors.fg },
       ObjProperty = { fg = colors.yellow },
       Arrow = { fg = colors.purple },
       Bool = { fg = colors.dark_yellow },
       Number = { fg = colors.dark_yellow },
   }
end

return {
    get_attributes = function(colors)
        return {
            highlight_groups = setup_groups(colors),
            parser_lang = PARSER_LANG,
            color_lang = COLOR_LANG
        }
    end
}

