return {
  {
    "MagicDuck/grug-far.nvim",
    cmd  = "GrugFar",
    keys = {
      -- <leader>s = search/replace. (Moved off <leader>w, which is now the window
      -- group — the collision made <leader>W / capital window keys open GrugFar.)
      { "<leader>sr", "<cmd>GrugFar<cr>",                                             desc = "Search & replace" },
      -- Open with current word pre-filled
      { "<leader>sw", function() require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } }) end, desc = "Search & replace (current word)" },
    },
    opts = {
      headerMaxWidth = 80,
    },
  },
}
