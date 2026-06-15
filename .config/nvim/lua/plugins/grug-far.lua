return {
  {
    "MagicDuck/grug-far.nvim",
    cmd  = "GrugFar",
    keys = {
      -- <leader>w: 'w' = workspace, not remapped in Colemak
      { "<leader>w",  "<cmd>GrugFar<cr>",                                              desc = "Search & replace (workspace)" },
      -- Open with current word pre-filled
      { "<leader>W",  function() require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } }) end, desc = "Search & replace (current word)" },
    },
    opts = {
      headerMaxWidth = 80,
    },
  },
}
