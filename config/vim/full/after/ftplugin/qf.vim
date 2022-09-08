
" update the statusline of quickfix window
setlocal statusline=%t\ %=%l/%L

" open quickfix window on the bottom always
wincmd J

" add these mappings to default commands:
" <Enter>, :cn, :cp, C-w<Enter>, :tab copen
nnoremap <buffer><silent> o <CR><C-W>p
nnoremap <buffer><silent> O <CR>:cclose<CR>
nnoremap <buffer><silent> t <C-W><Enter><C-W>T

