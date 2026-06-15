return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Diagnostics (Trouble)" },
      { "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Buffer diagnostics" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>",                             desc = "Quickfix list" },
      { "<leader>xv", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP definitions / refs" },
    },
    opts = {
      modes = {
        diagnostics = {
          -- Colemak nav: global noremap handles n→j and e→k inside the Trouble window.
          keys = {
            ["n"] = "next",   -- physical n → j via noremap → also bind n explicitly
            ["e"] = "prev",   -- physical e → k via noremap → also bind e explicitly
            ["q"] = "close",
            ["<esc>"] = "close",
          },
        },
      },
    },
  },
}
