setlocal spell
setlocal textwidth=80
setlocal conceallevel=2 concealcursor=

setlocal statusline=%f%m%=
setlocal statusline+=%{printf('[%s,%s,%s]',utils#show_lang(),&spell?'sp':'nosp',&filetype)}
"setlocal statusline+=%{printf('[%s,%s,%s]',&iminsert?'ru':'en',&spell?'sp':'nosp',&filetype)}
setlocal statusline+=\ %c%V\,%3l\/%L\ %2P

"markdown - disable error syntax
hi link markdownError Normal

nnoremap <leader>h :g/^#/<CR>
