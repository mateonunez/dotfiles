return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- Keymaps wired via LspAttach (nvim 0.11+ approach, replaces on_attach)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp_keymaps", { clear = true }),
        callback = function(event)
          local map = function(keys, fn, desc)
            vim.keymap.set("n", keys, fn, { buffer = event.buf, desc = desc })
          end

          -- <leader>c prefix — 'c' is not remapped in Colemak
          map("<leader>ch", vim.lsp.buf.hover,          "Hover docs")
          map("<leader>ca", vim.lsp.buf.code_action,    "Code action")
          map("<leader>cw", vim.lsp.buf.rename,         "Rename symbol")
          map("<leader>cx", vim.diagnostic.open_float,  "Diagnostics float")
          map("<leader>cv", vim.lsp.buf.references,     "References")
          map("<leader>cq", vim.lsp.buf.definition,     "Go to definition")
          map("<leader>cm", vim.lsp.buf.implementation, "Go to implementation")
          -- ]x / [x: ']' and '[' are not remapped, 'x' is not remapped
          map("]x", vim.diagnostic.goto_next, "Next diagnostic")
          map("[x", vim.diagnostic.goto_prev, "Prev diagnostic")
        end,
      })

      -- blink.cmp capabilities (injected when available)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, blink = pcall(require, "blink.cmp")
      if ok then
        capabilities = blink.get_lsp_capabilities(capabilities)
      end

      -- Global config for all servers (vim.lsp.config '*' = applies to every server)
      vim.lsp.config("*", { capabilities = capabilities })

      -- Per-server overrides
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace   = { checkThirdParty = false },
          },
        },
      })

      -- Enable servers — mason-lspconfig ensures they are installed
      vim.lsp.enable({ "lua_ls", "ts_ls", "rust_analyzer", "pyright" })
    end,
  },
}
