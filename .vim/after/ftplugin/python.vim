" Vim filetype plugin file
" Language: python

set expandtab
set smarttab

" ctrl+[yf] create if/for statement
inoremap <C-y> if :<C-o>i
inoremap <C-f> for :<C-o>i
" Prevent auto unindent for comments
inoremap # X<C-h>#

nnoremap <silent> <leader>i >>Oif :<C-o>i
nnoremap <silent> <leader>f >>Ofor :<C-o>i

" ,[if] highlight lines and surround them with if/for
vnoremap <silent> <leader>i >`<Oif :<esc><<f:i
vnoremap <silent> <leader>f >`<Ofor :<esc><<f:i

" comment out current line
nnoremap <leader>c I# <esc>
" uncomment current line
nnoremap <leader>v ^2x
" add comment at end of current line
nnoremap <leader>b A<Tab><Tab><Tab><Tab># 

set foldmethod=indent
