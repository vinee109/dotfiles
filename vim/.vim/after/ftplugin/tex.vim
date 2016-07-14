" Vim filetype plugin file
" Language: LaTex
"
command! T w | !latex %

" NORMAL
" comment out current line
nnoremap <leader>c I%%%<esc>
" uncomment current line
nnoremap <leader>v ^3x
" VISUAL
" ,c highilight lines and comment them out
vnoremap <silent> <leader>c <esc>`<O\iffalse<esc>`>o\fi<esc>
" ,v highlight lines and uncomment them
vnoremap <silent> <leader>v <esc>`<dd<esc>`>dd<esc>

setlocal textwidth=80
