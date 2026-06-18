return {
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    event = "VeryLazy",
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()
      local set = vim.keymap.set

      -- Add a cursor on the next/skip occurrence of the word/selection
      -- (VS Code's Ctrl-D). These are Ctrl combos + arrows — layout-independent,
      -- so no Colemak remapping needed.
      set({ "n", "x" }, "<C-n>",    function() mc.matchAddCursor(1) end,  { desc = "Multicursor: add next match" })
      set({ "n", "x" }, "<C-x>",    function() mc.matchSkipCursor(1) end, { desc = "Multicursor: skip match" })
      set({ "n", "x" }, "<C-Up>",   function() mc.lineAddCursor(-1) end,  { desc = "Multicursor: add cursor up" })
      set({ "n", "x" }, "<C-Down>", function() mc.lineAddCursor(1) end,   { desc = "Multicursor: add cursor down" })

      -- Active-cursors layer: arrows cycle cursors, <Esc> disables then clears.
      mc.addKeymapLayer(function(layer)
        layer({ "n", "x" }, "<left>",  mc.prevCursor)
        layer({ "n", "x" }, "<right>", mc.nextCursor)
        layer("n", "<esc>", function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          else
            mc.clearCursors()
          end
        end)
      end)
    end,
  },
}
