
" most of the configurations taken from here:
" https://github.com/jlesquembre/dotfiles/blob/746dc229305f9c447dff98f8240371ecdb57e032/nvim/init.vim#L1126-L1187

call defx#custom#option('_', {
			\ 'winwidth': 30,
			\ 'split': 'vertical',
			\ 'direction': 'topleft',
			\ 'show_ignored_files': 0,
			\ 'buffer_name': 'explorer',
            \ 'listed' : 1,
            \ 'resume' : 1,
			\ })

call defx#custom#column('icon', {
            \ 'directory_icon': '▸ ',
            \ 'file_icon': '  ',
            \ 'opened_icon': '▾ ',
            \ 'root_icon': '',
            \ })

" Toggle Defx

nnoremap <silent>   \\  :Defx -toggle<CR>
nnoremap <silent>   \f  :Defx -search_recursive=`expand('%:p')`<CR>

" let g:loaded_netrwPlugin = 1 " Disable netrw.vim

" autocmd FileType defx call s:defx_my_settings()
augroup defxConfig
    autocmd!
    "autocmd FileType defx set nonumber
    autocmd FileType defx set norelativenumber nonumber cursorline
    autocmd FileType defx call s:defx_my_settings()
augroup END

function! s:defx_my_settings() abort
    
    " Define mappings
    nnoremap <silent><buffer><expr> <CR>
                \ defx#is_directory() ?
                \ defx#do_action('open_directory') :
                \ defx#do_action('open', 'wincmd w \| drop')

    nnoremap <silent><buffer><expr> <space>
                \ defx#is_directory() ?
                \ defx#do_action('open_tree', 'toggle') :
                \ defx#do_action('open', 'wincmd w \| drop')

    nnoremap <silent><buffer><expr> <2-leftmouse>
                \ defx#is_directory() ?
                \ defx#do_action('open_tree', 'toggle') :
                \ defx#do_action('open', 'wincmd w \| drop')

    nnoremap <silent><buffer><expr> s   defx#do_action('open', 'wincmd w \| botright split')
    nnoremap <silent><buffer><expr> v   defx#do_action('open', 'botright vsplit')
    nnoremap <silent><buffer><expr> p   defx#do_action('preview')

    nnoremap <silent><buffer><expr> cd defx#do_action('change_vim_cwd')

    " Navigation
    nnoremap <silent><buffer><expr> -   defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> ~   defx#do_action('cd', [getcwd()])


    " File manipulation
    nnoremap <silent><buffer><expr> K       defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> N       defx#do_action('new_file')
    nnoremap <silent><buffer><expr> D       defx#do_action('remove')
    nnoremap <silent><buffer><expr> R       defx#do_action('rename')
    nnoremap <silent><buffer><expr> yy      defx#do_action('copy')
    nnoremap <silent><buffer><expr> dd      defx#do_action('move')
    nnoremap <silent><buffer><expr> P       defx#do_action('paste')

    " Miscellaneous actions
    nnoremap <silent><buffer><expr> .     defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> q     defx#do_action('quit')
    nnoremap <silent><buffer><expr> x     defx#do_action('execute_system')
    nnoremap <silent><buffer><expr> yp    defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> <C-g> defx#do_action('print')
    nnoremap <silent><buffer><expr> <C-l> defx#do_action('redraw') . ':nohlsearch<cr>:syntax sync fromstart<cr><c-l>'
    
    nnoremap <silent><buffer><expr><nowait> m defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> * defx#do_action('toggle_select_all')

    nnoremap <silent><buffer><expr> C defx#do_action('toggle_columns', 'mark:filename:type:size:time')
    nnoremap <silent><buffer><expr> S defx#do_action('toggle_sort', 'time')

    "nnoremap <silent><buffer><expr> e defx#do_action('call', 'OpenRanger')

endfunction

function! g:OpenRanger(context) abort
    let l:dir = s:defx_directory_from_context(a:context)
    execute '-tabnew +set\ filetype=custom_term'
    setlocal nonumber norelativenumber
    call termopen('ranger ' . l:dir)
    execute 'let b:term_title="ranger"'
    execute 'startinsert'
    execute 'autocmd TermClose <buffer> Sayonara'
endfunction

" taken from here : https://github.com/Shougo/defx.nvim/issues/175

