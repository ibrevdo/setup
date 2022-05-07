
let g:markdown_folding=1
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']

setlocal conceallevel=2
setlocal nofoldenable
"setlocal foldlevel=99

" preservim/vim-markdown
let g:vim_markdown_folding_disabled = 1
nmap <C-LeftMouse>  <Plug>Markdown_OpenUrlUnderCursor
vmap <C-LeftMouse>  <Plug>Markdown_OpenUrlUnderCursor

"map <F7> "+pA)<C-o>B[](<left><left>
nmap <F7> a[]()<ESC><left>"+pBa
