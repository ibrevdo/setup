
" {{{ ale configurations
nmap <silent>   [d		    <Plug>(ale_previous_wrap)
nmap <silent>   ]d		    <Plug>(ale_next_wrap)
nmap <silent>   \d	        <Plug>(ale_detail)
nmap <silent>   <C-]>		<Plug>(ale_go_to_definition)
nmap <silent>   \t		    <Plug>(ale_go_to_type_definition)
nmap <silent>   \r          <Plug>(ale_find_references)
nmap <silent>   \k          <Plug>(ale_hover)
nmap <silent>   \s          :ALESymbolSearch -relative<CR>
nmap <silent>   \R          :ALERename<CR>
nmap <silent>   \l          <Plug>(ale_lint)


let g:ale_disable_lsp = 1
let g:ale_hover_cursor = 0

"set omnifunc=ale#completion#OmniFunc
"let g:ale_completion_enabled = 1   "must be set before ale
let g:ale_completion_max_suggestions = 25
"let g:ale_completion_autoimport = 1

let g:ale_floating_preview = 1
let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰']
let g:ale_echo_msg_format='[%linter%]%(code):% %s'


if executable("ccls")
    let s:ccls_root_dir = findfile('.ccls_root', expand('%:p:h', 1) . ';')

    " If we find it use that as the root, otherwise use the vim root
    if s:ccls_root_dir != ''
        let s:ccls_root_dir = fnamemodify(s:ccls_root_dir, ':p:h')
    else
        let s:ccls_root_dir = g:my_project_root
    endif

    let s:ccls_settings = {
                \ 'cache': { 'directory': s:ccls_root_dir . '/.ccls_cache_ale' },
                \ 'highlight': { 'lsRanges' : v:true },
                \ 'diagnostics': { 'onChange' : -1 },
                \ 'completion': { 'maxNum' : 40 },
                \ }
    let g:ale_cpp_ccls_init_options = s:ccls_settings

endif

let g:ale_linters = {
			\ 'c':['cc', 'ccls'], 'cpp': ['cc','ccls'],
			\ 'python': ['flake8', 'pydocstyle', 'bandit', 'mypy'],
			\ }
let g:ale_linters_ignore = {'c':['clang', 'clang++'], 'cpp': ['clang', 'clang++']}

let g:ale_fixers = {
			\'python': ['black', 'isort'],
			\}
"\'*': ['remove_trailing_lines', 'trim_whitespace'],

let g:ale_fix_on_save = 1

" }}}
