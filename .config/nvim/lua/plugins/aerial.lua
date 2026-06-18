return {
  -- Symbols outline (VS Code's Outline panel). Inside the panel, the global
  -- Colemak noremap applies, so n/e move down/up and <CR> jumps.
  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>cs", "<cmd>AerialToggle!<cr>", desc = "Symbols outline" },
    },
    opts = {
      backends = { "lsp", "treesitter", "markdown" },
      layout   = { default_direction = "right", min_width = 28 },
    },
  },
  -- Breadcrumbs in the winbar (VS Code's breadcrumb trail). barbecue wires up
  -- nvim-navic against the LSP automatically.
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      show_modified = true,
      attach_navic  = true,
    },
  },
}
