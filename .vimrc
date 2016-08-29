" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  filetype off

  " Required:
  set runtimepath^=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
"Git support
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'L9'
NeoBundle 'airblade/vim-gitgutter'

" Syntax
NeoBundle 'scrooloose/syntastic'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'tomtom/tlib_vim'
NeoBundle 'MarcWeber/vim-addon-mw-utils'
NeoBundle 'honza/vim-snippets'
NeoBundle 'tpope/vim-surround'

" Navigation and usability
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'chrisbra/NrrwRgn'
"NeoBundle 'ervandew/supertab'
NeoBundle 'severin-lemaignan/vim-minimap'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'tpope/vim-eunuch'
NeoBundle 'will133/vim-dirdiff'
NeoBundle 'Konfekt/FastFold'
if has('nvim')
  NeoBundle 'Shougo/deoplete.nvim'
  NeoBundle 'zchee/deoplete-go'
else
  NeoBundle 'Shougo/neocomplete.vim'
endif

NeoBundle 'jiangmiao/auto-pairs'
"NeoBundle 'vim-scripts/AutoComplPop'
" Colorschemes
NeoBundle 'morhetz/gruvbox'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'tomasr/molokai'
NeoBundle 'noahfrederick/vim-hemisu'
NeoBundle 'jpo/vim-railscasts-theme'
NeoBundle 'antlypls/vim-colors-codeschool'
NeoBundle 'gosukiwi/vim-atom-dark/'
NeoBundle 'vim-scripts/mayansmoke'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'rakr/vim-one'
NeoBundle 'dracula/vim'
" Language Support
" Ruby/Rails
NeoBundle 'tpope/vim-rake'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-bundler'

" Coffee Script
NeoBundle 'kchmck/vim-coffee-script'

"Ember
"Handlebars
NeoBundle 'mustache/vim-mustache-handlebars'
NeoBundle 'chrisgillis/vim-bootstrap3-snippets'

" Go Lang
NeoBundle 'fatih/vim-go'

"Quick notes and time tracking
NeoBundle 'vimwiki/vimwiki'

"Angular
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'othree/javascript-libraries-syntax.vim'
NeoBundle 'matthewsimo/angular-vim-snippets'
NeoBundle 'claco/jasmine.vim'
NeoBundle 'burnettk/vim-angular'

"Jade
NeoBundle 'digitaltoad/vim-jade'

"Elixir
NeoBundle 'elixir-lang/vim-elixir'
NeoBundle 'avdgaag/vim-phoenix'

"css
NeoBundle 'genoma/vim-less'
NeoBundle 'JulesWang/css.vim'

"React
NeoBundle 'mxw/vim-jsx'

call neobundle#end()

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

filetype plugin indent on    " required
syntax on
set tabstop=2 shiftwidth=2 expandtab
"autocmd Filetype html setlocal ts=2 sts=2 sw=2
"autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
"autocmd Filetype javascript setlocal ts=4 sts=4 sw=4
autocmd Filetype python setlocal ts=4 sts=4 sw=4 expandtab
autocmd Filetype go setlocal ts=4 sts=4 sw=4 noexpandtab

set number
runtime macros/matchit.vim
set spell spelllang=en_us
set nowrap

" Trigger configuration.
let g:UltiSnipsExpandTrigger="<s-tab>"
let g:UltiSnipsJumpForwardTrigger="<s-tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" ctrlp
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist|bower_components|tmp|deps|_build|rel)|(\.(swp|ico|git|svn))$'
let g:ctrlp_working_path_mode = '0'
"Tagbar
nmap <F12> :TagbarToggle<CR>

"Supertab
"let g:SuperTabDefaultCompletionType = "context"
if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#enable_smart_case = 1
  let g:deoplete#auto_completion_start_length = 1
  let g:deoplete#sources#syntax#min_keyword_length = 1
else
  let g:neocomplete#enable_at_startup = 1
  " Use smartcase.
  let g:neocomplete#enable_smart_case = 1
  " " Set minimum syntax keyword length.
  let g:neocomplete#auto_completion_start_length = 1
  let g:neocomplete#sources#syntax#min_keyword_length = 1
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
  let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

  " Define keyword.
  if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns['default'] = '\h\w*'
endif

inoremap <expr><tab> pumvisible() ? "\<C-n>" : "\<C-h>"

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
if has('gui_running')
  set guifont=Source\ Code\ Pro\ for\ Powerline\ Medium\ 12
  set guioptions-=m  "remove menu bar
  set guioptions-=T  "remove toolbar
  set guioptions-=r  "remove right-hand scroll bar
  set guioptions-=L  "remove left-hand scroll bar
  set lines=55 columns=120

  "let colorschemeirline_theme='one'
  let g:hybrid_custom_term_colors = 1
  let g:jellybeans_use_term_italics = 1
  let g:one_allow_italics = 1 " I love italic for comments
  colorscheme jellybeans
else
  let g:hybrid_custom_term_colors = 1
  let g:jellybeans_use_term_italics = 1
  colorscheme jellybeans
endif

if has('nvim')
  set t_Co=256
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  let colorschemeirline_theme='one'
  let g:hybrid_custom_term_colors = 1
  let g:jellybeans_use_term_italics = 1
  let g:one_allow_italics = 1 " I love italic for comments
  colorscheme jellybeans
endif

"Jasmine react tests
au BufRead,BufNewFile *test.js set filetype=jasmine.javascript syntax=jasmine omnifunc=syntaxcomplete#Complete
autocmd FileType jasmine.javascript UltiSnipsAddFiletypes javascript-jasmine

"Stylus
au BufRead,BufNewFile *.styl set filetype=css syntax=css omnifunc=syntaxcomplete#Complete
autocmd FileType css UltiSnipsAddFiletypes css

"Better ruby omnicomplete
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
let g:rubycomplete_buffer_loading=1
let g:rubycomplete_rails = 1
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
"set completeopt=longest,menuone,preview,menu
"imap . .<c-x><c-o>


"Golang
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"

"Folding
set foldmethod=syntax
set foldlevelstart=20
set smartindent
nnoremap <F9> za
let g:indent_guides_enable_on_vim_startup = 0
"Vim Airline
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
set ttimeoutlen=50
set t_ut=
set mouse=

let g:syntastic_ruby_checkers          = ['rubocop', 'mri']
let g:syntastic_ruby_rubocop_exec      = '/usr/local/bin/rubocop'
let g:syntastic_enable_elixir_checker  = 1

nmap <F5> :!emacs doc/worklog.org &<CR>
nmap <F2> :grep -R --exclude-dir data --exclude-dir log --exclude-dir .git "

highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/
