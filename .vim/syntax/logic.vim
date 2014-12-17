" Vim syntax file
" Language: Logic

if exists("b:current_syntax")
	finish
endif

syn keyword keywords query fact
syn match keywords "? "
syn match keywords "! "
syn match logicComment ";.*$"
syn match var "?[a-z][a-z]*"
syn match paren "("
syn match paren ")"

let b:current_syntax = "logic"

hi def link keywords		Statement
hi def link logicComment 	Comment
hi def link var				Special
hi def link paren			Question
