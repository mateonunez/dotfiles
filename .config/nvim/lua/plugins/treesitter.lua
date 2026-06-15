return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master", -- classic API; `main` branch dropped nvim-treesitter.configs
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    main  = "nvim-treesitter.configs", -- tells lazy to call .setup() on this module
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects", branch = "master" },
    },
    opts  = {
      ensure_installed = {
        "lua", "luadoc",
        "typescript", "tsx", "javascript",
        "json", "jsonc",
        "yaml", "toml",
        "markdown", "markdown_inline",
        "bash",
        "dockerfile",
        "gitignore", "gitcommit",
        "html", "css",
        "rust",
        "python",
      },
      auto_install = true,
      highlight  = { enable = true },
      indent     = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          -- <C-space> / <bs>: normal-mode Ctrl combos, unaffected by Colemak noremap
          init_selection   = "<C-space>",
          node_incremental = "<C-space>",
          node_decremental = "<bs>",
        },
      },
      -- Colemak note: noremap applies in operator-pending mode too.
      -- physical 'a' → 'a' (not remapped) = outer prefix ✓
      -- physical 'i' → 'l'  (noremap i→l)  = inner prefix, so keymaps use 'l'
      -- physical 'f' → 'e'  (noremap f→e)  = function object key
      -- physical 'c' → 'c'  (not remapped) = class object key
      -- physical 'b' → 'b'  (not remapped) = block / conditional object key
      --
      -- What to press (physical keys):
      --   outer function → a + f
      --   inner function → i + f   (vim sees l + e → "le")
      --   outer class    → a + c
      --   inner class    → i + c   (vim sees l + c → "lc")
      textobjects = {
        select = {
          enable    = true,
          lookahead = true,
          keymaps   = {
            ["ae"] = "@function.outer", -- physical a + f
            ["le"] = "@function.inner", -- physical i + f  (i→l, f→e)
            ["ac"] = "@class.outer",    -- physical a + c
            ["lc"] = "@class.inner",    -- physical i + c  (i→l)
            ["ab"] = "@block.outer",    -- physical a + b
            ["lb"] = "@block.inner",    -- physical i + b  (i→l)
            ["aa"] = "@parameter.outer",-- physical a + a
            ["la"] = "@parameter.inner",-- physical i + a  (i→l)
          },
        },
        move = {
          enable              = true,
          set_jumps           = true,
          goto_next_start     = {
            ["]e"] = "@function.outer", -- ] + physical f  (f→e)
            ["]c"] = "@class.outer",
          },
          goto_previous_start = {
            ["[e"] = "@function.outer",
            ["[c"] = "@class.outer",
          },
        },
      },
    },
  },
}
