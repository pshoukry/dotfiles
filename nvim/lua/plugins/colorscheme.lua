return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },
  { "folke/tokyonight.nvim" },
  {
    "sainnhe/everforest",
    config = function()
      vim.cmd([[colorscheme everforest]])
      vim.cmd([[set background=light]])
    end,
  },
}
