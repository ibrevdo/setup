
" {{{ netrw
" do not load netrw
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1
"let g:netrw_browse_split = 4
" }}}

" {{{ lambdalisue/fern.vim
let g:fern#disable_default_mappings   = 1
"let g:fern#default_exclude = '^\%(Debug\|build\)$'
let g:fern#hide_cursor = 1
"let g:fern#drawer_keep = 1

"drawer view start
" nnoremap <silent> _       :Fern . -drawer -toggle -width=35<CR><C-w>=
" nnoremap <silent> -   :Fern . -drawer -reveal=% -width=35<CR><C-w>=

"split view start
"note: ':e.' is equal to :Fern .
nnoremap <silent> -     :Fern %:h -reveal=%<CR>
nnoremap <silent> _     :Fern . -reveal=%<CR>

function! s:fernInit() abort
    nmap <buffer><expr>
                \ <Plug>(fern-my-open-enter)
                \ fern#smart#leaf(
                \   "\<Plug>(fern-action-open)",
                \   "\<Plug>(fern-action-enter)",
                \ )
    nmap <buffer><expr>
                \ <Plug>(fern-my-expand-collapse)
                \ fern#smart#leaf(
                \   "\<Plug>(fern-action-collapse)",
                \   "\<Plug>(fern-action-expand)",
                \   "\<Plug>(fern-action-collapse)",
                \ )
    nmap <buffer><expr>
                \ <Plug>(fern-my-open-expand-collapse)
                \ fern#smart#leaf(
                \   "\<Plug>(fern-action-open)\<CR>\<C-w>p",
                \   "\<Plug>(fern-action-expand)",
                \   "\<Plug>(fern-action-collapse)",
                \ )

    nmap <buffer> <nowait> <CR>     <Plug>(fern-my-open-enter)
    " nmap <buffer> <nowait> <BS>       <Plug>(fern-action-collapse)
    nmap <buffer> <2-LeftMouse>     <Plug>(fern-my-open-expand-collapse)
    nmap <buffer> <nowait> <Space>  <Plug>(fern-my-expand-collapse)
    nmap <buffer> <nowait> -        <Plug>(fern-action-leave)
    " nmap <buffer><nowait> < <Plug>(fern-action-leave)
    " nmap <buffer><nowait> > <Plug>(fern-action-enter)

    nmap <buffer> r <Plug>(fern-action-reload)
    nmap <buffer> m <Plug>(fern-action-mark:toggle)
    nmap <buffer> e <Plug>(fern-action-open)
    nmap <buffer> o <Plug>(fern-action-open:split)
    nmap <buffer> v <Plug>(fern-action-open:vsplit)
    nmap <buffer> t <Plug>(fern-action-open:tabedit)
    nmap <buffer> s <Plug>(fern-action-open:select)
    nmap <buffer> <nowait> H <Plug>(fern-action-hidden:toggle)

    nmap <buffer> N <Plug>(fern-action-new-path)
    nmap <buffer> C <Plug>(fern-action-copy)
    nmap <buffer> M <Plug>(fern-action-move)
    nmap <buffer> D <Plug>(fern-action-remove)
    nmap <buffer> R <Plug>(fern-action-rename)

    "let g:fern#mark_symbol                       = '●'
    " let g:fern#renderer#default#collapsed_symbol = '▷ '
    " let g:fern#renderer#default#expanded_symbol  = '▼ '
    " let g:fern#renderer#default#leading          = '  '
    " let g:fern#renderer#default#leaf_symbol      = '  '
    " let g:fern#renderer#default#root_symbol      = '⏏ '

    let g:fern_git_status#disable_ignored    = 1
    let g:fern_git_status#disable_untracked  = 1
    let g:fern_git_status#disable_submodules = 1

endfunction

augroup FernConfig
    autocmd! *
    autocmd FileType fern setlocal norelativenumber | setlocal nonumber | call s:fernInit()
augroup END
" }}}

