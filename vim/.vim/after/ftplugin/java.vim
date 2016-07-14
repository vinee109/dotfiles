" Vim filetype plugin file
" Language: Java

set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
ab psvm public static void main(String[] args) {
ab sop System.out.print
ab sopl System.out.println
ab sepl System.err.println

set foldmethod=syntax

" ctrl+f create for loop
inoremap <C-f> for (int i = 0; i < ; i++) {<CR>}<esc>kf<la

" ,f surround current line with for loop
nnoremap <silent> <leader>f >>Ofor (int i = 0; i < ; i++) {<esc>jo}<esc>kkf<la

" ,f highlight lines and surround them with for
vnoremap <silent> <leader>f >`<Ofor (int i = 0; i < ; i++) {<esc>`>o}<esc>`<kf<la

" compile and run java files
nnoremap <silent> <leader>jc<CR> :!javac %<CR>
nnoremap <silent> <leader>jcj<CR> :!jcj %<CR>


" add filename
nmap <leader>fn HO/* <C-R>=expand("%:t")<CR> */<CR><esc>j

if exists("t:put_file_name")
	finish
endif
let t:put_file_name = 1
autocmd BufNewFile * :normal ,fn
source $HOME/.vim/after/ftplugin/c_java.vim
