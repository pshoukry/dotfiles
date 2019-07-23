call plug#begin('~/.vim/plugged')

" Snippets support
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Conveninences
Plug 'scrooloose/nerdtree'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Shortcuts
Plug 'christoomey/vim-tmux-navigator'

" Colorscheme
Plug 'morhetz/gruvbox'

" Language support
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" Git Support
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Initialize plugin system
call plug#end()


" Autocomplete configuration
" Enable on startup
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#auto_completion_start_length = 1

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" Enable fuzzy finding
set rtp+=/usr/local/opt/fzf

" Colorscheme
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let g:gruvbox_contrast_light = "hard"
let g:gruvbox_bold = 1
let g:gruvbox_italic = 1
let g:gruvbox_underline = 1
colorscheme gruvbox
set background=light

" Ugly fix for tmux, mac and nvim clipboard
set clipboard=unnamed

