"""""""""""" System Settings
filetype plugin on
set updatetime=100
let g:python3_host_prog = '/usr/bin/python3'

if $VIM_PATH != ""
        let $PATH = $VIM_PATH
endif

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
let g:material_theme_style = 'darker'
colorscheme material

set cursorline					" Highlight the current line

" Configure Airline
let g:airline_theme = 'material'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#hunks#enabled = 0

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
Plug 'kaicataldo/material.vim',

" Git
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'folke/lsp-colors.nvim'

" Code
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-path'

" Trouble
Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim'

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

"""""""""""" NerdTree
" Ctrl-b opens up the file explorer
map <C-b> :NERDTreeToggle<CR>

" Ignore certain patterns
let g:NERDTreeIgnore = ['^node_modules$']
let g:NERDTreeShowHidden=1


"""""""""""" NerdTreeCommenter
let g:NERDDefaultAlign = 'left'


"""""""""""" Trouble
lua << EOF
require("trouble").setup {
    icons = false,
    fold_open = "▼",    -- icon use for open folds
    fold_closed = "▶",  -- icon used for closed folds
    signs = {
        -- icons / text used for a diagnostic
        error = "error",
        warning = "warn",
        hint = "hint",
        information = "info"
    },
    auto_open = true,     -- automatically open the list when you have diagnostics
    auto_close = true,    -- automatically close the list when you have no diagnostics
}

-- Don't use virtual text to display diagnostics.
-- Signs in the gutter + trouble is enough.
vim.diagnostic.config({
    virtual_text = false,
})

EOF

"""""""""""" LSP Config
lua << EOF
local opts = { noremap=true, silent=true }
local lsp_capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Keybindings
  --  K            Documentation
  --  <leader>d    Go to definition
  --  <space>rn    Rename
  --  <space>ca    Code action
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>d', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
end

-- Completion
local cmp = require 'cmp'
cmp.setup {
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }),
}

-- Go
require('lspconfig').gopls.setup {
        cmd = {'gopls', '-remote=auto'},
        on_attach = on_attach,
        flags = {
            -- Don't spam LSP with changes. Wait 100ms between each
            debounce_text_changes = 100,
        },
        capabilities = lsp_capabilities,
        init_options = {
          gofumpt = true,
          memoryMode = "DegradeClosed",
          staticcheck = true,
        }
}
EOF
