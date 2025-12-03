;; Comments
(comment) @comment
(doc_comment) @comment.documentation

;; Lietrals
(string_literal) @string
(char_literal) @character
(integer_literal) @number
(float_literal) @float
(boolean_literal) @boolean
(null_literal) @constant

;; Symbols
["(" ")" "{" "}" "[" "]"] @punctuation.bracket
[":" "." "," ";" ] @punctuation.delimiter
[
 "+" "-" "*" "/" "%" "&" "|" "^" "<<" ">>" "<" ">" "<=" ">=" "==" "!=" "!" "..." ".." "::"
 "=" "+=" "-=" "*=" "/=" "%=" "&=" "|=" "^=" "<<=" ">>=" "#" "?" "->" "--" "++" "||" "&&"
] @operator

;; keyword
[
  "if" "else" "let" "return" "function" "import" "from" "for" "enum" "export"
  "while" "of" "public" "private" "new" "static" "final" "const" "as" "void" 
  "extern" "unknown" "type" "record" "decorator" (this_expression) (self_expression)
  "match" "when" "mut" "namespace" "meta" "declare" "include" "source" "inline" "break" "continue"
] @keyword

(identifier) @variable
"_" @variable

(primitive_keyword) @keyword

;; Types
(type_identifier) @type

(type_identifier (identifier)) @variable

(primitive_keyword) @type.builtin

;; Funciones
(function_declaration
  name: (identifier) @function)
(method_declaration
  name: (identifier) @function.method)

;; Variables
(variable_declaration
  name: (identifier) @variable)
(parameter_declaration
  name: (identifier) @variable.parameter)

;; Propiedades
(record_property_declaration
  name: (identifier) @property)
(property_access
  name: (identifier) @property)

(primary_expression
  (identifier) @variable)

;; Decorators
(decorator_use
  (identifier) @annotation)
(decorator_declaration
  (identifier) @annotation)

;; Records y Enums
(record_declaration name: (identifier) @type)
(enum_declaration name: (identifier) @enum)
(type_definition (identifier) @type)

(vector_access_expression (identifier) @variable)

(metadata_expression (identifier) @variable)
