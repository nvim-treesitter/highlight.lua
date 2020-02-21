local PARSER_LANG = 'javascript'
local COLOR_LANG = 'Javascript'

local definitions = {
    ['('] = 'Paren',
    [')'] = 'Paren',
    ['['] = 'Paren',
    [']'] = 'Paren',

    ['{'] = 'Bracket',
    ['}'] = 'Bracket',
    ['${'] = 'Bracket',

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

    ['if'] = 'Logic',
    ['else'] = 'Logic',
    ['break'] = 'Logic',
    ['do'] = 'Logic',
    ['while'] = 'Logic',
    ['for'] = 'Logic',
    finally = 'Logic',
    try = 'Logic',
    catch = 'Logic',
    continue = 'Logic',
    async = 'Logic',
    await = 'Logic',

    class = 'Class',
    extends = 'Class',
    ['=>'] = 'Arrow',
    new = 'New',
    string = 'String',
    call_expression = 'FunctionCall',
    arguments = 'Argument',
    identifier = 'Identifier',
    shorthand_property_identifier = 'ObjProperty',
    escape_sequence = 'EscapeSeq',
    property_identifier = 'Properties',
    formal_parameters = 'Parameters',

    -- TODO: not sure how to organize these
    -- Seems quite a lot of information we have here
    pair = '',
    object = '',
    undefined = '',
    class_body = '',
    catch_clause = '',
    try_statement = '',
    object_pattern = '',
    statement_block = '',
    class_heritage = '',
    arrow_function = '',
    new_expression = '',
    template_string = '',
    await_expression = '',
    binary_expression = '',
    class_declaration = '',
    member_expression = '',
    ternary_expression = '',
    variable_declarator = '',
    lexical_declaration = '',
    expression_statement = '',
    assignment_expression = '',
    template_substitution = '',
    parenthesized_expression = '',
}

function setup_groups(colors)
   return {
       Test1 = { bg = colors.dark_yellow },
       Test2 = { bg = colors.yellow },
       Test3 = { bg = colors.green },
       Test4 = { bg = colors.blue },
       Test5 = { bg = colors.cyan },
       Test6 = { bg = colors.red },
       Test7 = { bg = colors.purple },

       Parameters = { fg = colors.yellow },
       Identifier = { fg = colors.fg },
       EscapeSeq = { fg = colors.dark_green, gui = 'bold' },
       Class = { fg = colors.purple },
       Properties = { fg = colors.blue },
       Bracket = { fg = colors.cyan },
       Logic = { fg = colors.cyan },
       Var = { fg = colors.purple },
       Quote = { fg = colors.cyan },
       Paren = { fg = colors.fg },
       Operator = { fg = colors.cyan },
       Punc = { fg = colors.fg },
       New = { fg = colors.cyan },
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

