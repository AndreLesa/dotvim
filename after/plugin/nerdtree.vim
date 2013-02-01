"autocmd VimEnter * NERDTree | wincmd p –

" Activate nerdtree
"autocmd VimEnter * silent NERDTree
"autocmd BufEnter * silent NERDTreeMirror
"autocmd VimEnter * wincmd w

" If nerdtree is last and only buffer, quit vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
