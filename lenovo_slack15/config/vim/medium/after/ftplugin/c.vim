
setlocal commentstring=//\ %s
setlocal signcolumn=yes

"setlocal nofoldenable foldmethod=indent foldlevelstart=99
"setlocal nofoldenable foldmethod=marker foldmarker={,}

command! -nargs=+ Cppman silent! call system("tmux split-window -b cppman " . expand(<q-args>))
nnoremap <silent><buffer> K <Esc>:Cppman <cword><CR>

"call SetAleMaps()
"set omnifunc=omni#cpp#complete#Main

"setlocal rulerformat=%m
"setlocal rulerformat+=%{LinterStatus()}
"setlocal rulerformat+=%{gutentags#statusline('_','_')}
"setlocal rulerformat+=\ %l,%c%V%=%P

"switch to corresponding header/source file
nmap <silent><buffer> <F4>	:e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" suitable when using cmake that creates the makefile in 'build' dir
" setlocal makeprg=make\ --no-print-directory\ -C\ build

"build and run (for single file programs)
nnoremap <buffer> <CR> :!make %< && ./%< <CR>

" nmap <silent><buffer> <F6> :call Build()<CR>
" nmap <silent><buffer> <S-F6> :call Rebuild()<CR>

if exists('CompileAndRun')
	finish
endif

"nnoremap <buffer> <CR> :CompileAndRun time<CR>
command! -nargs=1 CompileAndRun :call Compile_and_Run(<q-args>)
command! CMakeRebuild :call CMake_Rebuild()

" suitable when using cmake that creates the makefile in 'build' dir
function! Compile_and_Run(target)
    wall
    exe '!clear; make --no-print-directory -C build && build/' . a:target
endfunction

function! CMake_Rebuild()
    wall
    exe '!clear; rm -r build; mkdir -p build;
    \ cd build; cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 ..'
endfunction

function! Build()
	wall
 	if filereadable("./CMakeLists.txt") && filereadable("./build/Makefile")
		silent make -C ./build | redraw! | cw
	elseif filereadable("./Makefile") || filereadable("./makefile")
		"silent make | redraw! | cw
		make! | cw
	elseif (&filetype == "cpp") || (&filetype == "c")
		silent make %< | redraw! | cw
	endif
endfunction

function! Rebuild()
	silent !clear; rm -r build
	if filereadable("./CMakeLists.txt")
		silent !mkdir -p build
		silent !cd build; cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 ..
		let l:cmake_result = v:shell_error
		if (l:cmake_result == '0')
			redraw!
			call Build()
		else
			redraw!
			echo 'Error in CMakeLists.txt'
		endif
	elseif
		call Build()
	endif
endfunction

