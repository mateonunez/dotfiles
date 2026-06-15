return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts  = {
      check_ts  = true, -- use treesitter to detect pairs context
      fast_wrap = {
        map = "<M-e>", -- Alt+e: wrap nearest pair (M combos unaffected by Colemak noremap)
      },
    },
    -- No completion integration here: `nvim-autopairs.completion.cmp` hard-requires
    -- nvim-cmp's `cmp` module, which isn't installed (we use blink.cmp). blink
    -- inserts brackets on accept itself via `completion.accept.auto_brackets`
    -- (see blink.lua), so wiring autopairs into completion is unnecessary.
    -- With only `opts` and no `config`, lazy.nvim calls
    -- require("nvim-autopairs").setup(opts) automatically.
  },
}
