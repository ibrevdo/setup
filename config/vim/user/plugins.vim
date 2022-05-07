
call plug#begin(g:my_vim_directory . "/plugged")

Plug 'junegunn/vim-plug'

Plug 'tpope/vim-sensible'
"Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
"Plug 'tpope/vim-surround'
Plug 'tpope/vim-obsession'
"Plug 'jiangmiao/auto-pairs'
Plug 'tmsvg/pear-tree'
Plug 'romainl/vim-qf'

Plug 'tpope/vim-vinegar'
"Plug 'lambdalisue/fern.vim'

"Plug 'ctrlpvim/ctrlp.vim'
"Plug '~/.fzf'
"Plug 'junegunn/fzf.vim'

"Plug 'romainl/vim-cool'
Plug 'romainl/Apprentice'
Plug 'agude/vim-eldar'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'srcery-colors/srcery-vim'
Plug 'lifepillar/vim-solarized8'

if has("gui_running")
	Plug 'kassio/neoterm'
endif

"Plug 'ludovicchabant/vim-gutentags'
Plug 'dense-analysis/ale'
"
"Plug 'prabirshrestha/vim-lsp'
"Plug 'lighttiger2505/deoplete-vim-lsp'

"Plug 'natebosch/vim-lsc'
"Plug 'cdelledonne/vim-cmake'
Plug 'octol/vim-cpp-enhanced-highlight'

" CMake Syntax and Indent
Plug 'Kitware/CMake', { 'rtp': 'Auxiliary/vim' }
" CMake complete
Plug 'richq/vim-cmake-completion'


" Completion
"Plug 'lifepillar/vim-mucomplete'
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'  }
    Plug 'Shougo/defx.nvim'
    "Plug 'kristijanhusak/defx-icons'
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
    Plug 'Shougo/defx.nvim'
    "Plug 'kristijanhusak/defx-icons'
endif

" Language server support
"Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }

" Language server highlighting
"Plug 'jackguo380/vim-lsp-cxx-highlight', { 'for': ['c', 'cpp'] }


Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'

call plug#end()
