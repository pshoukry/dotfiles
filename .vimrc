call plug#begin('~/.vim/plugged')

" Snippets support
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Conveninences
Plug 'scrooloose/nerdtree'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'terryma/vim-multiple-cursors'
Plug 'scrooloose/nerdtree'
Plug 'benmills/vimux'
Plug 'tpope/vim-surround'
Plug 'preservim/tagbar'
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-eunuch'

" Shortcuts
Plug 'christoomey/vim-tmux-navigator'

" Colorscheme
Plug 'NLKNguyen/papercolor-theme'
Plug 'noahfrederick/vim-hemisu'
" Language support
" Plug 'slashmili/alchemist.vim'
Plug 'elixir-editors/vim-elixir'
Plug 'williamboman/nvim-lsp-installer'

" Git Support
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'will133/vim-dirdiff'

" Vimwiki
Plug 'vimwiki/vimwiki'

" Language Support
" Plug 'OmniSharp/omnisharp-vim' "c#
Plug 'neovim/nvim-lspconfig'
Plug 'deoplete-plugins/deoplete-lsp'

" Flutter
Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'
Plug 'natebosch/vim-lsc'
Plug 'natebosch/vim-lsc-dart'

" Initialize plugin system
call plug#end()


" Autocomplete configuration
" Enable on startup
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_completion_start_length = 1
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" Required for operations modifying multiple buffers like rename.
set hidden

" Or map each action separately
nnoremap <silent> <c-p> :FZF<CR>
nnoremap <silent> <c-u> :NERDTreeToggle<CR>
nnoremap <silent> <F2> :VimuxPromptCommand<CR>
nnoremap <silent> <F6> :VimuxRunLastCommand<CR>
nnoremap <F8> :TagbarToggle<CR>

" Tagbar Elixir support
let g:tagbar_type_elixir = {
      \ 'ctagstype' : 'elixir',
      \ 'kinds' : [
      \ 'p:protocols',
      \ 'm:modules',
      \ 'e:exceptions',
      \ 'y:types',
      \ 'd:delegates',
      \ 'f:functions',
      \ 'c:callbacks',
      \ 'a:macros',
      \ 't:tests',
      \ 'i:implementations',
      \ 'o:operators',
      \ 'r:records'
      \ ],
      \ 'sro' : '.',
      \ 'kind2scope' : {
      \ 'p' : 'protocol',
      \ 'm' : 'module'
      \ },
      \ 'scope2kind' : {
      \ 'protocol' : 'p',
      \ 'module' : 'm'
      \ },
      \ 'sort' : 0
      \ }

" Enable fuzzy finding
set rtp+=/usr/local/opt/fzf

" Colorscheme
colorscheme PaperColor

if strftime("%H") < 17
  set background=light
else
  set background=dark
endif

" Ugly fix for tmux, mac and nvim clipboard
set clipboard=unnamed

" Reload if file changes
set autoread

" Syntax
syntax enable
set tabstop=2 shiftwidth=2 expandtab
autocmd Filetype python setlocal ts=4 sts=4 sw=4 expandtab
autocmd Filetype go setlocal ts=4 sts=4 sw=4 noexpandtab
let &colorcolumn=join(range(81,999),",") " Darker background above 80 chars width

au BufRead,BufNewFile *.txt set filetype=markdown

set number
set mouse=a
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
let g:python2_host_prog = '/usr/bin/python3'

" Omnisharp-vim
let g:OmniSharp_server_use_mono = 1
let g:OmniSharp_selector_ui = 'fzf'


" Language servers configuration
 lua << EOF
 local lsp_installer = require("nvim-lsp-installer")

-- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
-- or if the server is already installed).
lsp_installer.on_server_ready(function(server)
    local opts = {}

    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end

    -- This setup() function will take the provided server configuration and decorate it with the necessary properties
    -- before passing it onwards to lspconfig.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)
EOF
