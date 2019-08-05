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
Plug 'slashmili/alchemist.vim'
Plug 'elixir-editors/vim-elixir'

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
filetype plugin on
set omnifunc=syntaxcomplete#Complete

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
nnoremap <silent> <c-p> :FZF<CR>

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

" Reload if file changes
set autoread

" Syntax
syntax enable
set tabstop=2 shiftwidth=2 expandtab
autocmd Filetype python setlocal ts=4 sts=4 sw=4 expandtab
autocmd Filetype go setlocal ts=4 sts=4 sw=4 noexpandtab

au BufRead,BufNewFile *.txt set filetype=markdown

set number
runtime macros/matchit.vim
set spell spelllang=en_us
set nowrap

highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=DarkRed
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

set backspace=indent,eol,start
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

" Deoplete selction box
inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<Up>"

let g:alchemist_compile_basepath = '/app/'
