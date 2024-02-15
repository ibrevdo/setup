if exists("g:loaded_igor_term")
    finish
endif

let g:loaded_igor_term=1

" if a file is opened in vim's builtin terminal, it goes to current vim's
" window (either new or existing - drop command)
" from here: https://www.reddit.com/r/vim/comments/tkcxhq/how_to_open_a_file_in_the_current_neovimvim_from/
if $vimInstanceExists
  autocmd BufNewFile,BufReadPre * exec 'bd | !printf "\033]51;[\"drop\", \"'. expand('%:p') . '\"]\007"' | q
else
  let $vimInstanceExists = 1
endif

function! ChooseTerm(termname, is_slider)
    let pane = bufwinnr(a:termname)
    let buf = bufexists(a:termname)
    if pane > 0
        "pane is visible
        if a:is_slider == 1
            :exe pane . "wincmd c"
        endif
    elseif buf > 0
        " buffer exists
        if a:is_slider == 1
            topleft split
            resize 10
        endif
        :exe "buffer " . a:termname
    else
        "buffer is not loaded, create
        if a:is_slider == 1
            :exe "topleft terminal ++rows=10"
        endif
        :exe "f " . a:termname
    endif
endfunction

command! -nargs=+ ChooseTerm :call ChooseTerm("<args>")

" Toggle 'default' terminal
" nnoremap <C-m> :call ChooseTerm("term-slider", 1)<CR>
" tnoremap <C-m> <C-w>:call ChooseTerm("term-slider", 1)<CR>

" Start terminal in current pane
"nnoremap <C-M> :call ChooseTerm("term-pane", 0)<CR>

" function! ChooseTerm(termname, slider)
"     let pane = bufwinnr(a:termname)
"     let buf = bufexists(a:termname)
"     " echom "pane=" . pane . ", buf=" . buf
"     if pane > 0
"         " pane is visible
"         if a:slider > 0
"             :exe pane . "wincmd c"
"         else
"             :exe "e #" 
"         endif
"     elseif buf > 0
"         " buffer is not in pane
"         if a:slider
"             botright split
"             resize 10
"         endif
"         :exe "buffer " . a:termname
"     else
"         " buffer is not loaded, create
"         if a:slider
"             :exe "botright terminal ++rows=10"
"         endif
"         :exe "f " a:termname
"     endif
" endfunction

