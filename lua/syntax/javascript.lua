local PARSER_LANG = 'javascript'
local COLOR_LANG = 'Javascript'

local definitions = {
    ['('] = 'Paren',
    [')'] = 'Paren',
    ['['] = 'Paren',
    [']'] = 'Paren',

    ['{'] = 'Bracket',
    ['}'] = 'Bracket',

    ['='] = 'Operator',
    ['<'] = 'Operator',
    ['>'] = 'Operator',
    ['<='] = 'Operator',
    ['>='] = 'Operator',
    ['=='] = 'Operator',
    ['!='] = 'Operator',
    ['==='] = 'Operator',
    ['!=='] = 'Operator',
    ['||'] = 'Operator',
    ['&&'] = 'Operator',

    [';'] = 'Punc',
    ['?'] = 'Punc',
    [':'] = 'Punc',
    ['.'] = 'Punc',
    ['!'] = 'Punc',
    [','] = 'Punc',

    ["'"] = 'Quote',
    ['"'] = 'Quote',
    ['`'] = 'Quote',

    const = 'Var',
    let = 'Var',
    var = 'Var',

    ['true'] = 'Bool',
    ['false'] = 'Bool',
    number = 'Number',

    string = 'String',
    arrow_function = 'Arrow',
    call_expression = 'FunctionCall',
    arguments = 'Argument',
    shorthand_property_identifier = 'ObjProperty',

    identifier = 'skip', -- remove later
    parenthesized_expression = 'skip',
    object_pattern = 'skip',
    lexical_declaration = 'skip',
    variable_declarator = 'skip',
}

function setup_groups(colors)
   return {
       Bracket = { fg = colors.cyan },
       Var = { fg = colors.purple },
       Quote = { fg = colors.cyan },
       Paren = { fg = colors.fg },
       Operator = { fg = colors.cyan },
       Punc = { fg = colors.fg },
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
            definitions = definitions,
            highlight_groups = setup_groups(colors),
            parser_lang = PARSER_LANG,
            color_lang = COLOR_LANG
        }
    end
}

