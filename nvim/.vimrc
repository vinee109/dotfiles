"""""""""""" System Settings
filetype plugin on
set updatetime=100
let g:python3_host_prog = '/usr/bin/python3'

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
nnoremap <C-F> :Ag<CR>


"""""""""""" Editor
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

"""""""""""" Plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdcommenter'

" File Explorer and Navigation
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" Appearance
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kaicataldo/material.vim', {'commit': '5aabe47'}  " Breaking changes were made after this commit so pinning to last working version

" Git
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'

" Code
Plug 'jiangmiao/auto-pairs'
Plug 'dense-analysis/ale' " Linting
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Autocomplete
Plug 'Shougo/neosnippet.vim' " Snippets

" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'zchee/deoplete-go', { 'do': 'make'}

" Javascript & React
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'leafgarland/typescript-vim'

" Python
Plug 'zchee/deoplete-jedi'
Plug 'davidhalter/jedi-vim'

" Productivity
Plug 'vimwiki/vimwiki'

call plug#end()


"""""""""""" Split Screen
set splitright
set splitbelow

" ctrl+[hjkl] navigate to different split panes
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k


"""""""""""" FZF
" Map <C-p> to call FZF
nnoremap <C-p> :FZF<CR>

" Exclude files in .gitignore from search results
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
let g:fzf_layout = { 'down': '~40%' }

set hidden


"""""""""""" Jedi-Vim
let g:jedi#completions_enabled = 0


"""""""""""" vim-go
" Configure syntax highlighting specific for go
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

" autocomplete
let g:go_def_mode='gopls'
" linting
let g:go_metalinter_command = 'gopls'

" Configure gopls
let g:go_gopls_staticcheck = v:true
let g:go_gopls_gofumpt = v:true
let g:go_gopls_settings = {'memoryMode': 'DegradeClosed'}

nnoremap <leader>u :GoReferrers<CR>
"""""""""""" Deoplete
let g:deoplete#enable_at_startup = 1
set completeopt-=preview

" Depoplete-jedi
let g:deoplete#sources#jedi#show_docstring = 1

" Deoplete-go
let g:deoplete#sources#go#gocode_binary = '$GOPATH/bin/gocode'

call deoplete#custom#option('num_processes', 4) " https://github.com/carlitux/deoplete-ternjs/issues/88

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
let g:NERDTreeShowHidden=1


"""""""""""" NerdTreeCommenter
let g:NERDDefaultAlign = 'left'


"""""""""""" ALE (global settings)

" Disable gopls' diagnostics reporting.
let g:go_diagnostics_level = 0
let g:go_highlight_diagnostic_errors = 0
let g:go_highlight_diagnostic_warnings = 0

let g:ale_open_list = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_linters = {'go': ['gopls']}
let g:ale_fix_on_save = 0
nmap <silent> <leader>z :ALENextWrap<cr>
let $USE_SYSTEM_GO=1

let g:ale_go_gopls_init_options = {'staticcheck': v:true, 'gofumpt': v:true, 'memoryMode': 'DegradeClosed'}
" Share vim-go's existing gopls session instead of starting a new one.
let g:ale_go_gopls_options = '-remote=auto'

"""""""""""" Vim Wiki
let g:vimwiki_list = [{'path': '~/notes/'}]
