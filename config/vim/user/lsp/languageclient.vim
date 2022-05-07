" Language Server Configuration

" LanguageClient
nnoremap <C-]> 		:call LanguageClient#textDocument_definition()<CR>
nnoremap <leader>lr :call LanguageClient#textDocument_references()<CR>
nnoremap <leader>li :call LanguageClient#textDocument_implementation()<CR>
nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
nnoremap <leader>lR :call LanguageClient#textDocument_rename()<CR>

" ccls specific
nnoremap <leader>lfc :call LanguageClient#findLocations({'method':'$ccls/call'})<CR>
nnoremap <leader>lfv :call LanguageClient#findLocations({'method':'$ccls/vars'})<CR>
nnoremap <leader>lfd :call LanguageClient#findLocations({'method':'$ccls/inheritance', 'derived': v:true})<CR>
nnoremap <leader>lfb :call LanguageClient#findLocations({'method':'$ccls/inheritance'})<CR>
nnoremap <leader>lfp :call LanguageClient#findLocations({'method':'$ccls/navigate', 'direction': 'U'})<CR>

let g:LanguageClient_diagnosticsList = 'Location'
let g:LanguageClient_selectionUI = 'quickfix'

let g:LanguageClient_serverCommands = {}
let g:LanguageClient_rootMarkers = {}
let g:LanguageClient_semanticHighlightMaps = {}

let g:lsp_cxx_hl_use_text_props = 1

" For large files this is a more appropriate timeout
let g:LanguageClient_waitOutputTimeout = 30

let g:LanguageClient_diagnosticsEnable = 1

let s:ccls_lang_server_executable = ["ccls"]

if executable(s:ccls_lang_server_executable[0])
    " Search upwards for .ccls_root marker
    let s:ccls_root_dir = findfile('.ccls_root', expand('%:p:h', 1) . ';')

    " If we find it use that as the root, otherwise use the vim root
    if s:ccls_root_dir != ''
        let s:ccls_root_dir = fnamemodify(s:ccls_root_dir, ':p:h')
    else
        let s:ccls_root_dir = g:my_project_root
    endif

    let s:ccls_settings = {
                \ 'cache': { 'directory': s:ccls_root_dir . '/.ccls_cache' },
                \ 'highlight': { 'lsRanges' : v:true },
                \ 'diagnostics': { 'onChange' : -1 },
                \ 'completion': { 'maxNum' : 40 },
                \ }

    let s:ccls_exec = s:ccls_lang_server_executable + ['-init=' . json_encode(s:ccls_settings)]
    let g:LanguageClient_serverCommands['c'] = s:ccls_exec
    let g:LanguageClient_serverCommands['cpp'] = s:ccls_exec
    let g:LanguageClient_rootMarkers['c'] = ['compile_commands.json', '.ccls_root']
    let g:LanguageClient_rootMarkers['cpp'] = ['compile_commands.json', '.ccls_root']
endif
