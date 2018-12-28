"""""""""""" System Settings
filetype plugin on
set updatetime=100
let g:python3_host_prog = '/usr/local/bin/python3'


" By default use tabwidth = 2 spaces
set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2


"""""""""""" Appearance (Color, Cursor, etc.)
" Enable true colors - taken from setup in https://github.com/kaicataldo/material.vim
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
  set termguicolors
endif

" Set up color theme
set background=dark
colorscheme material
let g:material_theme_style = 'dark'
let g:airline_theme = 'material'

set cursorline					" Highlight the current line


"""""""""""" Editor
syntax on
set number					" Show line numbers
set autoindent					" Enable auto indenting

" Enable folding
set foldmethod=indent
set foldlevel=99

" Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e


"""""""""""" Plugins
call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'kaicataldo/material.vim'
Plug 'Shougo/neosnippet.vim'
Plug 'w0rp/ale'

call plug#end()


"""""""""""" Mappings
" Swap directions of j and k movement keys
" j - moves cursor up one line
" k - moves cursor down one line
nnoremap j k
nnoremap k j


"""""""""""" Split Screen
set splitright
set splitbelow

" ctrl+[hjkl] navigate to different split panes
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k


"""""""""""" Ctrl P
" Exclude files in .gitignore from search results
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']


"""""""""""" Deoplete
let g:deoplete#enable_at_startup = 1


"""""""""""" Snippets
let g:neosnippet#snippets_directory='~/.vim/snippets/'
let g:neosnippet#disable_runtime_snippets = {
    \ '_': 1
    \ }

imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
