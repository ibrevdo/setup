
function! utils#make()
    wall
    silent !clear
    make
endfunction

function! utils#toggle_quickfix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

function! utils#toggle_loclist()
    if empty(filter(getwininfo(), 'v:val.loclist'))
        lopen
    else
        lclose
    endif
endfunction

function! utils#show_lang()
    "echom "Calling show_lang"
    if &iminsert
        if &keymap =~? "hebrew"
            return "he"
        elseif &keymap =~? "russian"
            return "ru"
        else
            return '??'
        end
    else
        return "en"
    end
endfunc

function! utils#toggle_hebrew()
  if &keymap ==? "hebrew"
    set keymap=
  else
    set keymap=hebrew
  end
endfunc

" Run `pydoc` on a given string
function! utils#run_pydoc(cmd)
  if !executable("pydoc3")
    echoerr "Cannot find 'pydoc3'"
    return
  endif

  let reg_save = @/
  try
    silent! execute "topleft pedit pydoc3"
    wincmd P
    resize 20

    execute "-read! pydoc3 ".a:cmd . " 2>&1 "
    silent! %s/\s\+$//g
    set buftype=nofile
    set syntax=python
    setlocal bufhidden=delete
    normal! 1G

    wincmd p
  finally
    let @/ = reg_save
  endtry
endfunction

