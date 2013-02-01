" ----- DIRECTORIES -----

" On Windows, also use '.vim' instead of 'vimfiles'
if has('win32') || has('win64')
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

" Make directory if it doesn't exist
function! EnsureDirExists (dir)
  if !isdirectory(a:dir)
    if exists("*mkdir")
      call mkdir(a:dir, 'p')
    else
      echo "Please create directory: " . a:dir
    endif
  endif
endfunction

" Ensure needed directories are there
call EnsureDirExists($HOME . '/.vim/backup')
call EnsureDirExists($HOME . '/.vim/undo')
call EnsureDirExists($HOME . '/.vim/notes')

" Keep all backups in a single directory
if isdirectory($HOME . '/.vim/backup')
    set backupdir=~/.vim/backup//
endif

" Keep all undo in a single directory
if isdirectory($HOME . '/.vim/undo')
    if has("persistent_undo")
        set undodir=~/.vim/undo//
        set undofile
    endif
endif

" ----- PLUGINS -----

" Pathogen - easier management of vim plugins
runtime bundle/vim-pathogen/autoload/pathogen.vim " Source pathogen plugin
" Temporarily disabled plugins
"let g:pathogen_disabled = ['bufexplorer']
"call add(g:pathogen_disabled, 'vim-powerline')

" Initialize pathogen
call pathogen#infect() " Pathogen - do magic by setting up runtime paths
call pathogen#helptags() " Pathogen - generate help tags
" Initialize other plugins
call yankstack#setup() " Setup yankstack plugin

" ----- VIM OPTIONS -----

set nocompatible " No old school compatability
set encoding=utf-8 " Default encoding utf-8
set title " Update terminal title
set shortmess=at " Be less verbose
"set number " Show line numbers
"set visualbell " Don't beep, blink instead
set noerrorbells " Don't beep, don't you even blink
set t_Co=256 " Use 256 colors in terminal
set ruler " Show cursor position at all times
"set cursorline " Highlight current line
set showcmd " Show incomplete commands
set showmode " Always show current mode
set ls=2 " Always show status line
set hidden " Enable multiple buffers open
set scrolloff=3 " Maintain more context around cursor when scrolling
set nofoldenable " Don't fold code
set nobackup " No backup files
set noswapfile " No swap file, that thing is so 70s
set backspace=indent,eol,start " Allow backspacing over everything in insert mode
set viewoptions=folds,options,cursor,unix,slash " Better Unix/Windows compatibility
set list " Show whitespace characters
set listchars=tab:>-,trail:·,extends:# " Highlight problematic whitespace
set timeoutlen=750 " Set the timeout for mapped key combos in ms (default 1000)
set history=1000 " Remember more commands and search history, like an elephant
set undolevels=1000 " Use many muchos levels of undo
set autoread " Automatically reload a file when change detected

"set showmatch " Show matching brackets
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

" ----- GUI and colors -----

" Solarized colors
"let g:solarized_termcolors=256

" Toggle background color for solarized
call togglebg#map("<F4>")

" gVim options
if has("gui_running") " Options for when GUI is present (gVim)
  set guioptions-=r " Remove right scrollbar
  set guioptions-=l " Remove left scrollbar
  set guioptions-=R " Remove right scrollbar when window is split
  set guioptions-=L " Remove left scrollbar when window is split
  set guioptions-=T " Remove tool bar
  "set guioptions-=m " Remove menu bar
  set mousehide " Hide mouse when user starts typing
  "colorscheme desert
  "colorscheme zenburn
  colorscheme solarized
  if has("gui_gtk2") " Options for when GUI is gtk2 (Linux)
      set guifont=Deja\ Vu\ Sans\ Mono\ 12
  endif
else " Options for when no GUI is present (console vim)
  "colorscheme desert
  "colorscheme zenburn
  "colorscheme solarized
endif

" ------ FUNCTIONS -----

" ------ KEYBINDINGS -----

"Set mapleader key
let g:mapleader=","

" Faster browsing
nnoremap <space> <C-f>
nnoremap <backspace> <C-b>
vnoremap <space> <C-f>
vnoremap <backspace> <C-b>

" More speed!
"nnoremap ; :
"nnoremap , ;
inoremap jj <esc>
" j and k move over rows in the editor, instead of lines of text
nnoremap j gj
nnoremap k gk
" Y will yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Delete buffer
nnoremap <leader>k :bw<cr>

" Paste from system clipboard
nnoremap <c-p> "+gP<cr>
inoremap <c-p> <c-r><c-o>+

" Clear highlight from search
nnoremap <leader>n :silent noh<cr>
nnoremap <leader>/ :silent noh<cr>

" Close other windows
nnoremap <leader>1 <c-w>o
" Split window and switch to it
nnoremap <leader>2 <c-w>s<c-w>j
nnoremap <leader>3 <c-w>v<c-w>l
" Close current window
nnoremap <leader>4 <c-w>c

" Easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Strip trailing whitespaces
nnoremap <leader>W :silent %s/\s\+$//<cr>:let @/=''<cr>

" Open buffer explorer
nnoremap <c-b> :silent CtrlPBuffer<cr>
inoremap <c-b> <c-o>:silent CtrlPBuffer<cr>

" Map Control-Space to omnicompletion
inoremap <c-space> <c-x><c-o>

" Format selected text or paragraph with Q
vmap Q gq
nnoremap Q gqap

" Replace word under cursor
"nnoremap <leader>s :%s/\<<C-r><C-w>\>/
" Replace word under cursor globally by default
nnoremap <leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Shift key fixes in command mode
cnoremap W w
cnoremap WQ wq
cnoremap Wq wq
cnoremap wQ wq
cnoremap Q q

" Use sudo to write file
cnoremap w!! w !sudo tee % >/dev/null

" ----- PROGRAMMING -----

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
autocmd BufWritePre * :silent %s/\s\+$//e

" Extended % pairs matching
runtime macros/matchit.vim

" ----- PLUGINS -----

" CtrlP
let g:ctrlp_map = '<c-f>'
" Working path mode
let g:ctrlp_working_path_mode = 'ra'
" Don't clear cache on exit
let g:ctrlp_clear_cache_on_exit=0
" Add additional root markers
let g:ctrlp_root_markers = ['composer.json', 'package.json']

" Ignore these files and directories
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\cache*|\vendor$|\Downloads$|\Igre*|\Install',
            \ 'file': '\v\.(exe|so|dll|pyc|zip|tar\.gz|tar\.bz2|pdf|doc|docx|odt|png|jpg|gif|xcf|swf|flv|mp3|mp4|mkv|torrent|jar)$',
            \ }

" NERDTree
"let NERDTreeShowBookmarks=0
"let NERDTreeQuitOnOpen=1
"let NERDTreeKeepTreeInNewTab=1
"let NERDTreeChDirMode=0

" Open NERDTree
"nmap <leader>e :silent NERDTreeToggle<cr>:silent NERDTreeMirror<cr>
nmap <leader>e :silent NERDTreeToggle<cr>

" Supertab
let g:SupertabMappingForward = '<c-space>'
let g:SupertabMappingBackward = '<s-c-space>'

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

" Ctags executable file location
let Tlist_Ctags_Cmd='~/.local/bin/ctags'
