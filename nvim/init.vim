" reset augroup
augroup MyAutoCmd
autocmd!
augroup END

" dein settings {{{1
"==============================================================================
let g:cache_home = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let g:config_home = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME
let s:dein_cache_dir = g:cache_home . '/dein'

" reset augroup
augroup MyAutoCmd
autocmd!
augroup END

if &runtimepath !~# '/dein.vim'
let s:dein_repo_dir = s:dein_cache_dir . '/repos/github.com/Shougo/dein.vim'

  " Auto Download
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
  endif

  " Load dein.vim
  execute 'set runtimepath^=' . s:dein_repo_dir
  endif

if dein#load_state(s:dein_repo_dir)
  call dein#begin(s:dein_cache_dir)
    call dein#add('Shougo/dein.vim')
    call dein#add('Shougo/deoplete.nvim')
    call dein#add('Shougo/denite.nvim')
  call dein#end()
  call dein#save_state()
endif

if has('vim_starting') && dein#check_install()
  call dein#install()
endif
  "===========================================================================}}}1

  " Other settings {{{1
  "==============================================================================
  set guifont=Ricty:h18
  colorscheme desert
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  set termguicolors
  set clipboard+=unnamedplus
  set ambiwidth=double
  "==========================================================================}}}1

  " Key map{{{1
  "==============================================================================
  " Leader key
  let mapleader=","

  " Create new tab
  nnoremap <C-w>t :<C-u>tabnew<CR>

  noremap ; :
  noremap : ;

  " Easy change directory
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

  " Change current directory.
  nnoremap <silent> <Space>cd :<C-u>CD<CR>

  "==========================================================================}}}1
  " vim:foldmethod=marker expandtab fdc=3 ft=vim ts=2 sw=2 sts=2:
