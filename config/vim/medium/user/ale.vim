
let g:ale_enabled = 1		"default: 1
let g:ale_disable_lsp = 1	"default: 0
"let g:ale_completion_enabled = 1 "default: 0

let g:ale_lint_on_text_changed='never'	"default: 'normal'
let g:ale_lint_on_insert_leave = 0		"default: 1
let g:ale_lint_on_enter = 1				"default: 1
let g:ale_lint_on_save = 1				"default: 1
let g:ale_lint_on_filetype_changed = 1	"default: 1

" preview window will open when cursor is on warning/error
"let g:ale_cursor_detail=0	"default: 0

" echo truncated warning/error message
"let g:ale_echo_cursor=1	"default: 1

" echo truncated information
let g:ale_hover_cursor=0	"default: 1

" preview the hover(info) and detail(warnings/errors) messages in floating window
" equivalent to:
" g:ale_hover_to_floating_window=1 and g:ale_detail_to_floating_preview=1
let g:ale_floating_preview = 1
let g:ale_floating_window_border = []
"let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰', '│', '─']


" set completeopt=menu,menuone,popup,noselect,noinsert
" augroup HoverAfterComplete
" 	autocmd!
" 	autocmd User ALECompletePost ALEHover
" augroup END

function! SetAleMaps() abort
	" manual completion
	inoremap <silent><buffer> <C-Space>	<C-\><C-O>:ALEComplete<CR>
	nnoremap <silent><buffer> \r		:ALEFindReferences -quickfix<CR>
	nnoremap <silent><buffer> <C-]>		:ALEGoToDefinition<CR>
	nnoremap <silent><buffer> \t		:ALEGoToTypeDefinition<CR>
	nnoremap <silent><buffer> \R		:ALERename<CR>
	nnoremap <silent><buffer> \a		:ALECodeAction<CR>
	nnoremap <silent><buffer> \d		:ALEDetail<CR>
	nnoremap <silent><buffer> \l		:ALELint<CR>

	" Map movement through errors without wrapping.
	nmap <silent><buffer> [d 		<Plug>(ale_previous)
	nmap <silent><buffer> ]d 		<Plug>(ale_next)
endfunction


