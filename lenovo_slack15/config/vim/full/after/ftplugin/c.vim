
setlocal commentstring=//\ %s
setlocal nofoldenable foldmethod=indent foldlevelstart=99
setlocal signcolumn=yes


call SetAleMaps()

"no enter after man page
nnoremap <silent><buffer> K 	K<CR>
vnoremap <silent><buffer> K 	K<CR>

"switch to corresponding header/source file
nmap <silent><buffer> <F4>	:e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

"build and run (for single file programs)
nmap <silent><buffer> <F5> :silent make %< <bar> !make %< && ./%< <cr>

nmap <silent><buffer> <F6> :call Build()<CR>
nmap <silent><buffer> <S-F6> :call Rebuild()<CR>

command! CmakeRebuild !clear; rm -r build; mkdir build; cd build; cmake -DCAMKE_RULE_MESSAGES:BOOL=off .. <CR>

" function! RunMake()
" 	wall
" 	if filereadable("./CMakeLists.txt") && filereadable("./build/Makefile")
" 		silent make '--no-print-directory -C build' | redraw! | cc
" 	elseif filereadable("./Makefile") || filereadable("./makefile")
" 		silent make | redraw! | cc
" 	elseif (&filetype == "cpp") || (&filetype == "c")
" 		silent make %< | redraw! | cc
" 	endif
" endfunction

if exists('*Build')
	finish
endif
function! Build()
	wall
 	if filereadable("./CMakeLists.txt") && filereadable("./build/Makefile")
		silent make -C ./build | redraw! | cw
	elseif filereadable("./Makefile") || filereadable("./makefile")
		silent make | redraw! | cw
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

