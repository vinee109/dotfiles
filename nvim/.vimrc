"""""""""""" System Settings
filetype plugin on
set updatetime=100
let g:python3_host_prog = '/usr/local/bin/python3'

" By default use tabwidth = 2 spaces
set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2

" Map leader to ,
let mapleader = ","


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

set cursorline					" Highlight the current line

" Configure Airline
let g:airline_theme = 'material'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#ale#enabled = 1

" Configure Bufferline
let g:bufferline_echo = 0

"""""""""""" Editor
syntax on
set number				    	" Show line numbers
set autoindent					" Enable auto indenting

" Enable folding
set foldmethod=indent
set foldlevel=99

" Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Space to dismiss highlights
nnoremap <space> :nohlsearch<CR>

" Set shortcut for reloading all buffers
nnoremap <leader>r :bufdo e<CR>

" Map <C-f> to perform text search
nnoremap <C-f> :Ag<CR>


"""""""""""" Plugins
call plug#begin('~/.local/share/nvim/plugged')

" File Explorer and Navigation
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" Appearance
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kaicataldo/material.vim'
Plug 'bling/vim-bufferline'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'

" Linting
Plug 'w0rp/ale'

" Autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'zchee/deoplete-go', { 'do': 'make'}

" Javascript & React
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }

" Python
Plug 'zchee/deoplete-jedi'
Plug 'davidhalter/jedi-vim'

" Snippets
Plug 'Shougo/neosnippet.vim'

call plug#end()


"""""""""""" Split Screen
set splitright
set splitbelow

" ctrl+[hjkl] navigate to different split panes
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k


"""""""""""" FZF
" Map <C-p> to call FZF
nnoremap <C-p> :FZF<CR>

" Exclude files in .gitignore from search results
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'


"""""""""""" Jedi-Vim
let g:jedi#completions_enabled = 0


"""""""""""" Deoplete
let g:deoplete#enable_at_startup = 1
set completeopt-=preview

" Depoplete-jedi
let g:deoplete#sources#jedi#show_docstring = 1


"""""""""""" Snippets
let g:neosnippet#snippets_directory='~/.vim/snippets/'
let g:neosnippet#disable_runtime_snippets = {
    \ '_': 1
    \ }

imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)


"""""""""""" NerdTree
" Ctrl-b opens up the file explorer
map <C-b> :NERDTreeToggle<CR>

" Ignore certain patterns
let g:NERDTreeIgnore = ['^node_modules$']

"""""""""""" ALE (global settings)
let g:ale_fix_on_save = 1
