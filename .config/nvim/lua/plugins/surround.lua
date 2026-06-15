-- nvim-surround default triggers (ys / cs / ds) all collide with Colemak:
--   ys → physical 'j' then 'r' (j→y, r→s) — confusing
--   ds → physical 's' then 'r' (s→d, r→s) — confusing
--   cs → 'c' is safe but 's' → physical 'r'
-- Remapped to 'z' prefix — 'z' is not remapped in Colemak.
--
-- Usage (physical keys):
--   za + motion + char  →  add surrounding    e.g. za + w + "  wraps word in quotes
--   zaa                 →  surround current line
--   zx + char           →  delete surrounding  e.g. zx + "
--   zc + old + new      →  change surrounding  e.g. zc + " + '
--   Z  (visual)         →  surround selection
--
-- As of nvim-surround v4, the `keymaps` setup option was removed. The plugin
-- now sets its default ys/cs/ds keymaps at load time and exposes <Plug>
-- mappings for custom bindings. We disable the defaults via the global flag
-- (must be set before the plugin's plugin/ file is sourced, hence `init`) and
-- bind our 'z'-prefix keys to the <Plug> mappings in `config`.
-- See `:h nvim-surround.migrating.v3_to_v4` and `:h nvim-surround.keymaps`.
return {
  {
    "kylechui/nvim-surround",
    version = "*",
    event   = "VeryLazy",
    init    = function()
      vim.g.nvim_surround_no_mappings = true
    end,
    config  = function()
      require("nvim-surround").setup()

      local map = function(mode, lhs, plug, desc)
        vim.keymap.set(mode, lhs, plug, { remap = true, silent = true, desc = desc })
      end

      -- physical 'z' prefix (unremapped in Colemak)
      map("n", "za",      "<Plug>(nvim-surround-normal)",          "Surround: add around motion")
      map("n", "zaa",     "<Plug>(nvim-surround-normal-cur)",      "Surround: add around current line")
      map("n", "zA",      "<Plug>(nvim-surround-normal-line)",     "Surround: add around motion (new lines)")
      map("n", "zAA",     "<Plug>(nvim-surround-normal-cur-line)", "Surround: add around current line (new lines)")
      map("x", "Z",       "<Plug>(nvim-surround-visual)",          "Surround: add around selection")
      map("x", "gZ",      "<Plug>(nvim-surround-visual-line)",     "Surround: add around selection (new lines)")
      map("n", "zx",      "<Plug>(nvim-surround-delete)",          "Surround: delete")
      map("n", "zc",      "<Plug>(nvim-surround-change)",          "Surround: change")
      map("n", "zC",      "<Plug>(nvim-surround-change-line)",     "Surround: change (new lines)")
      map("i", "<C-g>z",  "<Plug>(nvim-surround-insert)",          "Surround: insert")
      map("i", "<C-g>Z",  "<Plug>(nvim-surround-insert-line)",     "Surround: insert (new lines)")
    end,
  },
}
