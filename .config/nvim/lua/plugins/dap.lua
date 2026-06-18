return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
      "theHamsta/nvim-dap-virtual-text",
      "jay-babu/mason-nvim-dap.nvim",
    },
    keys = {
      -- VSCode-standard F-keys for the hot path (layout-independent — no Colemak
      -- concern, F-keys aren't remapped). Mirrors your VSCode debug muscle memory.
      { "<F5>",  function() require("dap").continue() end,          desc = "Debug: start / continue" },
      { "<F9>",  function() require("dap").toggle_breakpoint() end, desc = "Debug: toggle breakpoint" },
      { "<F10>", function() require("dap").step_over() end,         desc = "Debug: step over" },
      { "<F11>", function() require("dap").step_into() end,         desc = "Debug: step into" },
      { "<F12>", function() require("dap").step_out() end,          desc = "Debug: step out" },
      -- <leader>v = debug group ('v' is a free, Colemak-safe leader key; physical
      -- key == typed key, so the sub-keys below are pressed exactly as written).
      { "<leader>vv", function() require("dap").continue() end,          desc = "Debug: start / continue" },
      { "<leader>vb", function() require("dap").toggle_breakpoint() end, desc = "Debug: toggle breakpoint" },
      { "<leader>vB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Debug: conditional breakpoint" },
      { "<leader>vc", function() require("dap").continue() end,          desc = "Debug: continue" },
      { "<leader>vo", function() require("dap").step_over() end,         desc = "Debug: step over" },
      { "<leader>vi", function() require("dap").step_into() end,         desc = "Debug: step into" },
      { "<leader>vu", function() require("dap").step_out() end,          desc = "Debug: step out (up)" },
      { "<leader>vr", function() require("dap").repl.toggle() end,       desc = "Debug: toggle REPL" },
      { "<leader>vl", function() require("dap").run_last() end,          desc = "Debug: run last" },
      { "<leader>vt", function() require("dap").terminate() end,         desc = "Debug: terminate" },
      { "<leader>vd", function() require("dapui").toggle() end,          desc = "Debug: toggle UI" },
      { "<leader>ve", function() require("dapui").eval() end, mode = { "n", "v" }, desc = "Debug: eval expression" },
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")

      require("mason-nvim-dap").setup({
        -- adapters installed via Mason; matches your VSCode debugpy / cpptools / js debug
        ensure_installed = { "python", "js", "codelldb" },
        automatic_installation = true,
        handlers = {}, -- default handlers wire up each installed adapter automatically
      })

      dapui.setup({
        -- Colemak: dap-ui's default `e` (edit value) shadows up-nav (e→k).
        -- Move it to capital E so `e` keeps navigating in the UI windows.
        mappings = {
          expand = { "<CR>", "<2-LeftMouse>" },
          open   = "o",
          remove = "d",
          edit   = "E",
          repl   = "r",
          toggle = "t",
        },
      })
      require("nvim-dap-virtual-text").setup()

      -- Open/close the DAP UI automatically around a session.
      dap.listeners.before.attach.dapui_config           = function() dapui.open() end
      dap.listeners.before.launch.dapui_config           = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config     = function() dapui.close() end

      vim.fn.sign_define("DapBreakpoint",          { text = "●", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn" })
      vim.fn.sign_define("DapStopped",             { text = "▶", texthl = "DiagnosticInfo" })
    end,
  },
}
