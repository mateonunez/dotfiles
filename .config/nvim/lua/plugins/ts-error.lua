return {
  -- Rewrites cryptic TypeScript diagnostics into readable messages
  -- (the nvim analog of yoavbls.pretty-ts-errors). Zero-config; hooks the LSP.
  {
    "dmmulroy/ts-error-translator.nvim",
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    opts = {},
  },
}
