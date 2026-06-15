return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd   = "ConformInfo",
    keys  = {
      -- <leader>z: 'z' is not remapped in Colemak — safe standalone format trigger
      {
        "<leader>z",
        function() require("conform").format({ async = true, lsp_fallback = true }) end,
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        javascript      = { "biome" },
        typescript      = { "biome" },
        javascriptreact = { "biome" },
        typescriptreact = { "biome" },
        json            = { "biome" },
        jsonc           = { "biome" },
        lua             = { "stylua" },
      },
      format_on_save = {
        timeout_ms   = 1000,
        lsp_fallback = true,
      },
    },
  },
}
