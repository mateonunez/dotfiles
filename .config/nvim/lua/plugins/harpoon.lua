return {
  {
    "ThePrimeagen/harpoon",
    branch       = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()

      local map = function(keys, fn, desc)
        vim.keymap.set("n", keys, fn, { desc = desc })
      end

      -- <leader>m: 'm' is not remapped in Colemak
      map("<leader>m",  function() harpoon:list():add() end,                          "Harpoon: add file")
      map("<leader>M",  function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,  "Harpoon: menu")

      -- Slot jumps: number keys after leader are safe (numbers are not remapped)
      map("<leader>1",  function() harpoon:list():select(1) end,  "Harpoon: file 1")
      map("<leader>2",  function() harpoon:list():select(2) end,  "Harpoon: file 2")
      map("<leader>3",  function() harpoon:list():select(3) end,  "Harpoon: file 3")
      map("<leader>4",  function() harpoon:list():select(4) end,  "Harpoon: file 4")

      -- Cycle through list: [ ] sequences are not remapped
      map("]m",  function() harpoon:list():next() end,  "Harpoon: next file")
      map("[m",  function() harpoon:list():prev() end,  "Harpoon: prev file")
    end,
  },
}
