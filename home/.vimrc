"{{{ Pre vundle load
"
" These settings need to happen before vundle is invoked:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off


" Use vundle for managing plugins under .vim/bundle
set runtimepath+=~/.vim/bundle/vundle
call vundle#rc()
"}}}

"{{{ Plugin bundles (managed with Vundle)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle "Lokaltog/vim-powerline"
Bundle "airblade/vim-gitgutter"
Bundle "slim-template/vim-slim"
Bundle "behaghel/vim-scala"
Bundle "cakebaker/scss-syntax.vim"
Bundle 'christoomey/vim-tmux-navigator'
Bundle "claco/jasmine.vim"
Bundle "ervandew/supertab"
Bundle "elixir-lang/vim-elixir"
Bundle "gmarik/vundle"
Bundle "godlygeek/tabular"
Bundle "gregsexton/gitv"
Bundle "kana/vim-textobj-user"
Bundle "kchmck/vim-coffee-script"
Bundle "kien/ctrlp.vim"
Bundle "majutsushi/tagbar"
Bundle "matchit.zip"
Bundle "mattn/gist-vim"
Bundle "michaeljsmith/vim-indent-object"
Bundle "nelstrom/vim-textobj-rubyblock"
Bundle "pangloss/vim-javascript"
Bundle "petdance/vim-perl"
Bundle "rainux/vim-desert-warm-256"
Bundle "scrooloose/nerdtree"
Bundle "scrooloose/syntastic"
Bundle "searchfold.vim"
Bundle "t9md/vim-ruby-xmpfilter"
Bundle "timcharper/textile.vim"
Bundle "tpope/vim-abolish"
Bundle "tpope/vim-bundler"
Bundle "tpope/vim-commentary"
Bundle "tpope/vim-dispatch"
Bundle "tpope/vim-endwise"
Bundle "tpope/vim-fugitive"
Bundle "tpope/vim-haml"
Bundle "tpope/vim-markdown"
Bundle "tpope/vim-ragtag"
Bundle "tpope/vim-rails"
Bundle "tpope/vim-rake"
Bundle "tpope/vim-repeat"
Bundle "tpope/vim-rsi"
Bundle "tpope/vim-surround"
Bundle "tpope/vim-unimpaired"
Bundle "vim-ruby/vim-ruby"
Bundle "wikipedia.vim"

"}}}

"{{{ Post vundle load, pre plugin load
"
" These settings need to happen before plugins are loaded:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" NERDTree configuration
let NERDTreeIgnore     = ['\.pyc$', '\.rbc$', '\~$']
let NERDChristmasTree  = 1
let NERDTreeChDirMode  = 2
let NERDTreeQuitOnOpen = 1
let NERDTreeShowHidden = 1
let NERDTreeMinimalUI  = 1
let NERDTreeDirArrows  = 0

" Don't map C-j/C-k in NERDTree
let NERDTreeMapJumpNextSibling = "<C-n>"
let NERDTreeMapJumpPrevSibling = "<C-p>"

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

" POWERLINE!
let g:Powerline_symbols = 'fancy'

" Ctrlp configuration
let g:ctrlp_map = '<leader>/'
let g:ctrlp_custom_ignore = {
  \ 'dir': 'vendor\/\(bundle\|cache\)',
  \ }

" Enable syntastic syntax checking
let g:syntastic_enable_signs=1
let g:syntastic_quiet_warnings=1
let g:syntastic_auto_loc_list=1

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

let g:Gitv_OpenHorizontal = 'auto'
let g:Gitv_CommitStep = 50

" Enable syntax highlighting, plugin loading from runtimepath:
syntax on
filetype plugin indent on

"}}}

"{{{ Post bundle/plugin load
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""{{{ General vim settings:

" Leader char
let mapleader = ","

" Enable screen elements
set laststatus=2
set showcmd
set number
set ruler

" Powerline already sets the mode
set noshowmode

" More natural split behaviour
set splitright
" set splitbelow " Moves fugitive status window too :(

" Make plugins faster
set lazyredraw

" Automatically update files that changed externally, and write files on
" commands that change the buffer
set autoread
set autowrite

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
set complete-=i

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Use modeline overrides
set modeline
set modelines=10

" Default color scheme
set t_Co=256
set background=dark
hi clear

colorscheme desert-warm-256

" Use the same color for the line number and the Sign columns
" (where gitgutter and syntastic displays things)
highlight clear SignColumn

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

" Fix timeout in updating status line in the terminal after insert mode
" (from http://powerline.readthedocs.org/en/latest/tipstricks.html)
if ! has("gui_running")
  set ttimeout
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif

" Quick clipboard access
set clipboard=unnamed

" Seriously, backups and swapfiles? Just use git.
set nobackup
set noswapfile

""}}}
""{{{ Custom commands and keybindings:

" mapping: Toggle the NERDTree window
silent! nmap <unique> <silent> <Leader>n :NERDTreeToggle<CR>
silent! nmap <unique> <silent> <Leader>N :NERDTreeFind<CR>

" :Ctags : Generate tags file of current directory in a format optimized for Vim.
" The 'call system(..) | redraw!' is to prevent the screen from flashing.
command! Ctags call system('ctags --exclude="**/*.js" --sort=yes -R .') | redraw!

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

" Make Y consistent with C and D.  See :help Y.
nnoremap Y y$

" Repeat last :s including flags
nnoremap & :&&<CR>
xnoremap & :&&<CR>

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

" Jump to next/previous changed git hunk:

nmap [d :GitGutterPrevHunk<cr>
nmap ]d :GitGutterNextHunk<cr>


" Make vim, tmux and Command-T all play nice together:
map <Esc>[B <Down>

" <Esc> clears search highlights in normal mode.
silent! nnoremap <esc> :noh<cr><esc>

" Run tests async
silent! nmap <Leader>r :Make<cr>

function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':file ' . new_name
    exec ':silent !mkdir -p ' . expand('%:h')
    exec ':w'
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>m :call RenameFile()<cr>

command! -nargs=0 -bar Qargs execute 'args ' . QuickfixFilenames()
function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(values(buffer_numbers))
endfunction

""}}}
""{{{ Various autocmds

" Source the vimrc file after saving it
" Doesn't work with CSApprox.vim :(
autocmd bufwritepost .vimrc source $MYVIMRC

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
