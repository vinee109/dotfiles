" Vim Filetype Plugin File
" Language: golang
" Extensions: *.go

"""""""""""" Editor
set colorcolumn=120

"""""""""""" Tab & Spacing
set noexpandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

set textwidth=120
set formatoptions+=c

"""""""""""" Keybindings
nmap <leader>d :GoDef<cr>
