" Pathogen - easier management of vim plugins
runtime bundle/vim-pathogen/autoload/pathogen.vim " Pathogen - source plugin
call pathogen#infect() " Pathogen - do magic by setting up runtime paths
call pathogen#helptags() " Pathogen - generate help tags

set nocompatible " No old school compatability
set encoding=utf-8 " Default encoding utf-8
"set shortmess+=1 " No startup message
set title " Update terminal title
"set number " Show line numbers
set t_Co=256 " Use 256 colors in terminal
set ruler " Show cursor position at all times
set showcmd " Show incomplete commands
set showmode " Always show current mode
set ls=2 " Always show status line
set hidden " Enable multiple buffers open
set scrolloff=3 " Maintain more context around cursor when scrolling
set history=1000 " Remember more commands and search history, like an elephant
set undolevels=1000 " Use many muchos levels of undo
set timeoutlen=750 " Set the timeout for mapped key combos in ms (default 1000)
set viewoptions=folds,options,cursor,unix,slash " Better Unix/Windows compatibility
set list " Show whitespace characters
set listchars=tab:>-,trail:·,extends:# " Highlight problematic whitespace
set backspace=indent,eol,start " Allow backspacing over everything in insert mode
set shortmess=at " Be less verbose
"set visualbell " Don't beep, blink instead
set noerrorbells " Don't beep, don't you even blink
set backupdir=~/.vim/backup,/tmp " Don't clutter up current directory
set nobackup " No backup files
set noswapfile " No swap file, that thing is so 70s

"set showmatch " Show matching brackets
set autoread " Automatically reload a file when change detected
"set nowrap " Do not wrap lines
"set autochdir " Change directory automatically - can mess up some plugins

" Search options
set gdefault " Make global replace default
set ignorecase " Ignore case in search
set smartcase " Ignore case when all lowercase characters
set incsearch " Incremental search
set hlsearch " Highlight search results
set wrapscan " Make search wrap around

" Tab options
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround " Round indent to multiples of shiftwidth
set expandtab " Expand tabs to spaces (purge evil tabs)
"set smarttab " Insert tabs according to shiftwidth instead of tabstops

" Indenting
set autoindent " Autoindent according to previous line indentation
"set copyindent " Copy the previous indentation on auto indenting
"set cindent " C-style auto indenting - Interferes with filetype based indentation
"set smartindent " Intereferes with filetype based indentation

" ------ KEYBINDINGS -----

"Set mapleader key
let mapleader=","
let g:mapleader=","

" Faster browsing
nnoremap <space> <C-f>
nnoremap <backspace> <C-b>

" More speed!
nnoremap ; :
"nnoremap , ;
inoremap jj <esc>
" j and k move over rows in the editor, instead of lines of text
nnoremap j gj
nnoremap k gk
" Y will yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Walk through yank stack
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste

" Switch through buffers
"nnoremap <f1> <esc>:bprev<cr>
"nnoremap <f2> <esc>:bnext<cr>

" Delete buffer
nnoremap <f4> <esc>:bw<cr>
" Paste from system clipboard
nnoremap <leader>p <esc>"+gP<cr>
" Compile file
nnoremap <f8> <esc>:silent cd %:p:h<cr>:make<cr>

" Clear highlight from search
nnoremap <leader>n :silent noh<cr>

" Split window and switch to it
nnoremap <leader>w <c-w>v<c-w>l
nnoremap <leader>s <c-w>s<c-w>j
" Close other windows
nnoremap <leader>o <c-w>o

" Easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Strip trailing whitespaces
nnoremap <leader>W <esc>:%s/\s\+$//<cr>:let @/=''<cr>

" Open buffer explorer
nnoremap <leader>b :silent CtrlPBuffer<cr>

" Map Control-Space to omnicompletion
inoremap <c-space> <c-x><c-o>

" Format selected text or paragraph with Q
"vmap Q gq
"nnoremap Q gqap

" Use sudo to write file
"cmap w!! w !sudo tee % >/dev/null

" Auto completion: show menu
set wildmenu
set wildmode=longest:full

" Syntax highlighting, automatic file detection, and omnicompletion
syntax on
filetype plugin on
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete

" Omnicompletion
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete

" Python indenting rules and autocomplete
autocmd FileType python setlocal tabstop=4
autocmd FileType python setlocal shiftwidth=4
autocmd FileType python setlocal nosmartindent

" Strip trailing whitespace when saving a file
autocmd BufWritePre * :%s/\s\+$//e

" Extended % pairs matching
runtime macros/matchit.vim

" Solarized colors
"let g:solarized_termcolors=256

" gVim options
if has("gui_running") " Options for when GUI is present (gVim)
  set guioptions-=r " Remove right scrollbar
  set guioptions-=l " Remove left scrollbar
  set guioptions-=R " Remove right scrollbar when window is split
  set guioptions-=L " Remove left scrollbar when window is split
  set guioptions-=T " Remove tool bar
  set guioptions-=m " Remove menu bar
  set mousehide " Hide mouse when user starts typing
  "colorscheme desert
  colorscheme zenburn
  if has("gui_gtk2") " Options for when GUI is gtk2 (Linux)
      set guifont=Deja\ Vu\ Sans\ Mono\ 12
  endif
else " Options for when no GUI is present (console vim)
  "colorscheme desert
  colorscheme zenburn
  "colorscheme solarized
endif

" ----- PLUGINS -----

" NERDTree
"let NERDTreeShowBookmarks=0
"let NERDTreeQuitOnOpen=1
"let NERDTreeKeepTreeInNewTab=1
"let NERDTreeChDirMode=0

" Open NERDTree
"nmap <leader>e :silent NERDTreeToggle<cr>:silent NERDTreeMirror<cr>
"nmap <leader>e :silent NERDTreeToggle<cr>

" Auto start NERDTree:
"autocmd vimenter * NERDTree
" Close vim when only NERDTree window left:
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Vim Notes
let g:notes_directory = $HOME . "/.vim/notes"

" UltiSnips snippets directory
set runtimepath+=~/.vim/snippets/
"let g:UltiSnipsSnippetDirectories = ["UltiSnips", "snippets"]
" Don't reverse directory lookup
let g:UltiSnipsDontReverseSearchPath="1"

" Zencoding keymap
let g:user_zen_expandabbr_key='<C-e>'

" Powerline file path style
let g:Powerline_stl_path_style = 'filename'

" Tagbar ctags executable
let g:tagbar_ctags_bin='~/.local/bin/ctags'

" Change EasyMotion leader key - Default is <Leader><Leader>
"let g:EasyMotion_leader_key = '<Leader>'

" Yankstack
let g:yankstack_map_keys = 0 " No default mapping for yankstack
call yankstack#setup() " Setup yankstack plugin

" Ctags executable file location
let Tlist_Ctags_Cmd='~/.local/bin/ctags'
