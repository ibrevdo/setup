
if !exists("g:loaded_ale")
    finish
endif

let g:ale_enabled = 1       "default: 1
let g:ale_disable_lsp = 1   "default: 0
"let g:ale_completion_enabled = 1 "default: 0

let g:ale_lint_on_text_changed='normal' "default: 'normal'
let g:ale_lint_on_insert_leave = 1      "default: 1
let g:ale_lint_on_enter = 1             "default: 1
let g:ale_lint_on_save = 1              "default: 1
let g:ale_lint_on_filetype_changed = 0  "default: 1

let g:ale_sign_column_always = 1        "default: 0

" preview window will open when cursor is on warning/error
"let g:ale_cursor_detail=0  "default: 0

" echo truncated warning/error message
"let g:ale_echo_cursor=1    "default: 1

" echo truncated information
let g:ale_hover_cursor=0    "default: 1

" preview the hover(info) in preview window
" let g:ale_hover_to_preveiw=1 "default: 0

" preview the hover(info) in floating window (popup)
" let g:ale_hover_to_floating_preveiew=1    " default: 0

" preview detail(warnings/errors) messages in floating window (popup)
" let g:ale_detail_to_floating_preview=1    " default: 0

" combination of previous two options
let g:ale_floating_preview = 1      "default: 0

let g:ale_floating_window_border = []
"let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰', '│', '─']

let g:ale_c_clangtidy_checks = ['-*', 'cppcoreguidelines-*']

"use only linters from g:ale_linters list
let g:ale_linters_explicit = 1

"let g:ale_cpp_cc_executable = 'gcc'

let g:ale_linters = {
            \ 'c':['cc'],
            \ 'cpp': ['cc'],
            \ 'python': ['flake8'],
            \ }
            " \ 'c':['cc', 'ccls'],
            " \ 'cpp': ['cc', 'ccls'],
            " \ 'python': ['flake8', 'pydocstyle', 'bandit', 'mypy'],

" let g:ale_linters_ignore = {
"           \ 'c':['clang', 'clang++'],
"           \ 'cpp': ['clang', 'clang++'],
"           \ }

" let g:ale_fixers = {
"           \'python': ['black', 'isort'],
"           \'*': ['remove_trailing_lines', 'trim_whitespace'],
"           \ }

function! SetAleMaps() abort

    " Ctrl-Space for completions. try omnifunc, if no result try key completion
    " setlocal omnifunc=ale#completion#OmniFunc
    " inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
    "             \ "\<lt>C-n>" :
    "             \ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
    "             \ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
    "             \ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
    " imap <C-@> <C-Space>

    " Map movement through errors without wrapping.
    nnoremap <silent><buffer> [d            <Plug>(ale_previous_wrap)
    nnoremap <silent><buffer> ]d            <Plug>(ale_next_wrap)

    nnoremap <silent><buffer> \l            :ALELint<CR>
    nnoremap <silent><buffer> \d            :ALEDetail<CR>
    nnoremap <silent><buffer> \h            :ALEHover<CR>
    " nnoremap <silent><buffer> <C-]>       :ALEGoToDefinition<CR>
    " nnoremap <silent><buffer> <C-w><C-]>  :ALEGoToDefinition -split<CR>
    " nnoremap <silent><buffer> \t          :ALEGoToTypeDefinition<CR>
    " nnoremap <silent><buffer> \r          :ALEFindReferences -quickfix<CR>
    " nnoremap <silent><buffer> \R          :ALERename<CR>
    " nnoremap <silent><buffer> \a          :ALECodeAction<CR>

endfunction


function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    "return l:all_errors == 0 ? '' : 'E'
    return l:counts.total == 0 ? 'OK' : printf(
                \   'W:%d,E:%d',
                \   all_non_errors,
                \   all_errors
                \)
endfunction

augroup ALE
    au!
    au VimEnter * call SetAleMaps()
    au FileType python,c,cpp setlocal statusline=%f%m%=
                \ statusline+=%#CurSearch#\ %{LinterStatus()}\ %*
                \ statusline+=\ %y
                \ statusline+=\ %c%V\,%3l\/%L\ %2P
augroup end
