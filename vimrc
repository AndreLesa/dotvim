" ----- FIRST THINGS FIRST -----
set nocompatible " No old school compatability

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
call EnsureDirExists($HOME . '/.vim/sessions')
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
let g:pathogen_disabled = []
"call add(g:pathogen_disabled, 'bufexplorer')
"call add(g:pathogen_disabled, 'vim-powerline')
call add(g:pathogen_disabled, 'auto-pairs')

" Initialize pathogen
call pathogen#infect() " Pathogen - do magic by setting up runtime paths
call pathogen#helptags() " Pathogen - generate help tags
" Initialize other plugins
call yankstack#setup() " Setup yankstack plugin

" ----- VIM OPTIONS -----

set encoding=utf-8 " Default encoding utf-8
set title " Update terminal title
set shortmess=at " Be less verbose
"set number " Show line numbers
"set cursorline " Highlight current line
"set visualbell " Don't beep, blink instead
set noerrorbells " Don't beep, don't you even blink
set t_Co=256 " Use 256 colors in terminal
set ruler " Show cursor position at all times
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
"set timeoutlen=750 " Set the timeout for mapped key combos in ms (default 1000)
set history=1000 " Remember more commands and search history, like an elephant
set undolevels=1000 " Use many muchos levels of undo
set autoread " Automatically reload a file when change detected
set list " Show whitespace characters
set listchars=tab:>-,trail:·,extends:# " Highlight problematic whitespace

set splitbelow " Vertical splits go below instead of above
set splitright " Horizontal splits go to the right instead of to the left

" Strip trailing whitespace when saving a file
autocmd BufWritePre * :silent %s/\s\+$//e

"set showmatch " Show matching brackets
"set nowrap " Do not wrap lines
"set autochdir " Auto change directory - better left off, messes up plugins

" Search options
set gdefault " Make global replace default
set ignorecase " Ignore case in search
set smartcase " Ignore case but only when all lowercase characters
set incsearch " Incremental search
set hlsearch " Highlight search results
set wrapscan " Make search wrap around

" Auto completion: show menu
set wildmenu
set wildmode=longest:full

" Tags
"set tags=./tags,tags;$HOME " search current dir, then up recursively until $HOME
set tags=./tags;/ " search current dir, then up recursively until root

" ----- UI, COLORS AND STUFF -----

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
    set guioptions-=m " Remove menu bar
    set mousehide " Hide mouse when user starts typing
    "colorscheme desert
    "colorscheme zenburn
    colorscheme solarized
    if has("gui_gtk2") " Options for when GUI is gtk2 (Linux)
        "set guifont=Deja\ Vu\ Sans\ Mono\ 12
        set guifont=Monospace\ 12
    endif
else " Options for when no GUI is present (console vim)
    "colorscheme desert
    "colorscheme zenburn
    "colorscheme solarized
endif

" ----- CODING -----

" General tab options
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround " Round indent to multiples of shiftwidth
set expandtab " Expand tabs to spaces (purge evil tabs)
"set smarttab " Insert tabs according to shiftwidth instead of tabstops

" General indenting
set autoindent " Autoindent according to previous line indentation
"set nosmartindent " Intereferes with filetype based indentation
"set nocopyindent " Copy the previous indentation on auto indenting
"set nocindent " C-style auto indenting - Interferes with filetype based indentation

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

" Python indenting rules
autocmd FileType python setlocal tabstop=4
autocmd FileType python setlocal softtabstop=4
autocmd FileType python setlocal shiftwidth=4
autocmd FileType python setlocal nosmartindent

" Html indenting rules
autocmd FileType xml,html,html.twig setlocal tabstop=2
autocmd FileType xml,html,html.twig setlocal softtabstop=2
autocmd FileType xml,html,html.twig setlocal shiftwidth=2

" Javascript indenting rules
autocmd FileType javascript setlocal tabstop=2
autocmd FileType javascript setlocal softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2

" ------ FUNCTIONS -----

" ------ KEYBINDINGS -----

"Set mapleader key
let g:mapleader=","

" Faster browsing
nnoremap <space> <C-f>
nnoremap <s-space> <C-b>
nnoremap <backspace> <C-b>
vnoremap <space> <C-f>
vnoremap <s-space> <C-b>
vnoremap <backspace> <C-b>

" Split window
nmap <leader>swh :topleft  vnew<cr>
nmap <leader>swl :botright vnew<cr>
nmap <leader>swk :topleft  new<cr>
nmap <leader>swj :botright new<cr>
" Split buffer
nmap <leader>sbh :leftabove  vnew<cr>
nmap <leader>sbl :rightbelow vnew<cr>
nmap <leader>sbk :leftabove  new<cr>
nmap <leader>sbj :rightbelow new<cr>

" More speed!
inoremap jj <esc>
cnoremap jj <c-c><esc>

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

" Map Control-Space to omnicompletion
inoremap <c-space> <c-x><c-o>

" Format selected text or paragraph with Q
vmap Q gq
nnoremap Q gqap

" Replace word under cursor - on current line
nnoremap <leader>sl :s/\<<C-r><C-w>\>/
" Replace word under cursor - on all lines
nnoremap <leader>sg :%s/\<<C-r><C-w>\>/

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

" ----- PLUGIN KEYBINDINGS -----

" Open a note
nnoremap <c-n> :edit note:
inoremap <c-n> <esc>:edit note:

" Comment lines
inoremap <m-;> <c-o><leader>ci
nnoremap <m-;> <leader>ci
vnoremap <m-;> <leader>ci

" Open buffer explorer
nnoremap <leader>bb :silent CtrlPBuffer<cr>
nnoremap <c-b> :silent CtrlPBuffer<cr>
inoremap <c-b> <esc>:silent CtrlPBuffer<cr>

" Open file explorer
nnoremap <leader>f :silent CtrlP<cr>

" Undo tree
nnoremap <leader>u :silent UndotreeToggle<cr>
nnoremap <c-u> :silent UndotreeToggle<cr>
inoremap <c-u> <esc>:silent UndotreeToggle<cr>

" ----- MISC -----

" Extended % pairs matching
runtime macros/matchit.vim

" ----- PLUGINS -----

" Disable auto-pairs keybind for <M-p> (conflict with yankstack)
let g:AutoPairShortcutToggle = '' " why doesn't this work?

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
            \ 'dir':  '\.git$\|\.hg$\|\.svn$\|cache$\|vendor$\|Downloads$\|Igre$\|Install$',
            \ 'file': '\v\.(exe|so|dll|pyc|zip|tar\.gz|tar\.bz2|pdf|doc|docx|odt|png|jpg|gif|xcf|swf|flv|mp3|mp4|mkv|torrent|jar)$',
            \ }

" Syntastic
let g:syntastic_mode_map = { 'mode': 'active',
            \ 'active_filetypes': [],
            \ 'passive_filetypes': ['html', 'html.twig'] }

" NERDTree
"let NERDTreeShowBookmarks=0
"let NERDTreeQuitOnOpen=1
"let NERDTreeKeepTreeInNewTab=1
"let NERDTreeChDirMode=0

" Open NERDTree
"nmap <leader>e :silent NERDTreeToggle<cr>:silent NERDTreeMirror<cr>
nmap <leader>e :silent NERDTreeToggle<cr>

" If nerdtree is last and only buffer, quit vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

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
