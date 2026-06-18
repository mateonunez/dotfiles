return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-jest",
      "marilari88/neotest-vitest",
      "nvim-neotest/neotest-python",
    },
    keys = {
      -- <leader>r = run / test group ('r' is remapped r→s, so typed Space+p —
      -- same pattern as the other remapped-key leader groups).
      { "<leader>rr", function() require("neotest").run.run() end,                    desc = "Test: run nearest" },
      { "<leader>rf", function() require("neotest").run.run(vim.fn.expand("%")) end,   desc = "Test: run file" },
      { "<leader>rl", function() require("neotest").run.run_last() end,                desc = "Test: run last" },
      { "<leader>rd", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Test: debug nearest" },
      { "<leader>rs", function() require("neotest").summary.toggle() end,              desc = "Test: toggle summary" },
      { "<leader>ro", function() require("neotest").output.open({ enter = true }) end, desc = "Test: show output" },
      { "<leader>rp", function() require("neotest").output_panel.toggle() end,         desc = "Test: output panel" },
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-vitest"),
          require("neotest-jest"),
          require("neotest-python"),
        },
        -- Colemak: the summary's defaults bind `e` (expand_all) and `i` (jumpto),
        -- which shadow up/right nav (e→k, i→l). Move them to free capitals so
        -- n/e/i navigate the tree as everywhere else.
        summary = {
          mappings = {
            expand_all = "E",
            jumpto     = "I",
          },
        },
      })
    end,
  },
}
