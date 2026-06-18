return {
  "rebelot/kanagawa.nvim",
  lazy     = false,
  priority = 1000,
  opts = {
    compile  = false,
    undercurl = true,
    commentStyle = { italic = false },
    functionStyle = {},
    keywordStyle = { italic = false },
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = false,
    dimInactive = false,
    terminalColors = true,
    theme = "dragon",
    background = {
      dark  = "dragon",
      light = "lotus",
    },
  },
  config = function(_, opts)
    require("kanagawa").setup(opts)
    vim.cmd("colorscheme kanagawa")
  end,
}
