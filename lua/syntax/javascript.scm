; Special identifiers
;--------------------

((identifier) @constant
 (match? @constant "^[A-Z][A-Z_]+$"))

((shorthand_property_identifier) @constant
 (match? @constant "^[A-Z][A-Z_]+$"))

((identifier) @constructor
 (match? @constructor "^[A-Z]"))

((identifier) @variable.builtin
 (match? @variable.builtin "^(arguments|module|console|window|document)$")
 (is-not? local))

((identifier) @function.builtin
 (eq? @function.builtin "require")
 (is-not? local))

; Function and method definitions
;--------------------------------

(function
  name: (identifier) @function)
(function_declaration
  name: (identifier) @function)
(method_definition
  name: (property_identifier) @function.method)

(pair
  key: (property_identifier) @function.method
  value: (function))
(pair
  key: (property_identifier) @function.method
  value: (arrow_function))

(assignment_expression
  left: (member_expression
    property: (property_identifier) @function.method)
  right: (arrow_function))
(assignment_expression
  left: (member_expression
    property: (property_identifier) @function.method)
  right: (function))

(variable_declarator
  name: (identifier) @function
  value: (arrow_function))
(variable_declarator
  name: (identifier) @function
  value: (function))

(assignment_expression
  left: (identifier) @function
  right: (arrow_function))
(assignment_expression
  left: (identifier) @function
  right: (function))

; Function and method calls
;--------------------------

(call_expression
  function: (identifier) @function)

(call_expression
  function: (member_expression
    property: (property_identifier) @function.method))

; Variables
;----------

(formal_parameters (identifier) @variable.parameter)

(identifier) @variable

; Properties
;-----------

(property_identifier) @property

; Literals
;---------

(this) @variable.builtin
(super) @variable.builtin

(true) @constant.builtin
(false) @constant.builtin
(comment) @comment
(string) @string
(regex) @string.special
(template_string) @string
(number) @number

; Punctuation
;------------

(template_substitution
  "${" @punctuation.special
  "}" @punctuation.special) @embedded

";" @punctuation.delimiter
"." @punctuation.delimiter
"," @punctuation.delimiter

"--" @operator
"-" @operator
"-=" @operator
"&&" @operator
"+" @operator
"++" @operator
"+=" @operator
"<" @operator
"<<" @operator
"=" @operator
"==" @operator
"===" @operator
"=>" @operator
">" @operator
">>" @operator
"||" @operator

"(" @punctuation.bracket
")" @punctuation.bracket
"[" @punctuation.bracket
"]" @punctuation.bracket
"{" @punctuation.bracket
"}" @punctuation.bracket

; Keywords
;----------
"const" @JsVar
"let" @JsVar
"var" @JsVar

"as" @JsKeyword
"async" @JsKeyword
"await" @JsKeyword
"break" @JsKeyword
"case" @JsKeyword
"catch" @JsKeyword
"class" @JsKeyword
"continue" @JsKeyword
"debugger" @JsKeyword
"default" @JsKeyword
"delete" @JsKeyword
"do" @JsKeyword
"else" @JsKeyword
"export" @JsKeyword
"extends" @JsKeyword
"finally" @JsKeyword
"for" @JsKeyword
"from" @JsKeyword
"function" @JsKeyword
"get" @JsKeyword
"if" @JsKeyword
"import" @JsKeyword
"in" @JsKeyword
"instanceof" @JsKeyword
"new" @JsKeyword
"of" @JsKeyword
"return" @JsKeyword
"set" @JsKeyword
"static" @JsKeyword
"switch" @JsKeyword
"target" @JsKeyword
"throw" @JsKeyword
"try" @JsKeyword
"typeof" @JsKeyword
"void" @JsKeyword
"while" @JsKeyword
"with" @JsKeyword
"yield" @JsKeyword
