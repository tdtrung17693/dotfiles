" maintain undo history {{{
set history=500
set undofile
set undodir=~/.vim/undo
set noswapfile
" }}}

" Set clipboard {{{
set clipboard+=unnamed
" }}}


set termguicolors
let mapleader = ','
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
syntax enable
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

hi NonText guifg=bg

set rtp+=~/.fzf


filetype plugin indent off

" Plugin Manager
call plug#begin('~/.vim/plugged')
Plug 'nanotech/jellybeans.vim'
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-grepper'
Plug 'janko-m/vim-test'
Plug 'sgur/vim-editorconfig'
Plug 'tomtom/tcomment_vim'
Plug 'scrooloose/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'itchyny/lightline.vim'
Plug 'shime/vim-livedown'
Plug 'mattn/emmet-vim'
Plug 'derekwyatt/vim-scala'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'easymotion/vim-easymotion'

call plug#end()

" End Plugin Manager

colorscheme jellybeans
filetype plugin indent on

" Miscellaneous
set gcr=a:block
" mode aware cursor
set gcr+=o:hor50-Cursor
set gcr+=n:Cursor
set gcr+=i-ci-sm:InsertCursor
set gcr+=r-cr:ReplaceCursor-hor20
set gcr+=c:CommandCursor
set gcr+=v-ve:VisualCursor

set gcr+=a:blinkon0

hi InsertCursor  ctermfg=15 guifg=#fdf6e3 ctermbg=37  guibg=#2aa198
hi VisualCursor  ctermfg=15 guifg=#fdf6e3 ctermbg=125 guibg=#d33682
hi ReplaceCursor ctermfg=15 guifg=#fdf6e3 ctermbg=65  guibg=#dc322f
hi CommandCursor ctermfg=15 guifg=#fdf6e3 ctermbg=166 guibg=#cb4b16
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
autocmd FileType json syntax match Comment +\/\/.\+$+

" Minpac Custom CMD
command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()
command! PackStatus packadd minpac | source $MYVIMRC | call minpac#status()

au BufRead,BufNewFile *.sbt set filetype=scala
" coc

function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

" Autoformat, coc-prettier is required
command! -nargs=0 Prettier :CocCommand prettier.formatFile
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Use C to open coc config
call SetupCommandAbbrs('C', 'CocConfig')

" Use <C-l> to trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)
" Use <C-j> to select text for visual text of snippet.
vmap <C-j> <Plug>(coc-snippets-select)
" Use <C-j> to jump to forward placeholder, which is default
let g:coc_snippet_next = '<c-j>'
" Use <C-k> to jump to backward placeholder, which is default
let g:coc_snippet_prev = '<c-k>'

"s not set, TextEdit might fail.
set hidden

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)


" Add diagnostic info for https://github.com/itchyny/lightline.vim
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \ },
      \ 'component': {
      \ }
      \ }

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR> 
" fzf
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

nnoremap <leader><c-f> :Files<CR>
function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <Leader><Enter> :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })<CR>

" ale
let g:ale_linters = {
\  'c': []
\}
" nerdtree
map <C-n> :NERDTreeToggle<CR>

" easymotion
let g:EasyMotion_do_mapping = 0
nmap e <Plug>(easymotion-overwin-f)
nmap E <Plug>(easymotion-overwin-f2)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

function! OpenFloatTerm()
    " border window
    let height = float2nr((&lines - 2) / 1.5)
    let row = float2nr((&lines - height) / 2)
    let width = float2nr(&columns / 1.5)
    let col = float2nr((&columns - width) / 2)
    let border_opts = {
        \ 'relative': 'editor',
        \ 'row': row - 2,
        \ 'col': col - 2 ,
        \ 'width': width + 4,
        \ 'height': height + 4,
        \ 'style': 'minimal'
    \ }

    let border_buf = nvim_create_buf(v:false, v:true)
    let s:border_win = nvim_open_win(border_buf, v:true, border_opts)
    
    " main window
    let opts = {
        \ 'relative': 'editor',
        \ 'row': row,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
    \ }

    let buf = nvim_create_buf(v:false, v:true)
    let win = nvim_open_win(buf, v:true, opts)

    autocmd TermClose * ++once :q | call nvim_win_close(s:border_win, v:true)
    terminal
    startinsert
endfunction
