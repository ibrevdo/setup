
"==============================================
" Plugins configuration
"==============================================

"{{{ vifm/vifm.vim
" let g:loaded_netrw       = 1
" let g:loaded_netrwPlugin = 1
" let g:vifm_replace_netrw = 1
" let g:vifm_embed_term = 1
"}}}

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

"{{{ preservim/vim-markdown
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_folding_disabled = 1
"}}}

"{{{ lervag/vimtex
let g:vimtex_view_method = 'zathura'
"}}}

"{{{ ludovicchabant/vim-gutentags
"let g:gutentags_project_root = ['Makefile', 'CMakeLists.txt']
let g:gutentags_project_root = ['.tags']
let g:gutentags_add_default_project_roots = 0
let g:gutentags_ctags_tagfile = ".tags"

let g:gutentags_ctags_exclude_wildignore = 1
let g:gutentags_ctags_exclude = [
			\'node_modules', 'Debug', 'build', 'CMakeFiles', '.mypy_cache', 'venv',
			\'*.md', '*.css', '*.html', '*.json', '*.xml', '*.txt']
let g:gutentags_ctags_extra_args = ['--c++-kinds=+pl', '--fields=+iaS', '--extra=+q']
"}}}

" {{{ OmniCppComplete

" configure tags - add additional tags here or comment out not-used ones
" build tags of your own project with Ctrl-F12
map <C-F12> :!ctags --c++-kinds=+pl --fields=+iaS --extra=+q -f .tags<CR>

let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::

" also necessary for fixing LIBSTDC++ releated stuff
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
"
" automatically open and close the popup menu / preview window
"au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
"set completeopt=menuone,menu,longest,preview
"}}}

" {{{ UltiSnips
" let g:UltiSnipsSnippetStorageDirectoryForUltiSnipsEdit='~/.vim/UltiSnips'
" }}}

"{{{ dispatch
nnoremap <leader>T :Dispatch<CR>
"}}}

"{{{ ackyshake/VimCompletesMe
" au FileType cpp let b:vcm_tab_complete = "omni"
let g:vcm_direction = 'p'
let g:vcm_s_tab_behaveior = 1
let g:vcm_s_tab_mapping = "\<C-o>a"
"}}}

