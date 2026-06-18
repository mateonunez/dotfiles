return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      delay = 500, -- ms after pressing a prefix before popup appears
      icons = {
        mappings = false,
      },
      spec = {
        -- Group labels so the popup is readable instead of flat
        { "<leader>a", group = "ai / claude" },
        { "<leader>c", group = "code / LSP" },
        { "<leader>f", group = "find (telescope)" },
        { "<leader>h", group = "git hunks" },
        { "<leader>x", group = "trouble / diagnostics" },
        { "<leader>m", group = "harpoon" },
        { "<leader>w", group = "window (splits)" },
        { "<leader>t", group = "tabs" },
        { "<leader>s", group = "search / replace" },
        { "<leader>d", group = "diff (codediff)" },
        { "]",         group = "next" },
        { "[",         group = "prev" },
      },
    },
  },
}
