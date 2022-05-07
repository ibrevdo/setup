
" Register ccls C++ lanuage server.
if executable('ccls')
   au User lsp_setup call lsp#register_server({
      \ 'name': 'ccls',
      \ 'cmd': {server_info->['ccls']},
      \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), ['.ccls_root', '.ccls']))},
      \ 'initialization_options': {
          \ 'compilationDatabaseDirectory': 'build',
          \ 'cache': {'directory': expand('.ccls_lsp')}
          \},
      \ 'allowlist': ['c', 'cpp','cxx', 'objc', 'objcpp', 'cc'],
      \ })
endif

function! s:on_lsp_buffer_enabled() abort
    "setlocal omnifunc=lsp#complete
    setlocal completefunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> <C-]> <plug>(lsp-definition)
    nmap <buffer> \s <plug>(lsp-document-symbol-search)
    nmap <buffer> \S <plug>(lsp-workspace-symbol-search)
    nmap <buffer> \r <plug>(lsp-references)
    nmap <buffer> \i <plug>(lsp-implementation)
    nmap <buffer> \t <plug>(lsp-type-definition)
    nmap <buffer> \R <plug>(lsp-rename)
    "nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    "nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    "nmap <buffer> K <plug>(lsp-hover)
    nmap <buffer> \k <plug>(lsp-hover)
    "nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    "nnoremap <buffer> <expr><c-d> lsp#scroll(-4)


    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" dont use popup window
let g:lsp_hover_ui = 'preview'
let g:lsp_preview_float = 0

" disable diagnostics etc.
let g:lsp_diagnostics_enabled                = 0
let g:lsp_diagnostics_signs_enabled          = 0
let g:lsp_diagnostics_virtual_text_enabled   = 0
let g:lsp_diagnostics_highlights_enabled     = 0
let g:lsp_document_code_action_signs_enabled = 0

" other
let g:lsp_completion_documentation_enabled = 0
let g:lsp_signature_help_enabled = 0


