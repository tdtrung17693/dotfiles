"======================================================================"
"      ___                       ___           ___           ___       "
"     /\__\          ___        /\__\         /\  \         /\  \      "
"    /:/  /         /\  \      /::|  |       /::\  \       /::\  \     "
"   /:/  /          \:\  \    /:|:|  |      /:/\:\  \     /:/\:\  \    "
"  /:/__/  ___      /::\__\  /:/|:|__|__   /::\~\:\  \   /:/  \:\  \   "
"  |:|  | /\__\  __/:/\/__/ /:/ |::::\__\ /:/\:\ \:\__\ /:/__/ \:\__\  "
"  |:|  |/:/  / /\/:/  /    \/__/~~/:/  / \/_|::\/:/  / \:\  \  \/__/  "
"  |:|__/:/  /  \::/__/           /:/  /     |:|::/  /   \:\  \        "
"   \::::/__/    \:\__\          /:/  /      |:|\/__/     \:\  \       "
"    ~~~~         \/__/         /:/  /       |:|  |        \:\__\      "
"                               \/__/         \|__|         \/__/      "
"                                                                      "
"======================================================================"

set nocompatible " be IMproved


set modelines=0

" completion {{{
set wildmode=longest,list,full
set wildmenu
set wildignorecase
" }}}

" maintain undo history {{{
set history=500
set undofile
set undodir=~/.vim/undo
set noswapfile
" }}}

" tab settings {{{
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent
set expandtab
" }}}

" case insensitive search {{{
set ignorecase
set smartcase
set infercase
" }}}

" make backspace behave in a sane manner {{{
set backspace=indent,eol,start
" }}}

" searching settings {{{
set hlsearch
set incsearch
" }}}


" the /g flag on :s substitutions by default {{{
set gdefault
" }}}


" syntax highlighting {{{
syntax on
filetype on
filetype plugin on
filetype plugin indent on

" stop unnecessary rendering
set lazyredraw

" show line numbers
set number

" no folding
set foldlevel=99
set foldminlines=99

" remap close normal mode
inoremap jj <ESC>

" }}}

" PLUGINS {{{
execute pathogen#infect()



" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
set omnifunc=syntaxcomplete#Complete
" Enable heavy omni completion.
"if !exists('g:neocomplete#sources#omni#input_patterns')
"  let g:neocomplete#sources#omni#input_patterns = {}
"endif

cnoremap cd. lcd %:p:h
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>
inoremap jj <ESC>
imap <C-Return> <CR><CR><C-o>k<Tab>

" Tagbar {{{
nmap <F8> :TagbarToggle<CR>
" }}}

" YouCompleteMe {{{
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
" }}}
" Statusline (Lightline) {{{
set laststatus=2
  let g:lightline = {
    \ 'colorscheme': 'seoul256',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste'],
    \             [ 'filename', 'readonly', 'fugitive' ] ],
    \   'right': [ [ 'percent', 'lineinfo' ],
    \              [ 'fileencoding', 'filetype' ],
    \              [ 'fileformat', 'syntastic' ] ]
    \ },
    \ 'component_function': {
    \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
    \   'readonly': 'ReadOnly',
    \   'fugitive': 'Git',
    \   'filetype': 'Type',
    \   'fileformat' : 'Format',
    \   'fileencoding': 'Encoding'
    \ },
    \ 'component_expand': {
    \   'syntastic': 'SyntasticStatuslineFlag',
    \ },
    \ 'component_type': {
    \   'syntastic': 'error',
    \ },
    \ 'separator': { 'left': '▓▒░', 'right': '░▒▓' },
    \ 'subseparator': { 'left': '▒', 'right': '░' }
    \ }

function! Mod()
    return &ft =~ 'help\|vimfiler' ? '' : &modified ? '»' : &modifiable ? '' : ''
endfunction

function! ReadOnly()
    return &ft !~? 'help\|vimfiler' && &readonly ? '×' : ''
endfunction

function! Git()
    if &ft !~? 'help\|vimfiler' && exists("*fugitive#head")
        return fugitive#head()
endif
    return ''
endfunction

function! Name()
    return ('' != WizMod() ? WizMod() . ' ' : '') .
      \ ('' != expand('%:t') ? expand('%:t') : '[none]')
endfunction

function! Type()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : '') : ''
endfunction

function! Format()
    return ''
endfunction

function! Encoding()
    return winwidth(0) > 70 ? (strlen(&fenc) ? &enc : &enc) : ''
endfunction

"Credit joshdick
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif


set background=dark " for the dark version
" set background=light " for the light version
let g:one_allow_italics = 1
colorscheme one

" }}}
