return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    keys = {
      -- Find on <leader>f (no Ctrl): <C-p> shadowed native cursor-up and just
      -- duplicated <leader>ff. Picker-internal Ctrl keys (move selection) stay
      -- in `defaults.mappings` below since they only act inside the picker.
      { "<leader>ff", "<cmd>Telescope find_files<cr>",  desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>",   desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",     desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>",   desc = "Help tags" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>",    desc = "Recent files" },
      { "<leader>fc", "<cmd>Telescope commands<cr>",    desc = "Commands" },
      { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
    },
    opts = {
      defaults = {
        -- Mirror VSCode `search.exclude` so grep/find results stay clean.
        -- (ripgrep already honours .gitignore for find_files; this also covers
        -- live_grep and non-git dirs.)
        file_ignore_patterns = {
          "%.git/",
          "node_modules/",
          "%.pnpm/",
          "%.yarn/",
          "bower_components/",
          "dist/",
          "out/",
          "%.output/",
          "%.nuxt/",
          "tmp/",
          "logs/",
          "package%-lock%.json",
          "pnpm%-lock%.yaml",
          "yarn%.lock",
        },
        -- Colemak: n=j(down), e=k(up), i=l(right), h=h(left)
        mappings = {
          i = {
            ["<C-n>"] = "move_selection_next",
            ["<C-e>"] = "move_selection_previous",
          },
          n = {
            ["n"] = "move_selection_next",
            ["e"] = "move_selection_previous",
            ["q"] = "close",
          },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")
    end,
  },
}
