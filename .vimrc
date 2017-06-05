let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Autoreload vimrc
autocmd! bufwritepost .vimrc source %
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif
set shell=bash

let mapleader = ","
noremap ; :

call plug#begin('~/.vim/plugged')

" NEW ONES
Plug 'airblade/vim-gitgutter'

" Plug 'flowtype/vim-flow'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
let g:jsx_ext_required = 0

Plug 'matze/vim-move'

Plug 'zhaocai/GoldenView.Vim'
let g:goldenview__enable_default_mapping = 0
nmap <silent><C-S> <Plug>GoldenViewSplit
nmap <silent><C-M> <Plug>GoldenViewSwitchMain

""""""""""""""""""""""""""""""

Plug 'ervandew/supertab'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
let NERDTreeIgnore = ['\.pyc$']

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'benekastah/neomake'
let g:neomake_python_python_exe = 'python3'
let g:neomake_javascript_eslint_custom_maker = {
  \ 'exe': 'eslint',
  \ 'args': ['--fix', '-f', 'compact'],
  \ 'errorformat': '%E%f: line %l\, col %c\, Error - %m,' .
  \ '%W%f: line %l\, col %c\, Warning - %m'
  \ }
let g:neomake_open_list = 2
let g:neomake_javascript_enabled_makers = ['eslint_custom']
let g:javascript_plugin_flow = 1

Plug 'mbbill/undotree'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'morhetz/gruvbox'
Plug 'ap/vim-css-color'
Plug 'tpope/vim-commentary'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }

Plug 'wavded/vim-stylus'
Plug 'cakebaker/scss-syntax.vim'
Plug 'kassio/neoterm'
Plug 'severin-lemaignan/vim-minimap'

Plug 'vim-scripts/Align'

" Add plugins to &runtimepath
call plug#end()

let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" tern
autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>
" tern
if exists('g:plugs["tern_for_vim"]')
  let g:tern_show_argument_hints = 'on_hold'
  let g:tern_show_signature_in_pum = 1
  autocmd FileType javascript setlocal omnifunc=tern#Complete
endif
set completeopt+=noinsert,noselect
set completeopt-=preview

hi Pmenu    gui=NONE    guifg=#c5c8c6 guibg=#373b41
hi PmenuSel gui=reverse guifg=#c5c8c6 guibg=#373b41

let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_completion_start_length = 1
set omnifunc=jedi#completions
let g:jedi#auto_initialization = 1
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_select_first = 0
let g:jedi#completions_enabled = 0
let g:jedi#force_py_version = 3
let g:jedi#smart_auto_mappings = 0
let g:jedi#show_call_signatures = 0
let g:jedi#max_doc_height = 100

colorscheme gruvbox
set background=dark

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

noremap <tab> :NERDTreeToggle<CR>

" Run neomake on every save
autocmd BufWritePost * call neomake#Make(1, [], function('s:Neomake_callback'))

" Callback for reloading file in buffer when eslint has finished and maybe has
" autofixed some stuff
function! s:Neomake_callback(options)
  if (a:options.status == 0)
    edit
  endif
endfunction

let g:neoterm_size = 10
nnoremap <silent> ,o :call neoterm#test#run('current')<cr>

function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()
nmap <leader>t :FZF<enter>

filetype plugin indent on

set expandtab
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
autocmd FileType python setlocal shiftwidth=2

set ignorecase
set smartcase

set backupdir=~/.bak
set directory=~/.tmp

set undofile
set undodir=~/.tmp/undodir
set undolevels=1000
set undoreload=10000
set hidden
set textwidth=0
set wrapmargin=0

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

function! ClipboardYank()
  call system('pbcopy', @@)
endfunction
function! ClipboardPaste()
  let @@ = system('pbpaste')
endfunction

noremap <Leader>[ :set nopaste<cr>
noremap <Leader>] :set paste<cr>
noremap <Leader>vi :tabe ~/.vimrc<CR>
noremap <Leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>
nnoremap <Leader>s :g//#<Left><Left>

function! Browser()
  let line = getline (".")
  let line = matchstr (line,"http[^  ]*")
  exec "!chrome ".line
endfunction
map <Leader>w :call Browser ()<CR>

function! DelEmptyLineAbove()
  if line(".") == 1
    return
  endif
  let l:line = getline(line(".") - 1)
  if l:line =~ '^\s*$'
    let l:colsave = col(".")
    .-1d
    silent normal! <C-y>
    call cursor(line("."), l:colsave)
  endif
endfunction

function! AddEmptyLineAbove()
  let l:scrolloffsave = &scrolloff
  " Avoid jerky scrolling with ^E at top of window
  set scrolloff=0
  call append(line(".") - 1, "")
  if winline() != winheight(0)
    silent normal! <C-e>
  endif
  let &scrolloff = l:scrolloffsave
endfunction

