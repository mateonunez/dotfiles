return {
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      -- <leader>g = git / GitHub group. 'g' is remapped (g→t), so after the
      -- leader it's typed as physical Space+d — same pattern as <leader>d
      -- (codediff, physical Space+s). Requires the `gh` CLI, authenticated.
      { "<leader>gp", "<cmd>Octo pr list<cr>",    desc = "GitHub: PR list" },
      { "<leader>gP", "<cmd>Octo pr create<cr>",  desc = "GitHub: create PR" },
      { "<leader>gi", "<cmd>Octo issue list<cr>", desc = "GitHub: issue list" },
      { "<leader>gv", "<cmd>Octo pr review<cr>",  desc = "GitHub: review PR" },
    },
    opts = {},
  },
}
