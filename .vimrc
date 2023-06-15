call plug#begin('~/.vim/plugged')

" Snippets support
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-vsnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'hrsh7th/cmp-path'
" Conveninences
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'scrooloose/nerdtree'
Plug 'benmills/vimux'
Plug 'preservim/tagbar'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-eunuch'
Plug 'mileszs/ack.vim'
Plug 'onsails/lspkind.nvim'
" Shortcuts
Plug 'christoomey/vim-tmux-navigator'

" Colorscheme
Plug 'NLKNguyen/papercolor-theme'
Plug 'noahfrederick/vim-hemisu'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
" Language support
Plug 'elixir-editors/vim-elixir'

" Git Support
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'will133/vim-dirdiff'

" Vimwiki
Plug 'vimwiki/vimwiki'

" Language Support
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'


" Flutter
Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'
Plug 'natebosch/vim-lsc'
Plug 'natebosch/vim-lsc-dart'

" Initialize plugin system
call plug#end()


" Autocomplete configuration
" Enable on startup
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

" Colorscheme
colorscheme PaperColor
let hour = strftime("%H")
if hour >= 4 && hour < 20
  set background=light
else
  set background=dark
endif
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
set spell spelllang=en_us
set nowrap

highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=DarkRed
au BufEnter * match ExtraWhitespace /\s\+$/

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
autocmd BufNewFile,BufRead *.heex :set filetype=eelixir

" NOTE: You can use other key to expand snippet.

" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)

lua <<EOF
require("mason").setup()
require("mason-lspconfig").setup()

-- After setting up mason-lspconfig you may set up servers via lspconfig
-- require("lspconfig").sumneko_lua.setup {}
-- require("lspconfig").rust_analyzer.setup {}
-- ...
local has_words_before = function()
unpack = unpack or table.unpack
local line, col = unpack(vim.api.nvim_win_get_cursor(0))
return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end
local cmp = require'cmp'
cmp.setup({
  formatting = {
    fields = { "abbr", "menu", "kind" },
    format = function(entry, item)
        -- Define menu shorthand for different completion sources.
        local menu_icon = {
            nvim_lsp = "NLSP",
            nvim_lua = "NLUA",
            luasnip  = "LSNP",
            buffer   = "BUFF",
            path     = "PATH",
        }
        -- Set the menu "icon" to the shorthand for each completion source.
        item.menu = menu_icon[entry.source.name]

        -- Set the fixed width of the completion menu to 60 characters.
        -- fixed_width = 20

        -- Set 'fixed_width' to false if not provided.
        fixed_width = fixed_width or false

        -- Get the completion entry text shown in the completion window.
        local content = item.abbr

        -- Set the fixed completion window width.
        if fixed_width then
            vim.o.pumwidth = fixed_width
        end

        -- Get the width of the current window.
        local win_width = vim.api.nvim_win_get_width(0)

        -- Set the max content width based on either: 'fixed_width'
        -- or a percentage of the window width, in this case 20%.
        -- We subtract 10 from 'fixed_width' to leave room for 'kind' fields.
        local max_content_width = fixed_width and fixed_width - 10 or math.floor(win_width * 0.2)

        -- Truncate the completion entry text if it's longer than the
        -- max content width. We subtract 3 from the max content width
        -- to account for the "..." that will be appended to it.
        if #content > max_content_width then
            item.abbr = vim.fn.strcharpart(content, 0, max_content_width - 3) .. "..."
        else
            item.abbr = content .. (" "):rep(max_content_width - #content)
        end
        return item
    end,
},
snippet = {
  -- REQUIRED - you must specify a snippet engine
  expand = function(args)
  vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
  end,
},
window = {
   completion = cmp.config.window.bordered({
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
        }),
   documentation = cmp.config.window.bordered({
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
        }),
},
mapping = {

  -- ... Your other mappings ...

  ["<Tab>"] = cmp.mapping(function(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  elseif vim.fn["vsnip#available"](1) == 1 then
    feedkey("<Plug>(vsnip-expand-or-jump)", "")
  elseif has_words_before() then
    cmp.complete()
  else
    fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
    end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function()
    if cmp.visible() then
      cmp.select_prev_item()
    elseif vim.fn["vsnip#jumpable"](-1) == 1 then
      feedkey("<Plug>(vsnip-jump-prev)", "")
      end
      end, { "i", "s" }),

      -- ... Your other mappings ...

},
sources = cmp.config.sources({
{ name = 'nvim_lsp' },
{ name = 'vsnip' }, -- For vsnip users.
-- { name = 'luasnip' }, -- For luasnip users.
-- { name = 'ultisnips' }, -- For ultisnips users.
-- { name = 'snippy' }, -- For snippy users.
}, {
  { name = 'buffer' },
})
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
  { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
  })

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
  })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
  { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
  })

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['elixirls'].setup {
  capabilities = capabilities
}
require('lspconfig')['tailwindcss'].setup {
  capabilities = capabilities
}
require('lspconfig')['ruby-lsp'].setup {
  capabilities = capabilities
}
require('lspconfig')['intelephense'].setup {
  capabilities = capabilities
}
EOF

