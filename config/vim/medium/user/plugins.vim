
"==============================================
" Plugins configuration
"==============================================

"{{{ bfrg/vim-cpp-modern

" Disable function highlighting (affects both C and C++ files)
let g:cpp_function_highlight = 0

" Enable highlighting of C++11 attributes
let g:cpp_attributes_highlight = 1

" Highlight struct/class member variables (affects both C and C++ files)
let g:cpp_member_highlight = 0

" Put all standard C and C++ keywords under Vim's highlight group 'Statement'
" (affects both C and C++ files)
let g:cpp_simple_highlight = 1
"}}}

"{{{ derekwyatt/vim-fswitch
"nnoremap <silent> <F4> :FSHere<cr>
"nnoremap <silent> <leader>h :FSSplitAbove<cr>
"}}}

"{{{ ctrlpvim/ctrlp.vim
let g:ctrlp_map = '<leader>f'

nnoremap <leader>b	:CtrlPBuffer<CR>

let g:ctrlp_root_markers = ['Makefile', 'CMakeLists.txt']
let g:ctrlp_mru_files = 0 " Disable Most Recently Used files feature
let g:ctrlp_jump_to_buffer = 2 " Jump to tab AND buffer if already open

if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
else
  let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
endif

" jump to tag extension
"let g:ctrlp_extensions = ['tag']
"nnoremap <leader>] 	:execute 'CtrlPTag' expand('<cword>')<CR>

" or use special plugin: https://github.com/ivalkeen/vim-ctrlp-tjump
" let g:ctrlp_tjump_only_silent = 1
" nnoremap <c-]> :CtrlPtjump<cr>
" vnoremap <c-]> :CtrlPtjumpVisual<cr>

"}}}

"{{{ preservim/tagbar
"nmap <F8> :TagbarToggle<CR>
"}}}

"{{{ ludovicchabant/vim-gutentags
let g:gutentags_project_root = ['Makefile', 'CMakeLists.txt']
let g:gutentags_ctags_tagfile = ".tags"

"set rulerformat+=%{gutentags#statusline('_','_')}
let g:gutentags_ctags_exclude_wildignore = 1
let g:gutentags_ctags_exclude = [
			\'node_modules', 'Debug', 'build', 'CMakeFiles', '.mypy_cache', 'venv',
			\'*.md', '*.css', '*.html', '*.json', '*.xml', '*.txt']
"}}}

"{{{ dispatch
nnoremap <leader>T :Dispatch<CR>
"}}}

"{{{ airblade/git-gutter
let g:gitgutter_grep		= 'ag'
let g:gitgutter_map_keys	= 0
nmap [g			<Plug>(GitGutterPrevHunk)zz
nmap ]g			<Plug>(GitGutterNextHunk)zz
nmap <leader>g	<Plug>(GitGutterPreviewHunk)
nmap <leader>+	<Plug>(GitGutterStageHunk)
nmap <leader>-	<Plug>(GitGutterUndoHunk)
"}}}

"for integration with ale
let g:gitgutter_sign_priority=9
let g:ale_sign_priority=30
"}}}

"{{{ ackyshake/VimCompletesMe
" au FileType cpp let b:vcm_tab_complete = "omni"
"}}}

"{{{ xavierd/clang_complete
let g:clang_auto_select=1			" default: 0
let g:clang_complete_auto=0			" default: 1

let g:clang_snippets=1				" default: 0
"let g:clang_snippets_engine='ultisnips'	" default: clang_complete

" set conceallevel=2
" set concealcursor=vin
" let g:clang_conceal_snippets=1

let g:clang_user_options='-std=c++14'
let g:clang_auto_user_options='.clang_complete, path, compile_commands.json'
if isdirectory(g:my_project_root . '/build/')
	let g:clang_compilation_database=g:my_project_root . '/build/'
endif

let g:clang_use_library=1
"let g:clang_library_path='/usr/lib64/libclang.so'

let g:clang_complete_macros=1

"}}}

"{{{ lifepillar/vim-mucomplete
set noinfercase
set completeopt-=preview
set completeopt+=menuone,noselect

let g:mucomplete#enable_auto_at_startup = 1

let g:mucomplete#chains = {}
let g:mucomplete#chains = {
			\ 'default' : ['path', 'keyn', 'dict', 'uspl'],
			\ 'vim'		: ['path', 'cmd', 'keyn'],
			\ 'cpp'		: ['ulti', 'omni', 'tags'] 
			\ }

" expand snippets or complete text using only <tab>
let g:ulti_expand_or_jump_res = 0

fun! TryUltiSnips()
	if !pumvisible() " With the pop-up menu open, let Tab move down
		call UltiSnips#ExpandSnippetOrJump()
	endif
	return ''
endf

fun! TryMUcomplete()
	return g:ulti_expand_or_jump_res ? "" : "\<plug>(MUcompleteFwd)"
endf

" inoremap <plug>(TryUlti) <c-r>=TryUltiSnips()<cr>
" imap <expr> <silent> <plug>(TryMU) TryMUcomplete()
" imap <expr> <silent> <tab> "\<plug>(TryUlti)\<plug>(TryMU)"

"}}}


"{{{ maralla/completor.vim
" let g:completor_filetype_map = {}

" make cpp complete using ALE:
" let g:completor_filetype_map.cpp = {'ft': 'ale'}

"}}}
