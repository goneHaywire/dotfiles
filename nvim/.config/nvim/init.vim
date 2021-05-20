set nocompatible

" Turn on syntax highlighting.
syntax on

" Set default shell to zsh
set shell=/bin/zsh

" Disable the default Vim startup message.
set shortmess+=I

" Show line numbers.
set number

if (has("termguicolors"))
	set termguicolors
endif

" Set leader to <Space>
let mapleader = " "

" This enables relative line numbering mode. With both number and
" relativenumber enabled, the current line shows the true line number, while
" all other lines (above and below) are numbered relative to the current line.
" This is useful because you can tell, at a glance, what count is needed to
" jump up or down to a particular line, by {count}k to go up or {count}j to go
" down.
set relativenumber

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
" shown in any window) that has unsaved changes. This is to prevent you from "
" forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
" hidden buffers helpful enough to disable this protection. See `:help hidden`
" for more information on this.
set hidden

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Enable searching as you type, rather than waiting till you press enter.
set incsearch

inoremap jj <Esc>

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.
set mouse+=a

" Try to prevent bad habits like using the arrow keys for movement. This is
" not the only possible bad habit. For example, holding down the h/j/k/l keys
" for movement, rather than using more efficient movement commands, is also a
" bad habit. The former is enforceable through a .vimrc, while we don't know
" how to prevent the latter.
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use j"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use l"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use j"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use l"<CR>

" Use system clipboard
set clipboard=unnamedplus

set encoding=utf-8
filetype plugin indent on
set spell spelllang=en_us

" Zsh-like suggestion navigation
set wildmenu
set wildmode=full

" Increase history capacity
set history=200

" Set font size
set guifont=32

" Set keybinds for navigating buffers
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" expand %% to %:h in command line mode
cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Folding
set foldmethod=syntax
set foldcolumn=1
let javaScript_fold=1
set foldlevelstart=99

" --------------------------------------------------------------------------------
"############################## Plugin Section ###################################
" --------------------------------------------------------------------------------
call plug#begin("~/.vim/plugged")

" --------------------------------------------------------------------------------
" Theme
" --------------------------------------------------------------------------------
Plug 'kaicataldo/material.vim', { 'branch': 'main' } 

let g:material_terminal_italics = 1
let g:material_theme_style = 'palenight'

" --------------------------------------------------------------------------------
" Emmet
" --------------------------------------------------------------------------------
Plug 'mattn/emmet-vim'

" --------------------------------------------------------------------------------
" Tag autorename
" --------------------------------------------------------------------------------
Plug 'AndrewRadev/tagalong.vim'

" --------------------------------------------------------------------------------
" Commentary
" --------------------------------------------------------------------------------
Plug 'tpope/vim-commentary'

Plug 'alvan/vim-closetag'

" --------------------------------------------------------------------------------
" Prettier
" --------------------------------------------------------------------------------
Plug 'prettier/vim-prettier'
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0

" --------------------------------------------------------------------------------
" Syntax highlighting
" --------------------------------------------------------------------------------
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'jonsmithers/vim-html-template-literals'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

Plug 'Yggdroot/indentLine'

" --------------------------------------------------------------------------------
" NERDTree
" --------------------------------------------------------------------------------
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'

let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''

" Autoclose if NERDTree is the only thing open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Toggle
nnoremap <silent> <C-b> :NERDTreeToggle<CR>

" --------------------------------------------------------------------------------
" Telescope Fuzzy Finder
" --------------------------------------------------------------------------------
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

nnoremap <C-p> :Telescope find_files<CR>
nnoremap <Leader>fg :Telescope live_grep<CR>
nnoremap <Leader>fb :Telescope buffers<CR>
nnoremap <Leader>fh :Telescope help_tags<CR>
nnoremap <Leader>fl :Telescope git_files<CR>
"let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" --------------------------------------------------------------------------------
" Ale
" --------------------------------------------------------------------------------
Plug 'dense-analysis/ale'

let g:ale_fixers = {
\	'html': ['prettier'],
\	'css': ['stylelint'],
\	}
let g:ale_linters = {
\	'html': ['htmlhint'],
\	'css': ['stylelint'],
\	'javascript': ['eslint'],
\	}
" let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1

" --------------------------------------------------------------------------------
" Airline
" --------------------------------------------------------------------------------
Plug 'vim-airline/vim-airline'

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" --------------------------------------------------------------------------------
" LSP
" --------------------------------------------------------------------------------
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
" --------------------------------------------------------------------------------
" Vim Fugitive
" --------------------------------------------------------------------------------
Plug 'tpope/vim-fugitive'

nmap <leader>gf :diffget //2<CR>
nmap <leader>gj :diffget //3<CR>
nmap <leader>gs :G<CR>

call plug#end()

" --------------------------------------------------------------------------------
"############################# Plugin Config Section #############################
" --------------------------------------------------------------------------------
" LSP
" --------------------------------------------------------------------------------
inoremap <expr> <Tab>	pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
set omnifunc=v:lua.vim.lsp.omnifunc

" set shortmess+=c
:lua << EOF
   local nvim_lsp = require('lspconfig')
 
   local on_attach = function(client, bufnr)
     require('completion').on_attach()
 
     local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
     local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
 
     -- Mappings
     local opts = { noremap=true, silent=true }
     buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
     buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
     buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
     buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
     buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
     buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
     buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
     buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
     buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
     buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
     buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
     buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
     buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
     buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
     buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
 
     -- Set some keybinds conditional on server capabilities
     if client.resolved_capabilities.document_formatting then
         buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
     elseif client.resolved_capabilities.document_range_formatting then
         buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
     end
 
     -- Set autocommands conditional on server_capabilities
     if client.resolved_capabilities.document_highlight then
         require('lspconfig').util.nvim_multiline_command [[
         :hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
         :hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
         :hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
         augroup lsp_document_highlight
             autocmd!
             autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
             autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
         augroup END
         ]]
     end
   end
 
   local servers = {'pyright', 'tsserver'}
   for _, lsp in ipairs(servers) do
     nvim_lsp[lsp].setup {
       on_attach = on_attach,
     }
   end
EOF
" --------------------------------------------------------------------------------
" Theme
" --------------------------------------------------------------------------------
colorscheme material
