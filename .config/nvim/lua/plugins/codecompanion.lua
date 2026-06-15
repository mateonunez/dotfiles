return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cmd  = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
    keys = {
      -- <leader>cc: both 'c' chars are safe in Colemak
      { "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Toggle AI chat" },
      { "<leader>cC", "<cmd>CodeCompanionActions<cr>",    mode = { "n", "v" }, desc = "AI actions" },
    },
    opts = {
      adapters = {
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = { api_key = "ANTHROPIC_API_KEY" },
          })
        end,
      },
      strategies = {
        chat   = { adapter = "anthropic" },
        inline = { adapter = "anthropic" },
        agent  = { adapter = "anthropic" },
      },
      display = {
        chat = {
          window = {
            layout = "vertical",
            width  = 0.35,
          },
        },
      },
    },
  },
}
