" Author: Danilo Augusto
" Source: https://github.com/klasrak/dotfiles.git
"
" LEADER KEY
let mapleader=","


" COMPATIBILITY
" Set 'nocompatible' to avoid unexpected things that your distro might have
set nocompatible
set t_ut=


" BUNDLE
" Automatically download vim-plug if it doesn't exist
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" Configure vim-plug
call plug#begin('~/.vim/bundle')

  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  Plug 'vim-syntastic/syntastic'
  Plug 'w0rp/ale'
  Plug 'tomasr/molokai'
  Plug 'jeffkreeftmeijer/vim-numbertoggle'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'vim-scripts/AutoComplPop'
  Plug 'Raimondi/delimitMate'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'scrooloose/nerdcommenter'
  Plug 'rking/ag.vim'
  Plug 'sheerun/vim-polyglot'

call plug#end()


" SYNTAX
" Enable syntax highlighting
syntax on


" SEARCH
" Highlight search term. Use :nohl to redraw screen and disable highlight
set hlsearch


" Make Ag search from yout project root
let g:ag_working_path_mode="r"


" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase


" AUTO INDENTATION
" Enable auto indentation with 'spaces' instead of 'tabs'
set smartindent
set expandtab
set softtabstop=2
set shiftwidth=2


" MOVING BETWEEN FILES
" Set 'hidden' if you wawnt to open a new file inside the same buffer without
" the need to save it first (if there's any unsaved changes)
set hidden


" REMEMBER THINGS
" Tell vim to remember certain things when we exit
" '10  : marks will be remembered for up to 10 previously edited files
" "100 : will save up to 100 lines for each register
" :20  : up to 20 lines of command-line history will be remembered
" %    : saves and restores the buffer list
" n... : where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END


" BACKUP
" Disable all backup files, never used them
set nobackup
set nowritebackup
set noswapfile


" SYNTASTIC
" Syntastic is a syntax checking plugin for Vim that runs files through
" external syntax checkers and displays any resulting errors to the user.
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Configure Standard JS as default linter
let g:syntastic_javascript_checkers = ['standard']


"ALE
"This sets ALE to use Standard JS as your only linter and fixer for javascript
"files and so prevents conflicts with eslint
let g:ale_linters = {
\   'javascript': ['standard'],
\}
let g:ale_fixers = {'javascript': ['standard']}


" Linting and automatic fixing on save
let g:ale_lint_on_save=1
let g:ale_fix_on_save=1


" COLOR SCHEME
colorscheme molokai


" FONT
set guifont='Fira\ Code\ iScript'
set antialias


" ENCODING
set encoding=utf-8


" COMMAND LINE
" Enhanced command line completion
set wildmenu


" Complete files like a shell
set wildmode=list:longest


" SEARCH
" Vim will start searching as you type
set incsearch


" FILE NUMBERS
" Enable relative and absolute file numbers
set number relativenumber


" WRAP
" Stop wrapping long lines
set nowrap


" AUTORELOAD
" Automatically reload buffers when file changes
set autoread


" PLUGINS CONFIGURATIONS


" CtrlP
let g:ctrl_map = '<c-p>'
let g:ctrl_cmd = 'CtrlP'


" Syntastic
nnoremap <leader>st :SyntasticToggleMode<cr>


" NERDtree
nnoremap <leader>ft :NERDTreeToggle<cr>