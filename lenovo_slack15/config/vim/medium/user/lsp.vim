vim9script

var lspServers = [
	{
		name: 'clangd',
		filetype: ['c', 'cpp'],
		path: '/usr/bin/clangd',
		args: ['--background-index', '--clang-tidy']
	}
]

autocmd VimEnter * call LspAddServer(lspServers)

var lspOpts = {
	#  autoComplete: false,
	autoHighLightDiags: true,
	autoPopulateDiags: true,
	completionMatcher: 'fuzzy',
	diagVirtualTextAlign: 'after',
	hideDisabledCodeActions: true,
	showDiagOnStatusLine: true,
	showDiagWithVirtualText: true,
}

autocmd VimEnter * call LspOptionsSet(lspOpts)

augroup LSP
	au!
	au User LspAttached call AttachLsp()
augroup END

def AttachLsp()
	nnoremap <buffer> K			<cmd>LspHover<Cr>
	nnoremap <buffer> gd		<cmd>LspGotoDefinition<Cr>
	nnoremap <buffer> <C-W>gd	<cmd>topleft LspGotoDefinition<CR>
	nnoremap <buffer> gi		<cmd>LspGotoImpl<Cr>
	nnoremap <buffer> gt 		<cmd>LspGotoTypeDef<Cr>
	nnoremap <buffer> sr 		<cmd>LspShowReferences<Cr>
	#nnoremap <buffer> ]g <cmd>LspDiagNext<Cr>
	#nnoremap <buffer> [g <cmd>LspDiagPrev<Cr>
	nmap <silent><buffer> [D 		        :LspDiagFirst<CR>
	nmap <silent><buffer> [d 		        :LspDiagPrev<CR>
	nmap <silent><buffer> ]d 		        :LspDiagNext<CR>
	nmap <silent><buffer> ]D 		        :LspDiagLast<CR>

	highlight link LspDiagLine NONE
enddef

# stolen from: 
# https://github.com/ubaldot/dotfiles/blob/main/.vimrc
augroup LSP_DIAG
	autocmd!
	autocmd BufEnter *  b:num_warnings = 0 | b:num_errors = 0
	autocmd User LspDiagsUpdated b:num_warnings = lsp#lsp#ErrorCount()['Warn']
				\ | b:num_errors = lsp#lsp#ErrorCount()['Error']
augroup END
