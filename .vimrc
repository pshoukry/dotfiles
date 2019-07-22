call plug#begin('~/.vim/plugged')

" Snippets support
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Conveninences
Plug 'scrooloose/nerdtree'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Colorscheme
Plug 'morhetz/gruvbox'

" Language support
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" Fuzzy finder
Plug 'junegunn/fzf'

" 

" Initialize plugin system
call plug#end()


" Autocomplete configuration
" Enable on startup
let g:deoplete#enable_at_startup = 1

" Colorscheme
colorscheme gruvbox
set background=light

" Ugly fix for tmux, mac and nvim clipboard
set clipboard=unnamed

