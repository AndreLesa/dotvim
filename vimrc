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
"call add(g:pathogen_disabled, 'nerdtree')
"call add(g:pathogen_disabled, 'supertab')
"call add(g:pathogen_disabled, 'syntastic')
call add(g:pathogen_disabled, 'auto-pairs')
call add(g:pathogen_disabled, 'csapprox')
call add(g:pathogen_disabled, 'ycm')

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
"set t_Co=256 " Use 256 colors in terminal
"set t_ut= " No background color erase
set ruler " Show cursor position at all times
set showcmd " Show incomplete commands
set showmode " Always show current mode
set ls=2 " Always show status line
set hidden " Enable multiple buffers open
set scrolloff=3 " Maintain more context around cursor when scrolling
set foldmethod=indent " Fold method
set foldlevel=99 " Fold level
"set nofoldenable " Don't fold code
set nobackup " No backup files
set noswapfile " No swap file, that is so 70s
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

if &term =~ '256color'
" Disable Background Color Erase (BCE) so that color schemes
" work properly when Vim is used inside tmux and GNU screen.
" See also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

" Solarized colors
let g:solarized_termcolors=16 " For use with solarized terminal color palette

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

" Faster browsing/scrolling
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
vnoremap j gj
vnoremap k gk

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

" Close autocomplete preview window
autocmd CursorMovedI *  if pumvisible() == 0|silent! pclose|endif
autocmd InsertLeave * if pumvisible() == 0|silent! pclose|endif

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

" NERDTree
" Open NERDTree
"nmap <leader>e :silent NERDTreeToggle<cr>:silent NERDTreeMirror<cr>
nmap <leader>e :silent NERDTreeToggle<cr>

" If nerdtree is last and only buffer, quit vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Supertab
let g:SupertabMappingForward = '<c-space>'
let g:SupertabMappingBackward = '<s-c-space>'
let g:SuperTabDefaultCompletionType = "<C-X><C-O>" " omnicomplete
let g:SuperTabDefaultCompletionType = "context" " smartass
let g:SuperTabClosePreviewOnPopupClose = 1

" Vim Notes
let g:notes_directory = $HOME . "/.vim/notes"

" UltiSnips snippets directory
set runtimepath+=~/.vim/snippets/
"let g:UltiSnipsSnippetDirectories = ["UltiSnips", "snippets"]
" Don't reverse directory lookup
let g:UltiSnipsDontReverseSearchPath="1"

" Zencoding keymap
let g:user_zen_expandabbr_key='<C-e>'

" Tagbar ctags executable
let g:tagbar_ctags_bin='~/.local/bin/ctags'

" Change EasyMotion leader key - Default is <Leader><Leader>
"let g:EasyMotion_leader_key = '<Leader>'

" Javascript plugin
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

let g:syntastic_auto_loc_list=2

" Jedi vim
"let g:jedi#auto_vim_configuration = 0 " don't set vim opts
"let g:jedi#use_tabs_not_buffers = 0 " buffers baby, it's all about buffers

" Syntastic
" Check on buffer open
let g:syntastic_check_on_open=1
" No syntax highlighting
"let g:syntastic_enable_highlighting = 0
" Jump to first error on checking
let g:syntastic_auto_jump=0
" Modemaps for filetypes
let g:syntastic_mode_map = { 'mode': 'active',
            \ 'active_filetypes': [],
            \ 'passive_filetypes': ['html', 'html.twig'] }

" Python checker
let g:syntastic_python_checkers=['flake8']

" No errors buffer please
let g:syntastic_auto_loc_list=2
let g:syntastic_always_populate_loc_list=0

" Vim airline
let g:airline_enable_branch=1
let g:airline_branch_empty_message=''
let g:airline_enable_syntastic=1

" Add the virtualenv's site-packages to vim path
if has('python')
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
endif
