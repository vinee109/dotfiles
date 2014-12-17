" Vim filetype plugin file
" Language: C, Java
" Maps common to both C and java

" INSERT
" ctrl+y create if statement
inoremap <C-y> if () {<CR>}<esc>kf)i

" NORMAL
" ,i surround current line with if statement
nnoremap <silent> <leader>i >>Oif () {<esc>jo}<esc>kkf)i
" comment out current line
nnoremap <leader>c I//<esc>
" uncomment current line
nnoremap <leader>v ^2x
" add comment at end of current line
nnoremap <leader>b A<Tab><Tab><Tab><Tab>// 

" VISUAL
" ,i highlight lines and surround them with if
vnoremap <silent> <leader>i >`<Oif () {<esc>`>o}<esc>`<kf)i
" ,c highilight lines and comment them out
vnoremap <silent> <leader>c <esc>`<O/*<esc>`>o*/<esc>
" ,v highlight lines and uncomment them
vnoremap <silent> <leader>v <esc>`<dd<esc>`>dd<esc>
