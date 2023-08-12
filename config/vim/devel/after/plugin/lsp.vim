vim9script
# echo "after/plugin/lsp.vim"

if !exists("g:loaded_lsp")
    finish
endif

var pylsp_config = {
    'pylsp': {
        #'configurationSources': ['flake8'],
        'plugins': {
            'autopep8': {
                'enabled': v:true}, 
            # 'flake8': {
            #     'enabled': v:true},
            'pyflakes': {
                'enabled': v:true},
            'pycodestyle': {
                'enabled': v:true},
            'pydocstyle': {
                'enabled': v:false},
            'mccabe': {
                'enabled': v:true},
        }, 
    }, 
}

var lspServers = [
    {
        name: 'clangd',
        filetype: ['c', 'cpp'],
        path: '/usr/bin/clangd',
        args: ['--background-index', '--clang-tidy']
    },
    # {
    #     name: 'ccls',
    #     filetype: ['c', 'cpp'],
    #     path: 'ccls',
    #     debug: true,
    # },
    {
        name: 'pylsp',
        filetype: ['python'],
        path: 'pylsp',
        workspaceConfig: pylsp_config,
    },
]

var lspOpts = {
    #aleSupport: true,
    #autoComplete: false,
    autoHighLightDiags: true,
    autoPopulateDiags: true,
    completionMatcher: 'fuzzy',
    diagVirtualTextAlign: 'after',
    hideDisabledCodeActions: true,
    showDiagOnStatusLine: true,
    showDiagWithVirtualText: true,
}

def AttachLsp()

    nnoremap <silent><buffer> K             <cmd>LspHover<Cr>
    nnoremap <silent><buffer> <C-]>         <cmd>LspGotoDefinition<Cr>
    # nnoremap <silent><buffer> <C-W><C-]>    <cmd>topleft LspGotoDefinition<CR>
    # nnoremap <silent><buffer> gi            <cmd>LspGotoImpl<Cr>
    # nnoremap <silent><buffer> gt            <cmd>LspGotoTypeDef<Cr>
    # nnoremap <silent><buffer> gr            <cmd>LspShowReferences<Cr>

    nnoremap <silent><buffer> [D        <cmd>LspDiagFirst<CR>
    nnoremap <silent><buffer> [d        <cmd>LspDiagPrev<CR>
    nnoremap <silent><buffer> ]d        <cmd>LspDiagNext<CR>
    nnoremap <silent><buffer> ]D        <cmd>LspDiagLast<CR>

    highlight link LspDiagLine NONE
enddef

augroup LSP
    au!

    au VimEnter * call LspOptionsSet(lspOpts)
    au VimEnter * call LspAddServer(lspServers)
    au User LspAttached call AttachLsp()

    au BufEnter *  b:num_warnings = 0 | b:num_errors = 0
    au User LspDiagsUpdated b:num_warnings = lsp#lsp#ErrorCount()['Warn']
                \ | b:num_errors = lsp#lsp#ErrorCount()['Error']

    au FileType python,c,cpp setlocal statusline=%f%m%=
                \ statusline+=%#CurSearch#\W:%{b:num_warnings}\,E:%{b:num_errors}\ %*
                \ statusline+=\ %y
                \ statusline+=\ %c%V\,%3l\/%L\ %2P

    au FileType python,c,cpp setlocal tagfunc=lsp#lsp#TagFunc
augroup END


