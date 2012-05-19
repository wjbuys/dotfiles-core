"{{{ Plugin bundles (managed with vim-update-bundles)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bundle: Lokaltog/vim-powerline
" Bundle: behaghel/vim-scala
" Bundle: benmills/vimux
" Bundle: claco/jasmine.vim
" Bundle: gregsexton/gitv
" Bundle: kana/vim-textobj-user
" Bundle: kchmck/vim-coffee-script
" Bundle: kien/ctrlp.vim
" Bundle: matchit.zip
" Bundle: mattn/gist-vim
" Bundle: michaeljsmith/vim-indent-object
" Bundle: mileszs/ack.vim
" Bundle: nelstrom/vim-textobj-rubyblock
" Bundle: scrooloose/nerdtree
" Bundle: searchfold.vim
" Bundle: timcharper/textile.vim
" Bundle: tpope/vim-abolish
" Bundle: tpope/vim-bundler
" Bundle: tpope/vim-cucumber
" Bundle: tpope/vim-endwise
" Bundle: tpope/vim-fugitive
" Bundle: tpope/vim-haml
" Bundle: tpope/vim-rails
" Bundle: tpope/vim-rake
" Bundle: tpope/vim-repeat
" Bundle: tpope/vim-surround
" Bundle: tpope/vim-unimpaired
" Bundle: vim-ruby/vim-ruby
" Bundle: wikipedia.vim
" Static: guard
"}}}

"{{{ Pre pathogen load
"
" These settings need to hapen before pathogen is invoked:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off


" Use pathogen for managing plugins under .vim/bundle
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
"}}}

"{{{ Post pathogen load, pre plugin load
"
" These settings need to happen before plugins are loaded:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" NERDTree configuration
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
let NERDQuitOnOpen=1

" Tagbar Scala support
let g:tagbar_type_scala = {
    \ 'ctagstype' : 'Scala',
    \ 'kinds'     : [
        \ 'p:packages:1',
        \ 'V:values',
        \ 'v:variables',
        \ 'T:types',
        \ 't:traits',
        \ 'o:objects',
        \ 'a:aclasses',
        \ 'c:classes',
        \ 'r:cclasses',
        \ 'm:methods'
    \ ]
\ }

" Disable AlignMaps (pollutes <Leader> mappings horribly).
let g:loaded_AlignMapsPlugin = "disabled"
let g:loaded_cecutil = "disabled"

" POWERLINE!
let g:Powerline_symbols = 'fancy'

" Ctrlp configuration
let g:ctrlp_map = '<leader>/'

" Enable syntastic syntax checking
let g:syntastic_enable_signs=1
let g:syntastic_quiet_warnings=1

" gist-vim defaults
if has("mac")
  let g:gist_clip_command = 'pbcopy'
elseif has("unix")
  let g:gist_clip_command = 'xclip -selection clipboard'
endif
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" Use ack-grep for searching
let g:ackprg="ack-grep -H --nocolor --nogroup --column"


" Enable syntax highlighting, plugin loading from runtimepath:
syntax on
filetype plugin indent on

"}}}

