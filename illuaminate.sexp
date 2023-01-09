; -*- mode: Lisp;-*-

;; Folders, files, or patterns to include.
(sources /)

;; Overrides for a specific pattern, file or directory. These are matched
;; in order, so later `at` blocks overwrite earlier ones.
(at /
 ;; Modifications to make to the linter set. For instance, `+all -var:unused`
 ;; will enable all warnings but var:unused.
 ;; Fuck the Police ;)
 (linters -format:table-trailing -doc:undocumented -var:unused -doc:undocumented-arg -var:unused-arg -doc:unresolved-reference)
 
 ;; Control how the illuaminate linter works.
 (lint
   ;; Modules which may have members which are not documented. Modules within this list are skipped by the `var:unresolved-member` warning.
   (dynamic-modules)
   
   ;; List of global variables
   (globals :max
      textutils
      term
      colors
      http
      peripheral
      read
      settings
      fs
      printError
      shell
      parallel
      sleep
      keys
      ;; CraftOS-PC
      periphemu
      config
    )
   
   ;; Whether tables entries should be separated by a comma (',') or semicolon (';').
   (table-separator comma)
   
   ;; The preferred quote mark (' or ").
   (quote double)
   
   ;; Allow setting globals on the top-level of the module.
   (allow-toplevel-global false)
   
   ;; Allow parenthesis which clarify syntactic ambiguities.
   (allow-clarifying-parens false)
   
   ;; Allow empty if or elseif blocks.
   (allow-empty-if false)
   
   ;; Spaces within bracketed terms, such as tables or function calls.
   (bracket-spaces
     ;; Spaces within call arguments.
     (call consistent)
     
     ;; Spaces within function arguments.
     (function-args consistent)
     
     ;; Spaces within parenthesised expressions.
     (parens consistent)
     
     ;; Spaces within tables.
     (table consistent)
     
     ;; Spaces within table indexes.
     (index consistent))))
