set nocompatible

filetype off

" Disable AlignMaps (pollutes <Leader> mappings horribly).
let g:loaded_AlignMapsPlugin = "disabled"
let g:loaded_cecutil = "disabled"

" Disable Command-T, use cmdp instead
let g:pathogen_disabled = []
call add(g:pathogen_disabled, 'command-t')

silent! call pathogen#runtime_append_all_bundles()
silent! call pathogen#helptags()

set number
set ruler
syntax on

" Set encoding
set encoding=utf-8

" Make plugins faster
set lazyredraw

" Tab settings
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Whitespace handling
set nolist
set listchars=tab:▸\ ,trail:⋅,extends:❯,precedes:❮

set linebreak
set showbreak=⡇
nmap <silent> <Leader>T :set invlist<CR>

command! StripTrailing normal m`:%s/\s*$<CR>:noh<CR>``
nmap <Leader>sw :StripTrailing<CR>

" Move single screen line by default
nnoremap j gj
nnoremap k gk

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmenu
set wildmode=longest,full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

" Status bar
set laststatus=2

" Leader char
let mapleader = ","

" NERDTree configuration
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
let NERDQuitOnOpen=1
silent! nmap <unique> <silent> <Leader>n :NERDTreeToggle<CR>

" Ctrlp configuration
let g:ctrlp_map = '<leader>/'

" CTags
command! Ctags :!ctags --sort=yes --extra=+f -R *<CR><CR>
map <C-\> :tnext<CR>

" Quickly run a ruby script
nmap <Leader>R :w<CR>:cgetexpr system('ruby -Ilib:spec' . expand("%"))<CR>:cw<CR>

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" make uses real tabs
au FileType make set noexpandtab

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

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

" Use modeline overrides
set modeline
set modelines=10

" Default color scheme
set t_Co=256
set background=dark
hi clear
colorscheme sahara
set cursorline

" make the command line window useful, sortof like zsh vi-mode
nnoremap q: q:i
nnoremap q/ q/i
set cmdwinheight=1
autocmd CmdwinEnter * setlocal nonumber
autocmd CmdwinEnter * imap <C-c> <esc>:q<return>
autocmd CmdwinEnter * nmap <C-c> :q<return>

" Show (partial) command in the status line
set showcmd

" Source the vimrc file after saving it
" autocmd bufwritepost .vimrc source $MYVIMRC

" Use ack-grep for searching
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

" Find last search term with ack:
nmap <Leader>* :AckFromSearch<CR>

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
map <Leader>r :registers <CR>

" Reformat all
silent! nmap <unique> <silent> <Leader>f m`gg=G``

" Allow uppercase versions of common commands
cabbrev W w
cabbrev X x
cabbrev Q q

" Allow lowercase versions of some commands
cabbrev ack Ack
cabbrev rview Rview
cabbrev rcontroller Rcontroller
cabbrev rmodel Rmodel
cabbrev git Git

" Write file as sudo with :w!!
cabbrev w!! w !sudo tee % >/dev/null

" Some shortcuts for Gitv
nmap <leader>gv :Gitv --all<cr>
nmap <leader>gV :Gitv! --all<cr>
vmap <leader>gV :Gitv! --all<cr>

nmap <leader>gs :Gst<cr>

" Seriously, backups and swapfiles? Just use git.
set nobackup
set noswapfile

" Make vim, tmux and Command-T all play nice together:
map <Esc>[B <Down>

" <Esc> clears search highlights in normal mode.
silent! nnoremap <esc> :noh<return><esc>

" Use normal erb tags to complete % as <% %> in erb
autocmd FileType eruby let b:surround_37 = "<% \r %>"

" Kill un-ruby-ish for loops:
command! Unfor s/\vfor (\i+) in (.*)\s*$/\2.each do |\1|/

" Automatically open the quickfix window:
autocmd QuickFixCmdPost [^l]* nested cwindow

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

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

  call Send_to_Tmux(@@)

  let &selection = sel_save
  let @@ = reg_save
endfunction

nmap <silent> <leader><space> :set opfunc=<SID>TmuxOperator<CR>g@
nmap <silent> <leader><space><space> :call <SID>TmuxOperator('single')<CR>
vmap <silent> <leader><space> :<C-U>call <SID>TmuxOperator(visualmode(), 1)<CR>

" vim: set ft=vim :
