"{{{ Pre vundle load
"
" These settings need to happen before vundle is invoked:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
syntax on
filetype off


" Use vundle for managing plugins under .vim/bundle
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Leader char
let mapleader = " "

" let Vundle manage Vundle (required)
Plugin 'gmarik/Vundle.vim'
"}}}

"{{{ Plugin bundles (managed with Vundle)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'atdt/vim-mediawiki'
Plugin 'fatih/vim-go'
Plugin 'Lokaltog/vim-powerline'
Plugin 'airblade/vim-gitgutter'
Plugin 'behaghel/vim-scala'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'claco/jasmine.vim'
Plugin 'elixir-lang/vim-elixir'
Plugin 'elzr/vim-json'
Plugin 'ervandew/supertab'
Plugin 'godlygeek/tabular'
Plugin 'gregsexton/gitv'
Plugin 'kana/vim-textobj-user'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'matchit.zip'
Plugin 'mattboehm/vim-accordion'
Plugin 'mattboehm/vim-unstack'
Plugin 'mattn/gist-vim'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'mileszs/ack.vim'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'pangloss/vim-javascript'
Plugin 'petdance/vim-perl'
Plugin 'wjbuys/vim-desert-warm-256'
Plugin 'rust-lang/rust.vim'
Plugin 'racer-rust/vim-racer'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'searchfold.vim'
Plugin 'slim-template/vim-slim'
Plugin 't9md/vim-ruby-xmpfilter'
Plugin 'timcharper/textile.vim'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-rsi'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-ruby/vim-ruby'

"}}}

"{{{ Post vundle load, pre plugin load
"
"
" These settings need to happen before plugins are loaded:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:go_auto_type_info = 1

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1

let g:rustfmt_autosave = 1

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
let g:ctrlp_map = '<Leader>/'
let g:ctrlp_custom_ignore = {
  \ 'dir': 'vendor\/\(bundle\|cache\)',
  \ }
let g:ctrlp_extensions = ['tag', 'buffertag']

let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files . -co --exclude-standard'],
  \ },
  \ 'fallback': 'find %s -type f'
  \ }


" Enable syntastic syntax checking
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
let g:syntastic_quiet_messages = {'level': 'warnings'}

" Enable highlighting of fenced code blocks in .md files
let g:markdown_fenced_languages = ["ruby", "json", "javascript", "sh"]

" Use rbenv ruby for syntax checks
let g:syntastic_ruby_mri_exe=$RBENV_ROOT . "/shims/ruby"

" gist-vim defaults
if has("mac")
  let g:gist_clip_command = 'pbcopy'
elseif has("unix")
  let g:gist_clip_command = 'xclip -selection clipboard'
endif
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" Use ripgrep if it's available:
let g:ackprg="rg --no-heading --vimgrep -L"

let g:Gitv_OpenHorizontal = 'auto'
let g:Gitv_CommitStep = 50

" All Plugins must be configured before the following line
call vundle#end()
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

" Prettier window/fold splits:
set fillchars=""

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
set smarttab

" Whitespace handling
set nolist
set listchars=tab:▸\ ,trail:⋅,extends:❯,precedes:❮
set linebreak
set showbreak=⡇

" Remove comment characters when joining newlines
set formatoptions+=j

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

" disable mouse in terminal
set mouse=

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

if has("gui_macvim")
  set guifont=Monaco:h14
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

" Turn off persistent backups and disable swapfiles
set nobackup
set noswapfile

" Vim uses backup files to make sure writes are atomic. Put these somewhere
" that is not the current directory (messes with Guard, for example)
set backupdir=~/.vim/tmp,/tmp,.

""}}}
""{{{ Custom commands and keybindings:

" mapping: Toggle the NERDTree window
silent! nmap <unique> <silent> <Leader>n :NERDTreeToggle<CR>
silent! nmap <unique> <silent> <Leader>N :NERDTreeFind<CR>

" mapping: CrtlP for tags:
silent! nmap <unique> <silent> <Leader>t :CtrlPBufTag<CR>
silent! nmap <unique> <silent> <Leader>T :CtrlPTag<CR>


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

" In the cmdline, type %% to insert directory of the current file:
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <Leader>e :e %%

" mapping: Show the command line window and immediately go to insert mode
nnoremap q: q:i
nnoremap q/ q/i

" Find last search term with ack:
nmap <Leader>* :AckFromSearch<CR>

" set up xmpfilter to evaluate inline #=> in ruby
let g:xmpfilter_cmd = "sibwrapper"

" auto insert mark at appropriate spot.
autocmd FileType ruby nmap <buffer> <Leader>xr <Plug>(seeing_is_believing-run)
autocmd FileType ruby nmap <buffer> <Leader>xx <Plug>(seeing_is_believing-run_-x)
autocmd FileType ruby nmap <buffer> <Leader>xc <Plug>(seeing_is_believing-clean)

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
nmap <Leader>gv :Gitv --all<cr>
nmap <Leader>gV :Gitv! --all<cr>
vmap <Leader>gV :Gitv! --all<cr>
nmap <Leader>gs :Gst<cr>

" Jump to next/previous changed git hunk:

nmap [d :GitGutterPrevHunk<cr>
nmap ]d :GitGutterNextHunk<cr>


" Make vim, tmux and Command-T all play nice together:
map <Esc>[B <Down>

" <Esc> clears search highlights in normal mode.
silent! nnoremap <esc> :noh<cr><esc>

" Run tests async
silent! nmap <Leader>r :Make<cr>

" Dispatch last command
silent! nmap <Leader>R :Dispatch<cr>


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
map <Leader>m :call RenameFile()<cr>

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