function! DelEmptyLineBelow()
  if line(".") == line("$")
    return
  endif
  let l:line = getline(line(".") + 1)
  if l:line =~ '^\s*$'
    let l:colsave = col(".")
    .+1d
    ''
    call cursor(line("."), l:colsave)
  endif
endfunction

function! AddEmptyLineBelow()
  call append(line("."), "")
endfunction

function! SetArrowKeysAsTextShifters()
  " normal mode
  nmap <silent> <Left> <<
  nmap <silent> <Right> >>
  nnoremap <silent> <Up> <Esc>:call DelEmptyLineAbove()<CR>
  nnoremap <silent> <Down>  <Esc>:call AddEmptyLineAbove()<CR>
  nnoremap <silent> <C-Up> <Esc>:call DelEmptyLineBelow()<CR>
  nnoremap <silent> <C-Down> <Esc>:call AddEmptyLineBelow()<CR>
  nnoremap <silent> <C-S-Right> <Esc>:RightAlign<CR>

  " visual mode
  vmap <silent> <Left> <
  vmap <silent> <Right> >
  vnoremap <silent> <Up> <Esc>:call DelEmptyLineAbove()<CR>gv
  vnoremap <silent> <Down>  <Esc>:call AddEmptyLineAbove()<CR>gv
  vnoremap <silent> <C-Up> <Esc>:call DelEmptyLineBelow()<CR>gv
  vnoremap <silent> <C-Down> <Esc>:call AddEmptyLineBelow()<CR>gv
  vnoremap <silent> <C-S-Right> <Esc>:RightAlign<CR>gv

  " insert mode
  imap <silent> <Left> <C-D>
  imap <silent> <Right> <C-T>
  inoremap <silent> <Up> <Esc>:call DelEmptyLineAbove()<CR>a
  inoremap <silent> <Down> <Esc>:call AddEmptyLineAbove()<CR>a
  inoremap <silent> <C-Up> <Esc>:call DelEmptyLineBelow()<CR>a
  inoremap <silent> <C-Down> <Esc>:call AddEmptyLineBelow()<CR>a
  inoremap <silent> <C-S-Right> <Esc>:RightAlign<CR>a

  " disable modified versions we are not using
  nnoremap  <S-Up>     <NOP>
  nnoremap  <S-Down>   <NOP>
  nnoremap  <S-Left>   <NOP>
  nnoremap  <S-Right>  <NOP>
  vnoremap  <S-Up>     <NOP>
  vnoremap  <S-Down>   <NOP>
  vnoremap  <S-Left>   <NOP>
  vnoremap  <S-Right>  <NOP>
  inoremap  <S-Up>     <NOP>
  inoremap  <S-Down>   <NOP>
  inoremap  <S-Left>   <NOP>
  inoremap  <S-Right>  <NOP>
endfunction

call SetArrowKeysAsTextShifters()

noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l

" Always show line numbers and current position. ALWAYS!
set ruler
set number

" SAVED MACROS
let @c = 'f>i classNames=€kb€kb={classNames.}i'

" make list-like commands more intuitive
function! CCR()
  let cmdline = getcmdline()
  if cmdline =~ '\v\C^(ls|files|buffers)'
    " like :ls but prompts for a buffer command
    return "\<CR>:b"
  elseif cmdline =~ '\v\C/(#|nu|num|numb|numbe|number)$'
    " like :g//# but prompts for a command
    return "\<CR>:"
  elseif cmdline =~ '\v\C^(dli|il)'
    " like :dlist or :ilist but prompts for a count for :djump or :ijump
    return "\<CR>:" . cmdline[0] . "j  " . split(cmdline, " ")[1] . "\<S-Left>\<Left>"
  elseif cmdline =~ '\v\C^(cli|lli)'
    " like :clist or :llist but prompts for an error/location number
    return "\<CR>:sil " . repeat(cmdline[0], 2) . "\<Space>"
  elseif cmdline =~ '\C^old'
    " like :oldfiles but prompts for an old file to edit
    set nomore
    return "\<CR>:sil se more|e #<"
  elseif cmdline =~ '\C^changes'
    " like :changes but prompts for a change to jump to
    set nomore
    return "\<CR>:sil se more|norm! g;\<S-Left>"
  elseif cmdline =~ '\C^ju'
    " like :jumps but prompts for a position to jump to
    set nomore
    return "\<CR>:sil se more|norm! \<C-o>\<S-Left>"
  elseif cmdline =~ '\C^marks'
    " like :marks but prompts for a mark to jump to
    return "\<CR>:norm! `"
  elseif cmdline =~ '\C^undol'
    " like :undolist but prompts for a change to undo
    return "\<CR>:u "
  else
    return "\<CR>"
  endif
endfunction
cnoremap <expr> <CR> CCR()

map <leader>a :execute "Ag " . expand("<cword>") <Bar> cw<CR>
