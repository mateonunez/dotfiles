return {
  {
    -- The agent lanes pitwall tracks in tmux, from inside Neovim. The plugin ships in the pitwall repo
    -- (lua/pitwall); outside tmux there are no lanes, so it stays off.
    dir   = vim.fn.expand("~/source/mateonunez/repositories/ai/pitwall"),
    name  = "pitwall",
    cond  = function()
      return vim.env.TMUX ~= nil and vim.fn.isdirectory(vim.fn.expand("~/source/mateonunez/repositories/ai/pitwall")) == 1
    end,
    event = "VeryLazy", -- loaded early, so the statusline count refreshes in the background
    keys  = {
      { "<leader>pp", "<cmd>Pitwall<cr>",   desc = "pitwall: lanes (⏎ go · ^f open its folder · 1 2 3 answer)" },
      { "<leader>pc", "<cmd>PitwallCd<cr>", desc = "pitwall: cd this tab to a lane's folder" },
    },
    config = function() require("pitwall").setup() end,
  },
}
