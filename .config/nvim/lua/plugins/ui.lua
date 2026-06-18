return {
  -- Better vim.ui.select / vim.ui.input — turns code actions, rename, and the
  -- refactor menu into proper floating pickers (VS Code-like quick-pick).
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {},
  },
  -- LSP progress notifications in the corner (like VS Code's status spinner).
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      notification = { window = { winblend = 0 } },
    },
  },
}
