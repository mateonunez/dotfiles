return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      -- LSP already covers type errors; these add the linters your VSCode uses
      -- where the LSP doesn't lint. eslint_d/ruff/etc. no-op when a project has
      -- no matching config, so they're safe to enable globally.
      lint.linters_by_ft = {
        javascript      = { "eslint_d" },
        typescript      = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        python          = { "ruff" },
        sh              = { "shellcheck" },
        markdown        = { "markdownlint" },
      }

      local grp = vim.api.nvim_create_augroup("nvim_lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        group = grp,
        callback = function()
          -- only lint modifiable, listed buffers
          if vim.bo.modifiable and vim.bo.buftype == "" then
            require("lint").try_lint()
          end
        end,
      })
    end,
  },
}
