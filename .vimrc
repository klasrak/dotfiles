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

" PLUGINS
call plug#begin('~/.vim/bundle')

  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'w0rp/ale'
  Plug 'tomasr/molokai'
  Plug 'crusoexia/vim-monokai'
  Plug 'jeffkreeftmeijer/vim-numbertoggle'
  Plug 'Valloric/YouCompleteMe'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'scrooloose/nerdcommenter'
  Plug 'rking/ag.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'jlanzarotta/bufexplorer'
  Plug 'jiangmiao/auto-pairs'
  Plug 'janko-m/vim-test'

" #### Languages Syntax

  Plug 'pangloss/vim-javascript', {'for': ['javascript']}
  Plug 'othree/javascript-libraries-syntax.vim', {'for': ['javascript']}
  Plug 'posva/vim-vue'
  Plug 'othree/html5.vim'
  Plug 'kh3phr3n/python-syntax', {'for': 'python'}
  Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}
  Plug 'fisadev/vim-isort', {'for': ['python']}

call plug#end()

" SYNTAX
" Enable syntax highlighting
syntax on

" THEME
let g:monokai_term_italic = 1
let g:monokai_gui_italic = 1
colorscheme molokai

" SEARCH
" Highlight search term. Use :nohl to redraw screen and disable highlight
set hlsearch

" Make Ag search from your project root
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

" Enables Mouse.
set mouse=a

" Always shows the ruler (cursor position and etc)
set ruler

" Show matching brackets.
set showmatch

" Highlight cursor line
set cursorline

" Eable folding and set it to use the marker
set foldenable foldmethod=indent

" Change folding text
function! MyFoldText() " {{{
  let line = getline(v:foldstart)

  let nucolwidth = &fdc + &number * &numberwidth
  let windowwidth = winwidth(0) - nucolwidth - 3
  let foldedlinecount = v:foldend - v:foldstart

  " expand tabs into spaces
  let onetab = strpart('          ', 0, &tabstop)
  let line = substitute(line, '\t', onetab, 'g')
  let line = substitute(line, '^\(\s*\)\s\(\w\)', '\1➤ \2', '')

  let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
  let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
  return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()

" Settigns for specific filetype
augroup filetypedetect
  autocmd FileType vim setlocal foldmethod=marker
augroup END

" Make sure Vim returns to the same line when you reopen a file.
" Thanks, Steve Losh
augroup line_return
   au!
   au BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \     execute 'normal! g`"zvzz' |
      \ endif
augroup END

" Set VIM to use 256 colors
set t_Co=256

" Set termquicolors (Truecolor) for terminal, if supported
if (has("termguicolors"))
  set termguicolors
endif

" Highlight Trailing Whitespaces
match Error /\s\+$/

" PLUGIN CONFIGURATION
"
" JS
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1
let g:used_javascript_libs = 'vue,jquery,underscore'

" Python
let g:vim_isort_python_version = 'python3'

" ALE
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '➧'
highlight clear ALEErrorSign
highlight clear ALEWarningSign
highlight link ALEErrorSign WarningMsg
highlight link ALEWarningSign ModeMsg
" Sets ALE to use only flake8 and StandardJs
let g:ale_linters = {
\   'python': ['flake8'],
\   'javascript': ['standard'],
\}
let g:ale_fixers = {
\   'javascript': ['standard'],
\   'python': ['isort'],
\}
" Linting and automatic fixing on save
let g:ale_lint_on_save=1
let g:ale_fix_on_save=1

" YCM
" Start autocompletion after 4 chars
let g:ycm_min_num_of_chars_for_completion = 4
let g:ycm_min_num_identifier_candidate_chars = 4
let g:ycm_enable_diagnostic_highlighting = 0
" Don't show YCM's preview window [ I find it really annoying ]
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0

" NERDTress
" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
  exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
  exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

 call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
 call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
 call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
 call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
 call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
 call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
 call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
 call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
 call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
 call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
 call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
 call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
 call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

 nnoremap <leader>ft :NERDTreeToggle<cr>

" Auto Pairs
let g:AutoPairsFlyMode = 1
let g:AutoPairs = {'(':')', '[':']', '{':'}', "'":"'", '"':'"', '`':'`', '<': '>'}

" CtrlP
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|node_modules)$',
  \ 'file': '\v\.(pyc)$',
  \ }

" VIM-Test: Test suite runner "
"""""""""""""""""""""""""""""""
let test#strategy = 'asyncrun'
let test#python#runner = 'pytest'
let test#python#pytest#executable = 'pipenv run pytest'

nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>

nmap <silent> <leader>vtn :TestNearest -vv<CR>
nmap <silent> <leader>vtf :TestFile -vv<CR>
nmap <silent> <leader>vts :TestSuite -vv<CR>
nmap <silent> <leader>vtl :TestLast -vv<CR>
nmap <silent> <leader>vtv :TestVisit -vv<CR>
