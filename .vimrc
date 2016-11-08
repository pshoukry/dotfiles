if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('~/.vim')

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('honza/vim-snippets')

" You can specify revision/branch/tag.
call dein#add('Shougo/vimshell')
call dein#add('Shougo/vimproc.vim', {'build' : 'make'})

call dein#add('tpope/vim-fugitive')
call dein#add('L9')
call dein#add('airblade/vim-gitgutter')

" Syntax
call dein#add('scrooloose/syntastic')
call dein#add('tomtom/tlib_vim')
call dein#add('MarcWeber/vim-addon-mw-utils')
call dein#add('tpope/vim-surround')

" Navigation and usability
call dein#add('ctrlpvim/ctrlp.vim')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('majutsushi/tagbar')
call dein#add('christoomey/vim-tmux-navigator')
call dein#add('terryma/vim-multiple-cursors')
call dein#add('tpope/vim-unimpaired')
call dein#add('chrisbra/NrrwRgn')
call dein#add('severin-lemaignan/vim-minimap')
call dein#add('Yggdroot/indentLine')
call dein#add('tpope/vim-eunuch')
call dein#add('will133/vim-dirdiff')
call dein#add('Konfekt/FastFold')
if has('nvim')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('zchee/deoplete-go')
else
  call dein#add('Shougo/neocomplete.vim')
endif

call dein#add('jiangmiao/auto-pairs')

" Colorschemes
call dein#add('morhetz/gruvbox')
call dein#add('altercation/vim-colors-solarized')
call dein#add('nanotech/jellybeans.vim')
call dein#add('tomasr/molokai')
call dein#add('noahfrederick/vim-hemisu')
call dein#add('jpo/vim-railscasts-theme')
call dein#add('antlypls/vim-colors-codeschool')
call dein#add('vim-scripts/mayansmoke')
call dein#add('w0ng/vim-hybrid')
call dein#add('rakr/vim-one')
call dein#add('dracula/vim')
call dein#add('powerman/vim-plugin-AnsiEsc')

" Language Support
" Ruby/Rails
call dein#add('tpope/vim-rake')
call dein#add('tpope/vim-rails')
call dein#add('tpope/vim-bundler')
call dein#add('danchoi/ri.vim')

" Coffee Script
call dein#add('kchmck/vim-coffee-script')

"Ember
"Handlebars
call dein#add('mustache/vim-mustache-handlebars')
call dein#add('chrisgillis/vim-bootstrap3-snippets')

" Go Lang
call dein#add('fatih/vim-go')

"Quick notes and time tracking
call dein#add('vimwiki/vimwiki')

"Angular
call dein#add('pangloss/vim-javascript')
call dein#add('othree/javascript-libraries-syntax.vim')
call dein#add('matthewsimo/angular-vim-snippets')
call dein#add('claco/jasmine.vim')
call dein#add('burnettk/vim-angular')

"Jade
call dein#add('digitaltoad/vim-jade')

"Elixir
call dein#add('elixir-lang/vim-elixir')
call dein#add('avdgaag/vim-phoenix')
call dein#add('slashmili/alchemist.vim')

"css
call dein#add('genoma/vim-less')
call dein#add('JulesWang/css.vim')

"React
call dein#add('mxw/vim-jsx')

"IOS
call dein#add('eraserhd/vim-ios')

"TDD
call dein#add('janko-m/vim-test')
" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

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

" ctrlp
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist|bower_components|tmp|deps|_build|rel)|(\.(swp|ico|git|svn))$'
let g:ctrlp_map = 'f'
"Tagbar
nmap <F12> :TagbarToggle<CR>

if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#enable_smart_case = 1
  let g:deoplete#auto_completion_start_length = 1
  let g:deoplete#sources#syntax#min_keyword_length = 1
  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

  " Enable heavy omni completion.
  if !exists('g:deoplete#sources#omni#input_patterns')
   let g:deoplete#sources#omni#input_patterns = {}
  endif
  if !exists('g:deoplete#force_omni_input_patterns')
   let g:deoplete#force_omni_input_patterns = {}
  endif
else
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#auto_completion_start_length = 1
  let g:neocomplete#sources#syntax#min_keyword_length = 1
endif

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

if has("gui_macvim")
  set background=dark
  colorscheme jellybeans
else
  set background=dark
  colorscheme jellybeans
end

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

let g:syntastic_ruby_checkers          = ['rubocop', 'mri']
let g:syntastic_enable_elixir_checker  = 1
let g:elixir_use_markdown_for_docs = 1


"Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='wombat'

highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=DarkRed
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

set backspace=indent,eol,start
"Neo Snippets
imap <s-tab>     <Plug>(neosnippet_expand_or_jump)
smap <s-tab>     <Plug>(neosnippet_expand_or_jump)
xmap <s-tab>     <Plug>(neosnippet_expand_target)
let g:neosnippet#snippets_directory="~/.vim/Snippets"

nnoremap gn :bn<cr>

" Custom maps
nnoremap \ed :!dogma %:p
nnoremap \ec :!mix credo

"vim-test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

let test#elixir#exunit#executable = 'docker-compose run --rm web mix test'
autocmd FileType elixir let test#filename_modifier = ':.:s?.*test/?test/?'

autocmd BufWritePre * %s/\s\+$//e
:inoremap \id <C-R>=strftime("%a %d-%b-%Y")<CR>
:inoremap \it <C-R>=strftime("%I:%M%p")<CR>

set guifont=Sauce\ Code\ Powerline:h14

let g:neosnippet#snippets_directory='~/.vim/repos/github.com/honza/vim-snippets/snippets'
