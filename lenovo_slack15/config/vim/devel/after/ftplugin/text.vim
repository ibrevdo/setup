setlocal spell
setlocal textwidth=80

setlocal statusline=%f%m%=
setlocal statusline+=%{printf('[%s,%s,%s]',utils#show_lang(),&spell?'sp':'nosp',&filetype)}
setlocal statusline+=\ %c%V\,%3l\/%L\ %2P
