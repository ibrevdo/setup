function! MarkdownFolds()
	return "1"
endfunction

function! MarkdownFolds()
    if getline(v:lnum) =~ '^# .*$'
        return ">1"
    endif
    if getline(v:lnum) =~ '^## .*$'
        return ">2"
    endif
    if getline(v:lnum) =~ '^### .*$'
        return ">3"
    endif
    if getline(v:lnum) =~ '^#### .*$'
        return ">4"
    endif
    return "="
endfunction

setlocal foldexpr=MarkdownFolds()
setlocal foldmethod=expr
