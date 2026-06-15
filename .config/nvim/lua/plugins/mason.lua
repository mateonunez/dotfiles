return {
  {
    "williamboman/mason.nvim",
    cmd   = "Mason",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()

      -- auto-install tools on first launch
      local ensure_installed = {
        -- LSP servers (match lsp.lua)
        "lua-language-server",
        "typescript-language-server",
        "pyright",
        "rust-analyzer",
        -- Formatters (used by conform.lua)
        "biome",
        "stylua",
      }

      local registry = require("mason-registry")
      registry.refresh(function()
        for _, name in ipairs(ensure_installed) do
          local pkg = registry.get_package(name)
          if not pkg:is_installed() then
            pkg:install()
          end
        end
      end)
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = { automatic_installation = true },
  },
}
