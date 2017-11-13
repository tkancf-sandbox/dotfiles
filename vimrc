" Basic {{{1
"==============================================================================
" encoding
set encoding=utf-8

" file encofing
set fileencodings=utf-8,euc-jp,sjis,cp932,iso-2022-jp

let g:hoge = "hoge"

" Clipboard
"set clipboard&
set clipboard^=unnamedplus

" Mouse disable
set mouse=

" Backspace key settings
  " start :Pressing Backspace delete text that was previously inserted.
  " eol   :Pressing Backspace also remove EOL markers(\n or \r\n)
  " indent:Pressing Backspace also remove autoindent
set backspace=start,eol,indent

" Allow unsaved buffer hidden
set hidden

" Status line
set laststatus=2

" Cursor line
set cursorline

" 256 color
set t_Co=256

" swp output directory
if !filereadable(expand($HOME . '/.vim/tmp'))
    call system("mkdir" . " " . $HOME . "/.vim/tmp/")
endif
set directory=$HOME/.vim/tmp

" Enable matchit
if !exists('loaded_matchit')
  runtime macros/matchit.vim
endif

" Font setting
set guifont=ricty:h20

" Beep setting
  " Disable all beep
set visualbell t_vb=
set noerrorbells

" Tab setting
  " Expand TAB to Space
set expandtab
  " TAB characters that appear 2-Spaces-wide 
set tabstop=2
  " TAB characters(auto indent) that appear 2-Spaces-wide 
set shiftwidth=2
  " Sets the number of columns for a TAB
set softtabstop=2
  " Auto indent on
set autoindent
set smartindent

" Complete option setting
set completeopt=menu,preview

set list
set listchars=tab:>-,trail:.

" linux fcitx ime setting
function! ImInActivate()
  call system('fcitx-remote -c')
endfunction
inoremap <silent> <C-[> <ESC>:call ImInActivate()<CR>

" incsearch setting
set hlsearch
set incsearch
" double:Use twice the width of ASCII characters.
set ambiwidth=double

" Command line window height setting
set cmdwinheight=20

" Local vimrc
if filereadable(expand($HOME . '/.vimrc.local'))
  source $HOME/.vimrc.local
endif

"==========================================================================}}}1

" GUI{{{1
"==============================================================================
set guifont=Monospace
set guioptions-=m
set guioptions-=T
"==========================================================================}}}1

" Key map{{{1
"==============================================================================
nnoremap <ENTER> <Nop>
nnoremap s <Nop>
nnoremap <Space> <Nop>

" j, kで見た目通りに移動
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" Reload vimrc
nnoremap <F5> :<C-u>source $MYVIMRC<CR>

" Open vimrc
nnoremap <F4> :<C-u>tabedit $MYVIMRC<CR>

" Open help
nnoremap <F3> :<C-u>vertical belowright help<Space>
nnoremap <F2> :<C-u>tab help<Space>

" Save file
nnoremap <ENTER><ENTER> :<C-u>w<CR>

" highlight off
nnoremap <silent> <ESC><ESC> :<C-u>nohlsearch<CR>

" Change current directory.
nnoremap <silent> <Space>cd :<C-u>CD<CR>

" Create new tab
nnoremap <C-w>t :<C-u>tabnew<CR>
nnoremap <C-w><C-t> :<C-u>tabnew<CR>
nnoremap <ENTER>t :<C-u>tabfind 

" Change ; & :
noremap ;  :
noremap :  ;

" Ex-mode
nnoremap gQ Q
nnoremap Q <Nop>

" Insertmode
inoremap <C-l> <C-o>A

" Search selected strings visualmode
vnoremap * "zy:let @/ = '\V' . substitute(escape(@z, '\/'), '\n', '\\n', 'g')<CR>n

" Show registers
nnoremap ,g :<C-u>registers<CR>
"==========================================================================}}}1

" Command Short{{{1
"==============================================================================

"==========================================================================}}}1

" File type{{{1
"==============================================================================
augroup vimrc-filetype
  autocmd!
  " Go {{{
    autocmd BufRead,BufNewFile *.go setlocal noexpandtab
    autocmd BufRead,BufNewFile *.go nnoremap <Leader>ar :<C-u>GoRun<CR>
    autocmd BufRead,BufNewFile *.go nnoremap <Leader>r :<C-u>GoRun %<CR>
    autocmd BufRead,BufNewFile *.go nnoremap <Leader>d :<C-u>GoDoc<CR>
    autocmd BufRead,BufNewFile *.go nnoremap <Leader>i :<C-u>GoImport 
  " }}}
  " fold method for vimrc {{{
    autocmd BufRead,BufNewFile .vimrc set foldmethod=marker
  " }}}
augroup END
"==========================================================================}}}1

" Function {{{
"==============================================================================
" {{{  Easy change directory
" > vim-users.jp/Hack #69
command! -nargs=? -complete=dir -bang CD  call s:ChangeCurrentDir('<args>', '<bang>')
function! s:ChangeCurrentDir(directory, bang)
if a:directory == ''
    lcd %:p:h
else
    execute 'lcd' . a:directory
endif

if a:bang == ''
    pwd
endif
endfunction
" }}}

"{{{ Rename file
" > vim-users.jp/Hack #17
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))
"}}}

