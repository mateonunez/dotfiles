return {
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      -- ] / [ are not remapped; 't' here is a literal mapping continuation.
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Prev todo" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>",   desc = "Todos (trouble)" },
      { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find todos" },
    },
    opts = {},
  },
}
