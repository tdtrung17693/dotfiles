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


" remove trailing whitespaces and ^M chars
autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

let mapleader = ","
let g:mapleader = ","

vnoremap <silent> <leader>y :w !xsel -i -b<CR>
nnoremap <silent> <leader>y V:w !xsel -i -b<CR>
nnoremap <silent> <leader>p :silent :r !xsel -o -b<CR>

" COMMANDS {{{
" json pretty print
command J :%!python -mjson.tool

" remove trailing white space
command Nows :%s/\s\+$//

" remove blank lines
command Nobl :g/^\s*$/d

" toggle spellcheck
command Spell :setlocal spell! spell?

" make current buffer executable
command Chmodx :!chmod a+x %
" }}}


" INTERFACE {{{
" show matching brackets/parenthesis {{{
set showmatch
" }}}

" syntax highlighting {{{
syntax on
filetype on
filetype plugin indent on

" stop unnecessary rendering
set lazyredraw

" show line numbers
set number

" no folding
set foldlevel=99
set foldminlines=99

" }}}

" PLUGINS {{{

" load pathogen
execute pathogen#infect()

" colorscheme {{{
let base16colorspace=256
color base16-darktooth
hi LineNr term=bold cterm=NONE ctermfg=244 ctermbg=NONE
" }}}

" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
highlight SyntasticErrorSign ctermfg=red ctermbg=237
highlight SyntasticWarningSign ctermfg=yellow ctermbg=237
highlight SyntasticStyleErrorSign ctermfg=red ctermbg=237
highlight SyntasticStyleWarningSign ctermfg=yellow ctermbg=237

" git gutter
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
let g:gitgutter_diff_args = '-w'
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = ':'
let g:gitgutter_max_signs = 1500
highlight clear SignColumn
highlight GitGutterAdd ctermfg=green ctermbg=0
highlight GitGutterChange ctermfg=yellow ctermbg=0
highlight GitGutterDelete ctermfg=red ctermbg=0
highlight GitGutterChangeDelete ctermfg=red ctermbg=0

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
" }}}