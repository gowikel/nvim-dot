;; extends

; AlpineJS attributes
; <div x-data="{ foo: 'bar' }" x-init="baz()">
(attribute
  (attribute_name) @_attr
  (#lua-match? @_attr "^x%-%l+")
  (#not-any-of? @_attr "x-teleport" "x-ref" "x-transition")
  (quoted_attribute_value
    (attribute_value) @injection.content)
  (#set! injection.language "javascript"))

(attribute
  (attribute_name) @_attr
  (#lua-match? @_attr "^[:@]%l+")
  (quoted_attribute_value
    (attribute_value) @injection.content)
  (#set! injection.language "javascript"))
