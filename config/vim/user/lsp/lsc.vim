
" {{{ vim-lsc configurations
let g:lsc_auto_map              = v:true
let g:lsc_enable_autocomplete   = v:true
let g:lsc_enable_diagnostics    = v:false
let g:lsc_hover_popup           = v:true
let g:lsc_trace_level           = "off"

" disable defaults
let g:lsc_auto_map = {'defaults': v:true, 'PreviousReference': ''}
let g:lsc_auto_map = {'defaults': v:true, 'NextReference': ''}
let g:lsc_auto_map = {'defaults': v:true, 'Completion': 'omnifunc'}


let g:lsc_server_commands = {
\ 'cpp': {
\    'command': 'ccls',
\    'log_level': -1,
\    'suppress_stderr': v:true,
\    'message_hooks': {
\        'initialize': {
\            'initializationOptions': {'cache': {'directory': '/tmp/ccls-cache-lsc'}},
\            'rootUri': {m, p -> lsc#uri#documentUri(fnamemodify(findfile('compile_commands.json', expand('%:p') . ';'), ':p:h'))}
\        },
\    },
\  },
\}

" }}}
