
"--------------------- PLUGINS CONFIGS -------------------


" vim-cool config
"let g:CoolTotalMatches = 1

" {{{ romainl/vim-qf
let g:qf_mapping_ack_style = 1
" s - open entry in a new horizontal window
" v - open entry in a new vertical window
" t - open entry in a new tab
" o - open entry and come back
" O - open entry and close the location/quickfix window
" p - open entry in a preview window
nmap    <leader>l   <Plug>(qf_loc_toggle_stay)
nmap    <leader>q   <Plug>(qf_qf_toggle_stay)
nmap    ]l          :lnext<CR>
nmap    [l          :lprev<CR>
nmap    ]q          :ccnext<CR>
nmap    [q          :cprev<CR>
" }}}


"{{{ Shougo/deoplete

"Enable deoplete when InsertEnter.
"let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_at_startup = 0
autocmd InsertEnter * call deoplete#enable()

call deoplete#custom#source('_', 'max_menu_width', 80)
"call deoplete#custom#option('ignore_sources', {'_': ['around', 'buffer']})
" call deoplete#custom#option('ignore_sources', {'_': ['ale']})
call deoplete#custom#option('auto_complete_delay',100)

" Use ALE as completion source
" call deoplete#custom#option('sources',{
"             \ 'cpp': ['ale'],
"             \})

"}}}

" {{{ octol/vim-cpp-enhanced-highlight
let c_no_curly_error=1
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_simple_template_highlight = 1
"let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1
" }}}

"let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['Makefile']
let g:gutentags_ctags_exclude = [
			\ 'saSim',
			\ 'build',
			\ 'bin',
			\ '.*cache*',
			\ '*.class', '*.pyc',
			\ '*.exe', '*.dll', '*.d', '*.so', '*.o',
			\ '*.zip' ,'*.tar', '*.gz',
			\ ]
let g:gutentags_ctags_tagfile = '.tags'

" {{{ fzf.vim
" Use preview when FzfFiles run in fullscreen
"command! -nargs=? -bang -complete=dir FzfFiles
"            \ call fzf#vim#files(<q-args>, <bang>0 ? fzf#vim#with_preview('up:60%') : {}, <bang>0)
nnoremap <silent> <leader>ff  :Files<CR>
nnoremap <silent> <leader>fb  :Buffers<CR>
nnoremap <silent> <leader>fF  :FzfFiles!<CR>
nnoremap <silent> <leader>f.  :Files <C-r>=expand("%:p:h")<CR><CR>
"" }}}

" {{{ lambdalisue/fern.vim
let g:fern#default_exclude = '^\%(Debug\|build\)$'
let g:fern#disable_default_mappings   = 1

noremap <silent> \\         :Fern . -drawer -toggle -width=35<CR><C-w>=
noremap <silent> <leader>nr :Fern . -drawer -reveal=% -width=35<CR><C-w>=
noremap <silent> <leader>n. :Fern %:h -drawer -width=35<CR><C-w>=

function! FernInit() abort
    nmap <buffer><expr>
                \ <Plug>(fern-my-enter)
                \ fern#smart#leaf(
                \   "\<Plug>(fern-action-open:select)",
                \   "\<Plug>(fern-action-enter)",
                \   "\<Plug>(fern-action-enter)",
                \ )
    nmap <buffer><expr>
                \ <Plug>(fern-my-open-expand-collapse)
                \ fern#smart#leaf(
                \   "\<Plug>(fern-action-open)\<CR>\<C-w>p",
                \   "\<Plug>(fern-action-expand)",
                \   "\<Plug>(fern-action-collapse)",
                \ )
	  nmap <buffer><expr>
	        \ <Plug>(fern-my-expand-or-collapse)
	        \ fern#smart#leaf(
	        \   "\<Plug>(fern-action-expand)",
	        \   "\<Plug>(fern-action-expand)",
	        \   "\<Plug>(fern-action-collapse)",
	        \ )

    nmap <buffer> <2-LeftMouse> <Plug>(fern-my-open-expand-collapse)
    nmap <buffer> <nowait> <RightMouse> <Plug>(fern-my-expand-or-collapse)

    nmap <buffer> <Space> <Plug>(fern-my-open-expand-collapse)
    nmap <buffer> <nowait> <CR> <Plug>(fern-my-enter)

    nmap <buffer> <nowait> - <Plug>(fern-action-leave)
    nmap <buffer> <nowait> h <Plug>(fern-action-hidden:toggle)
    nmap <buffer> p <Plug>(fern-action-open)<C-w><C-p>
    nmap <buffer> m <Plug>(fern-action-mark:toggle)
    nmap <buffer> n <Plug>(fern-action-new-path)
    nmap <buffer> D <Plug>(fern-action-remove)
    nmap <buffer> M <Plug>(fern-action-move)
    nmap <buffer> R <Plug>(fern-action-rename)
    nmap <buffer> s <Plug>(fern-action-open:split)
    nmap <buffer> v <Plug>(fern-action-open:vsplit)
    nmap <buffer> r <Plug>(fern-action-reload)

	let g:fern#mark_symbol                       = '●'
	let g:fern#renderer#default#collapsed_symbol = '▷ '
	let g:fern#renderer#default#expanded_symbol  = '▼ '
	let g:fern#renderer#default#leading          = '  '
	let g:fern#renderer#default#leaf_symbol      = '  '
	let g:fern#renderer#default#root_symbol      = '⏏ '
endfunction

augroup FernEvents
	autocmd!
	autocmd FileType fern call FernInit()
augroup END
" }}}

" {{{ cassio/neoterm
if has("gui_running")
	let g:neoterm_default_mod = 'botright'
	let g:neoterm_size = 10
	let g:neoterm_autoscroll = '1'
	let g:neoterm_autoinsert=1
	nnoremap <C-\> 		:Ttoggle<cr>
	tnoremap <C-\> 		<C-w>:Ttoggle<cr>
	tnoremap <leader><Esc> <C-\><C-n>:silent q!<CR>
endif
" }}}