"{{{ In help file
function! KeymapInHelp()
  if &buftype == 'help'
    "echo "readonly modo!"
    nnoremap <buffer> u <C-d>
    nnoremap <buffer> i <C-u>
    nnoremap <buffer> o <C-o>
    nnoremap <buffer> p <C-]>
    nnoremap <buffer> j <C-e>
    nnoremap <buffer> k <C-y>
    nnoremap <buffer> <S-j> j
    nnoremap <buffer> <S-k> k
  else
"   echo "This file is not Read only FILE!!!!"
endif
endfunction
"}}}

" {{{ To Fix Japanese Markdown
augroup KeymapInHelp
  autocmd!
  autocmd BufReadPost,BufEnter * call KeymapInHelp()
augroup END


command! ChangeCharactersD2Ha call s:ChangeCharactersD2H()
function! s:ChangeCharactersD2H()
  %s/　/ /ge
  %s/！/!/ge
  %s/＃/#/ge
  %s/＄/$/ge
  %s/％/%/ge
  %s/＾/^/ge
  %s/＆/&/ge
  %s/＊/*/ge
  %s/（/(/ge
  %s/）/)/ge
  %s/\(^\s*\)ー/\1-/ge
  %s/＿/_/ge
  %s/＋/+/ge
  %s/＝/=/ge
  %s/｛/{/ge
  %s/｝/}/ge
  %s/｜/|/ge
  %s/＼/\\/ge
  %s/〜/~/ge
  %s/｀/`/ge
  %s/：/:/ge
  %s/；/;/ge
  %s/，/,/ge
  %s/．/./ge
  %s/＜/</ge
  %s/＞/>/ge
  %s/’/'/ge
  %s/”/"/ge
  %s/０/0/ge
  %s/１/1/ge
  %s/２/2/ge
  %s/３/3/ge
  %s/４/4/ge
  %s/５/5/ge
  %s/６/6/ge
  %s/７/7/ge
  %s/８/8/ge
  %s/９/9/ge
endfunction
" }}}


"===========================================================================}}}

" Plugin Load {{{
"==============================================================================
let s:vim_plug_url='https://github.com/junegunn/vim-plug'

if !filereadable(expand($HOME . '/.vim/vim-plug/plug.vim'))
    call system("git clone " . s:vim_plug_url . " " . $HOME . "/.vim/vim-plug/")
endif
source $HOME/.vim/vim-plug/plug.vim
call plug#begin($HOME . "/.vim/plugged")
"
"" Color
Plug 'vim-scripts/wombat256.vim'
Plug 'itchyny/lightline.vim'

"ctrlp
Plug 'ctrlpvim/ctrlp.vim' | Plug 'mattn/ctrlp-launcher'
Plug 'ctrlpvim/ctrlp.vim' | Plug 'sgur/ctrlp-extensions.vim'
Plug 'ctrlpvim/ctrlp.vim' | Plug 'tacahiroy/ctrlp-funky'
Plug 'ctrlpvim/ctrlp.vim' | Plug 'fisadev/vim-ctrlp-cmdpalette'

" Basics
Plug 'vim-jp/vimdoc-ja'
Plug 'cocopon/vaffle.vim'
Plug 'soramugi/auto-ctags.vim'
Plug 'thinca/vim-quickrun'
Plug 'glidenote/memolist.vim'
"Plug 'kana/vim-smartinput'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'kana/vim-operator-user' | Plug 'rhysd/vim-operator-surround'
Plug 'mattn/vim-fz'

" Complete&Snippets
Plug 'Shougo/neosnippet-snippets' "| Plug 'Shougo/neosnippet'

if has('lua')
"if has('lua')
  Plug 'Shougo/neocomplete.vim'
else
  Plug 'Shougo/neocomplcache.vim'
endif

" Languages
Plug 'slim-template/vim-slim', { 'for': 'slim' }
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'fatih/vim-go' , { 'for': 'go' }
"Plug 'plasticboy/vim-markdown' , { 'for': 'markdown' }
Plug 'aharisu/vim_goshrepl', {'for': 'scheme'}
Plug 'kannokanno/previm', {'for': 'markdown'}
Plug 'rust-lang/rust.vim', {'for': 'rust'}

" Others
Plug 'mattn/sonictemplate-vim'
Plug 'tyru/open-browser.vim'

" Twitter
Plug 'basyura/TweetVim'
Plug 'mattn/webapi-vim'
Plug 'basyura/twibill.vim'
Plug 'basyura/bitly.vim'

Plug 'irrationalistic/vim-tasks'
call plug#end()

"==========================================================================}}}1

" Plugin config {{{1
"==============================================================================
syntax enable
filetype plugin indent on
let s:plug = {
      \ "plugs": get(g:, 'plugs', {})
      \ }

function! s:plug.is_installed(name)
  return has_key(self.plugs, a:name) ? isdirectory(self.plugs[a:name].dir) : 0
endfunction
" {{{ Colorscheme
colorscheme wombat256mod
" }}}

" 'ctrlpvim/ctrlp.vim' {{{
nnoremap <C-p> <Nop>
nnoremap <silent> <Space>b :<C-u>CtrlPBuffer<CR>
nnoremap <silent> <Space>u :<C-u>CtrlPMRUFiles<CR>
nnoremap <silent> <Space>l :<C-u>CtrlPLine<CR>
nnoremap <silent> <Space>i :<C-u>CtrlP<CR>

let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix',  'mixed',
                         \'line', 'bookmarkdir', 'changes', 'cmdline']
let g:ctrlp_max_files  = 10000
let g:ctrlp_by_filename = 1
let g:ctrlp_max_depth = 20
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_use_caching = 1
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor\ --hidden
    let g:ctrlp_user_command = 'ag %s -i
          \ --ignore "*.gif"
          \ --ignore "*.png"
          \ --ignore "*.PNG"
          \ --ignore "*.jpg"
          \ --ignore "*.JPG"
          \ --ignore "*.ico"
          \ --ignore "*.app"
          \ --ignore "*.zip"
          \ --ignore "*.rar"
          \ --ignore "Applications/*"
          \ --ignore "Library/*"
          \ -g ""'

    let g:ctrlp_use_caching = 0

else
    let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/]\.(git|hg|svn)$',
      \ 'file': '\v\.(txt)$',
      \ 'link': 'some_bad_symbolic_links',
      \ }
endif
" }}}

" 'mattn/ctrlp-launcher' {{{
nnoremap <Space><Space> :<C-u>CtrlPLauncher<CR>
" }}}

" 'sgur/ctrlp-extensions.vim' {{{
nnoremap <Space>p :<C-u>CtrlPMenu<CR>
" }}}

" 'tacahiroy/ctrlp-funky' {{{
nnoremap <Space>f :<C-u>CtrlPFunky<CR>
" }}}

" 'fisadev/vim-ctrlp-cmdpalette' {{{
nnoremap <Space>c :<C-u>CtrlPCmdPalette<CR>
" }}}

" 'fatih/vim-go' {{{
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
set completeopt=menuone
" }}}

" 'glidenote/memolist.vim' {{{
let g:memolist_memo_suffix = "md"
let g:memolist_path = $HOME . "/memo/"
let g:memolist_memo_date = "%Y-%m-%d %H:%M"
" }}}

" 'vim-jp/vimdoc-ja' {{{
set helplang=ja,en
" }}}

" 'kannokanno/previm' {{{
"let g:previm_open_cmd = 'open -a Firefox'
augroup PrevimSettings
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END
" }}}

" 'thinca/vim-quickrun' {{{
let g:quickrun_config = {'*': {'hook/time/enable': '1'},}
nnoremap <Leader>q :<C-u>bw! \[quickrun\ output\]<CR>
" }}}

"{{{ 'Shougo/neocomplete'
if s:plug.is_installed("neocomplete.vim")
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_smart_case = 1
endif
"}}}

"{{{ 'Shougo/neocomplcache'
if s:plug.is_installed("neocomplcache.vim")
  let g:neocomplcache_enable_at_startup = 1
  let g:neocomplcache_enable_smart_case = 1
  let g:neocomplcache_min_syntax_length = 2
endif
"}}}

" {{{ 'Shougo/neosnippet'
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
" My snippets directory
let g:neosnippet#snippets_directory=$HOME . '/.vim/plugged/neosnippet-snippets/neosnippets/'
let g:neosnippet#snippets_directory=$HOME . '/.vim/snippets/'
" }}}

" 'soramugi/auto-ctags.vim' {{{
let g:auto_ctags = 1
let g:auto_ctags_directory_list = ['.git', '.svn']
"}}}

" 'cocopon/vaffle.vim'{{{
nnoremap - :<C-u>Vaffle<CR>
"}}}

" 'itchyny/lightline.vim'{{{
let g:lightline = { 'colorscheme': 'wombat' }
"}}}

" 'rhysd/vim-operator-surround'{{{
" operator mappings
map <silent>sa <Plug>(operator-surround-append)
map <silent>sd <Plug>(operator-surround-delete)
map <silent>sr <Plug>(operator-surround-replace)
" }}}

" 'rust-lang/rust.vim' {{{
let g:rustfmt_autosave = 1
" }}}
"==========================================================================}}}1

" vim:foldmethod=marker
