" from here: https://git.sr.ht/~ackyshake/dotfiles/tree/main/item/.vim/after/ftplugin/python.vim

" Compiler
setlocal makeprg=python3\ %

setlocal errorformat=%A\ \ File\ \"%f\"\\\,\ line\ %l\\\,%m,
            \%C\ \ \ \ %.%#,
            \%+Z%.%#Error\:\ %.%#,
            \%A\ \ File\ \"%f\"\\\,\ line\ %l,
            \%+C\ \ %.%#,
            \%-C%p^,
            \%Z%m,
            \%-G%.%#

function! s:lint()
    if !executable("flake8")
        echoerr "Cannot find 'flake8'!"
        return
    endif

    let save = winsaveview()
    silent lexpr system("flake8 --extend-ignore=E265,E266 " . shellescape(expand("%"))) | silent redraw! | lwindow
    call winrestview(save)
endfunction

" Commands
command! -nargs=+ -buffer Pydoc call utils#run_pydoc("<args>")
command! -buffer Lint call s:lint()

nnoremap <f5> :call utils#make()<cr>

let b:indentLine_enabled = 1
