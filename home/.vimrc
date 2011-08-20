set nocompatible

filetype off
silent! call pathogen#runtime_append_all_bundles()
silent! call pathogen#helptags()

set number
set ruler
syntax on

" Set encoding
set encoding=utf-8

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:>-,trail:·,extends:#,nbsp:.
nmap <silent> <leader>s :set nolist!<CR>

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

" Without setting this, ZoomWin restores windows in a way that causes
" equalalways behavior to be triggered the next time CommandT is used.
" This is likely a bludgeon to solve some other issue, but it works
set noequalalways

" leader char
let mapleader = ","

" NERDTree configuration
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
let NERDQuitOnOpen=1
silent! nmap <unique> <silent> <Leader>n :NERDTreeToggle<CR>

" Command-T configuration
silent! nmap <unique> <silent> <Leader>/ :CommandT<CR>
let g:CommandTMaxHeight=20

" ZoomWin configuration
map <Leader><Leader> :ZoomWin<CR>

" CTags
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>
map <C-\> :tnext<CR>

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

function! s:setupWrapping()
  set wrap
  set wrapmargin=2
  set textwidth=72
endfunction

function! s:setupMarkup()
  call s:setupWrapping()
  map <buffer> <Leader>p :Hammer<CR>
endfunction

" make uses real tabs
au FileType make set noexpandtab

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,wiki} call s:setupMarkup()

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

au BufRead,BufNewFile *.txt call s:setupWrapping()

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

" Unimpaired configuration
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

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

" enable mouse in terminal
set mouse=a

" Turn of interminable bloody beeping
set noerrorbells
set visualbell
set t_vb=
if has("autocmd") && has("gui_running")
    au GUIEnter * set t_vb=
endif

" Run properly in GUI mode
if has("gui_running")
    set guifont=Monaco
    set guioptions=rie
    set guicursor+=a:blinkon0
endif

" Quick clipboard access
set clipboard=unnamed
map <Leader>r :registers <CR>
" Reformat all
silent! nmap <unique> <silent> <Leader>f m`gg=G``

" Make vim, tmux and Command-T all play nice together:
map <Esc>[B <Down>

" Allow uppercase versions of common commands
cabbrev W w
cabbrev X x
cabbrev Q q
cabbrev w!! w !sudo tee % >/dev/null

" Seriously, backups and swapfiles? Just use git.
set nobackup
set noswapfile
" Make vim, tmux and Command-T all play nice together:
map <Esc>[B <Down>

" <Esc> clears search highlights in normal mode.
silent! nnoremap <esc> :noh<return><esc>

" Support scrooloose's snipmate bundle
source ~/.vim/snippets/support_functions.vim

" Use normal irb tags to complete % as <% %> in erb
autocmd FileType eruby let b:surround_37 = "<% \r %>"

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" vim: set ft=vim :
