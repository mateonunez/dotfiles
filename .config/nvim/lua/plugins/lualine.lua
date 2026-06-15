-- Colors from tmux theme (tmux.conf.local)
local colors = {
  bg      = "#0a0a0a",
  surface = "#1c1c1c",
  muted   = "#6b7280",
  blue    = "#3080ff",
  amber   = "#f59e0b",
  red     = "#fb2c36",
  green   = "#00c758",
  text    = "#e5e7eb",
}

local theme = {
  normal = {
    a = { fg = colors.bg,     bg = colors.amber,  gui = "bold" },
    b = { fg = colors.text,   bg = colors.surface },
    c = { fg = colors.muted,  bg = colors.bg },
  },
  insert = {
    a = { fg = colors.bg,     bg = colors.blue,   gui = "bold" },
    b = { fg = colors.text,   bg = colors.surface },
    c = { fg = colors.muted,  bg = colors.bg },
  },
  visual = {
    a = { fg = colors.bg,     bg = colors.red,    gui = "bold" },
    b = { fg = colors.text,   bg = colors.surface },
    c = { fg = colors.muted,  bg = colors.bg },
  },
  replace = {
    a = { fg = colors.bg,     bg = colors.red,    gui = "bold" },
    b = { fg = colors.text,   bg = colors.surface },
    c = { fg = colors.muted,  bg = colors.bg },
  },
  command = {
    a = { fg = colors.bg,     bg = colors.green,  gui = "bold" },
    b = { fg = colors.text,   bg = colors.surface },
    c = { fg = colors.muted,  bg = colors.bg },
  },
  inactive = {
    a = { fg = colors.muted,  bg = colors.bg },
    b = { fg = colors.muted,  bg = colors.bg },
    c = { fg = colors.muted,  bg = colors.bg },
  },
}

return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        theme                = theme,
        globalstatus         = true,
        section_separators   = { left = "", right = "" },
        component_separators = { left = "│", right = "│" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = {
          { "filename", path = 1 },
        },
        lualine_x = {
          {
            "diagnostics",
            symbols = { error = " ", warn = " ", info = " ", hint = " " },
          },
        },
        lualine_y = { "filetype" },
        lualine_z = { "location", "progress" },
      },
      inactive_sections = {
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "location" },
      },
    },
  },
}
