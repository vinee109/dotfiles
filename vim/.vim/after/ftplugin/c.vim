" Vim filetype plugin file
" Language: C

set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
ab incio #include <stdio.h>
ab inclib #include <stdlib.h>
ab incstr #include <string.h>

set foldmethod=syntax

" ctrl+c create include statement
inoremap <C-b> #include <.h><esc>F<a
" ctrl+f create for loop
inoremap <C-f> for (i = 0; i < ; i++) {<CR>}<esc>kf<la

" ,f surround current line with for loop
nnoremap <silent> <leader>f >>Ofor (i = 0; i < ; i++) {<esc>jo}<esc>kkf<la

" ,f highlight lines and surround them with for
vnoremap <silent> <leader>f >`<Ofor (i = 0; i < ; i++) {<esc>`>o}<esc>`<kf<la

" add filename and io and str
nmap <leader>fn HO/* <C-R>=expand("%:t")<CR> */<CR><CR>incio<CR>inclib<CR>incstr<CR><esc>j

if exists("t:put_file_name")
	finish
endif
let t:put_file_name = 1
autocmd BufNewFile * :normal ,fn
source $HOME/.vim/after/ftplugin/c_java.vim
