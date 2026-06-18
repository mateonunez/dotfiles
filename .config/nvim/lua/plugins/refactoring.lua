return {
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "lewis6991/async.nvim", -- required since refactoring.nvim moved to async.nvim
    },
    keys = {
      -- <leader>cr: refactor menu (extract function/variable, inline, …) under
      -- the code group. Works in normal and visual mode — select a region first
      -- for extract-function/extract-variable. Uses vim.ui.select (dressing).
      {
        "<leader>cr",
        function() require("refactoring").select_refactor() end,
        mode = { "n", "x" },
        desc = "Refactor menu",
      },
    },
    opts = {},
  },
}
