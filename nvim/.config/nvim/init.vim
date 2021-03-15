set nocompatible

" Turn on syntax highlighting.
syntax on

" Disable the default Vim startup message.
set shortmess+=I

" Show line numbers.
set number

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

"##### Plugin Section
call plug#begin("~/.vim/plugged")

" Theme
" Plug 'dracula/vim'
" Plug 'hzchirs/vim-material'
Plug 'kaicataldo/material.vim', { 'branch': 'main' } 

" Emmet
Plug 'mattn/emmet-vim'

" Tag autorename
Plug 'AndrewRadev/tagalong.vim'

" Commentary
Plug 'tpope/vim-commentary'

" Code Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver']

" Syntax highlighting
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'jonsmithers/vim-html-template-literals'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

Plug 'Yggdroot/indentLine'

" NERDTree
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'

" Fuzzy Finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() --all } }
Plug 'junegunn/fzf.vim'

call plug#end()

" Plugin Config Section
if (has("termguicolors"))
	set termguicolors
endif
syntax enable

" Theme ----------------------------------
" set background=dark
" colorscheme dracula
colorscheme material
let g:material_theme_style = 'ocean'

" NERDTree ----------------------------------
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''

" Autoclose if NERDTree is the only thing open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Toggle
nnoremap <silent> <C-b> :NERDTreeToggle<CR>

" Fuzzy Finder ---------------------------------
nnoremap <C-p> :FZF<CR>
let g:fzf_action = {
	\ 'ctrl-t': 'tab split',
	\ 'ctrl-s': 'split',
	\ 'ctrl-v': 'vsplit'
	\}
" let $FZF_DEFAULT_COMMAND = 'ag -g ""'