"{{{ Post bundle/plugin load
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""{{{ General vim settings:

" Enable screen elements
set laststatus=2
set showcmd
set number
set ruler

" Make plugins faster
set lazyredraw

" Tab settings
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set encoding=utf-8

" Whitespace handling
set nolist
set listchars=tab:▸\ ,trail:⋅,extends:❯,precedes:❮
set linebreak
set showbreak=⡇
nmap <silent> <Leader>T :set invlist<CR>

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmenu
set wildmode=longest,full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Use modeline overrides
set modeline
set modelines=10

" Default color scheme
set t_Co=256
set background=dark
hi clear
colorscheme sahara
set cursorline

" enable mouse in terminal
set mouse=a

" scroll earlier
set scrolloff=5

" Turn of interminable bloody beeping
set noerrorbells
set visualbell
set t_vb=
if has("autocmd") && has("gui_running")
    au GUIEnter * set t_vb=
endif

" Run properly in GUI mode
if has("gui_running")
    set guifont="Monaco 9"
    set guioptions=rie
    set guicursor+=a:blinkon0
endif

" Quick clipboard access
set clipboard=unnamed

" Seriously, backups and swapfiles? Just use git.
set nobackup
set noswapfile

" Leader char
let mapleader = ","


""}}}
""{{{ Custom commands and keybindings:

" mapping: Toggle the NERDTree window
silent! nmap <unique> <silent> <Leader>n :NERDTreeToggle<CR>

" :Ctags : Generate tags file of current directory in a format optimized for Vim.
" The 'call system(..) | redraw!' is to prevent the screen from flashing.
command! Ctags call system('ctags --sort=yes --extra=+f -R *') | redraw!

" mapping: Go to the next matching tag
map <C-\> :tnext<CR>

" :StripTrailing - remove trailing whitespace
command! StripTrailing normal m`:%s/\s*$<CR>:noh<CR>``
nmap <Leader>sw :StripTrailing<CR>

" mapping: Show overview of current file with TagBar
map <leader>o :TagbarToggle<cr>

" mapping: Quickly run a ruby script
nmap <Leader>R :w<CR>:cgetexpr system('ruby -Ilib:spec' . expand("%"))<CR>:cw<CR>

" :Task : Show the TaskWarrior tasklist
command! -nargs=* Task :!task <args> <CR>
nmap <Leader>t :Task 

" In the cmdline, type %% to insert directory of the current file:
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <Leader>e :e %%


" mapping: Show the command line window and immediately go to insert mode
nnoremap q: q:i
nnoremap q/ q/i


" Find last search term with ack:
nmap <Leader>* :AckFromSearch<CR>

" Reformat all
silent! nmap <unique> <silent> <Leader>f m`gg=G``

" Move single screen line by default
nnoremap j gj
nnoremap k gk

" Allow uppercase versions of common commands
cabbrev W w
cabbrev X x
cabbrev Q q

" Allow lowercase versions of some commands
cabbrev ack Ack
cabbrev rview Rview
cabbrev rcontroller Rcontroller
cabbrev rmodel Rmodel

" Write file as sudo with :w!!
cabbrev w!! w !sudo tee % >/dev/null

" Some shortcuts for Gitv
nmap <leader>gv :Gitv --all<cr>
nmap <leader>gV :Gitv! --all<cr>
vmap <leader>gV :Gitv! --all<cr>
nmap <leader>gs :Gst<cr>

" Make vim, tmux and Command-T all play nice together:
map <Esc>[B <Down>

" <Esc> clears search highlights in normal mode.
silent! nnoremap <esc> :noh<return><esc>

" Custom bindings for TSlime
function! s:TmuxOperator(type, ...)
  let sel_save = &selection
  let &selection = "inclusive"
  let reg_save = @@

  if a:0  " Invoked from Visual mode, use '< and '> marks.
    silent exe "normal! `<" . a:type . "`>y"
  elseif a:type == 'single'
    silent exe "normal! yy"
  elseif a:type == 'line'
    silent exe "normal! '[V']y"
  elseif a:type == 'block'
    silent exe "normal! `[\<C-V>`]y"
  else
    silent exe "normal! `[v`]y"
  endif

  call RunVimTmuxCommand(@@)

  let &selection = sel_save
  let @@ = reg_save
endfunction

nmap <silent> <leader><space> :set opfunc=<SID>TmuxOperator<CR>g@
nmap <silent> <leader><space><space> :call <SID>TmuxOperator('single')<CR>
vmap <silent> <leader><space> :<C-U>call <SID>TmuxOperator(visualmode(), 1)<CR>


""}}}
""{{{ Various autocmds

" Source the vimrc file after saving it
" Doesn't work with CSApprox.vim :(
" autocmd bufwritepost .vimrc source $MYVIMRC

" Use normal erb tags to complete % as <% %> in erb
autocmd FileType eruby let b:surround_37 = "<% \r %>"

" Kill un-ruby-ish for loops:
command! Unfor s/\vfor (\i+) in (.*)\s*$/\2.each do |\1|/

" Automatically open the quickfix window:
autocmd QuickFixCmdPost [^l]* nested cwindow

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" make the command line window useful, sortof like zsh vi-mode
set cmdwinheight=1
autocmd CmdwinEnter * setlocal nonumber
autocmd CmdwinEnter * imap <C-c> <esc>:q<return>
autocmd CmdwinEnter * nmap <C-c> :q<return>


""}}}

"}}}

"{{{ Include local vim config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" vim: set ft=vim foldmethod=marker :
