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
        "eslint-lsp",                    -- dbaeumer.vscode-eslint (ships vscode-eslint-language-server)
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
          -- get_package throws on an unknown name — guard so one typo can't
          -- abort the whole install loop (and mason's config).
          local ok, pkg = pcall(registry.get_package, name)
          if ok and not pkg:is_installed() then
            pkg:install()
          elseif not ok then
            vim.notify("mason: unknown package '" .. name .. "' (skipped)", vim.log.levels.WARN)
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
