return {
  {
    "saghen/blink.cmp",
    version = "1.*", -- pin to major: `*` would silently jump to a 2.0 rewrite (cf. nvim-surround v4)
    event = "InsertEnter",
    opts = {
      -- <C-n>/<C-p> are insert-mode Ctrl combos — not affected by Colemak noremap.
      keymap = {
        preset   = "none",
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<CR>"]      = { "accept", "fallback" },
        ["<C-e>"]     = { "hide", "fallback" },
        ["<C-n>"]     = { "select_next", "fallback" },
        ["<C-p>"]     = { "select_prev", "fallback" },
        ["<Tab>"]     = { "snippet_forward", "select_next", "fallback" },
        ["<S-Tab>"]   = { "snippet_backward", "select_prev", "fallback" },
      },
      appearance = {
        nerd_font_variant = "mono",
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      completion = {
        documentation = {
          auto_show       = true,
          auto_show_delay_ms = 300,
        },
        ghost_text = { enabled = true },
      },
    },
  },
}
