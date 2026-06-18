return {
  {
    "williamboman/mason.nvim",
    cmd   = "Mason",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()

      -- auto-install tools on first launch
      local ensure_installed = {
        -- LSP servers (match lsp.lua / your VSCode extensions)
        "lua-language-server",
        "typescript-language-server",
        "pyright",
        "rust-analyzer",
        "tailwindcss-language-server",   -- bradlc.vscode-tailwindcss
        "vscode-eslint-language-server", -- dbaeumer.vscode-eslint
        "yaml-language-server",          -- redhat.vscode-yaml
        "taplo",                         -- tamasfe.even-better-toml
        "css-lsp",                       -- web
        "html-lsp",                      -- web
        "marksman",                      -- markdown
        "dockerfile-language-server",    -- docker.docker
        "bash-language-server",
        "clangd",                        -- ms-vscode.cpptools
        -- Formatters (used by conform.lua)
        "biome",
        "stylua",
        "prettierd",                     -- esbenp.prettier-vscode (md/yaml/css/html)
        -- Linters (used by nvim-lint)
        "eslint_d",
        "ruff",
        "shellcheck",
        "markdownlint",
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
