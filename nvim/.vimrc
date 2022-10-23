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


"""""""""""" Plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdcommenter'

" File Explorer and Navigation
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" Appearance
Plug 'nvim-lualine/lualine.nvim'
Plug 'arkav/lualine-lsp-progress'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'NvChad/nvim-colorizer.lua'
Plug 'marko-cerovac/material.nvim', {'commit': 'de33236e23cab880a1ab3d1cfdc828d3eedbddf8'}
Plug 'kyazdani42/nvim-web-devicons'

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
Plug 'folke/trouble.nvim'

call plug#end()


"""""""""""" Appearance (Color, Cursor, etc.)
if (has("termguicolors"))
  set termguicolors
endif

" Set up color theme
set background=dark
set cursorline					" Highlight the current line

lua << EOF
-- Configure colors
require'colorizer'.setup()

-- Configure Material theme
require('material').setup({
  lualine_style = 'default',
  custom_colors = {
    fg = '#DCE2E5',
    bg = '#080808',
  },
  custom_highlights = {
    CursorLineNr = { fg = '#89DFFF' },
  },
})
EOF
let g:material_style = "darker"
colorscheme material

lua << EOF
-- Configure lualine
local theme = require'lualine.themes.material-nvim'
theme.normal.a.bg = '#82aaff'

require('lualine').setup({
  options = {
       icons_enabled = false,
    theme = theme,
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_c = {'filename', 'lsp_progress'},
  },
})
EOF


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

" Map Ctrl+Shift+f to perform text search
nnoremap <CS-f> :Ag<CR>

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25


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
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git --ignore env --ignore __pycache__ -g ""'
let g:fzf_layout = { 'down': '~40%' }

set hidden


"""""""""""" NerdTree
" <leader>t opens up the file explorer for current file
map <leader>t :NERDTreeFind<CR>

" Ignore certain patterns
let g:NERDTreeIgnore = ['^node_modules$']
let g:NERDTreeShowHidden=1
let g:NERDTreeMinimalMenu=1

"""""""""""" NerdTreeCommenter
let g:NERDDefaultAlign = 'left'


"""""""""""" Trouble
lua << EOF

-- Configure lsp-colors used by trouble
require("lsp-colors").setup({
  Error = "#db4b4b",
  Warning = "#e0af68",
  Information = "#0db9d7",
  Hint = "#10B981"
})

-- Configure trouble styling
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
    auto_open = false,     -- automatically open the list when you have diagnostics
    auto_close = false,    -- automatically close the list when you have no diagnostics
    use_diagnostic_signs = false,
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
local flags = { debounce_text_changes=500 }
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
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>r', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
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
  flags = flags,
  capabilities = lsp_capabilities,
  init_options = {
    gofumpt = true,
    memoryMode = "DegradeClosed",
    staticcheck = true,
  }
}

function FormatAndImports(wait_ms)
    vim.lsp.buf.formatting_sync(nil, wait_ms)
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
    for _, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
            if r.edit then
                vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
            else
                vim.lsp.buf.execute_command(r.command)
            end
        end
    end
end

vim.api.nvim_create_autocmd('BufWritePre',{
  pattern="*.go",
  callback=function()
    FormatAndImports(1000)
  end,
})

-- Python
require('lspconfig').pyright.setup {
  on_attach = on_attach,
  flags = flags,
  capabilities = lsp_capabilities,
}

EOF


"""""""""""" Treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
   -- A list of parser names, or "all"
  ensure_insalled = { "go", "python" },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true,
  },
}
EOF
