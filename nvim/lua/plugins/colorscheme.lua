return {
  -- add gruvbox
  {
    "catppuccin/nvim",
  },
  { "ellisonleao/gruvbox.nvim" },
  {
    "folke/tokyonight.nvim",
    config = function()
      vim.cmd([[colorscheme tokyonight-day]])
    end,
  },
  { "sainnhe/everforest" },
}
