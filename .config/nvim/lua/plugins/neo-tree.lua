return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>a", "<cmd>Neotree toggle<cr>", desc = "Toggle Neo-tree" },
    },
    opts = {
      close_if_last_window = true,
      window = {
        width = 35,
        mappings = {
          -- ── Colemak navigation ──────────────────────────────────────────
          -- "n" and "e" must NOT appear here: neo-tree buffer-local mappings
          -- win over the global noremap. Leaving them unbound lets the noremap do:
          --   physical n → j → cursor down
          --   physical e → k → cursor up
          -- "i" and "l" are explicitly handled below.

          -- physical 'i' → noremap i→l → this binding → open file/folder
          ["l"]     = "open",

          -- physical 'h' (not remapped) → collapse node
          ["h"]     = "close_node",

          ["<space>"]   = { "toggle_node", nowait = false },
          ["<cr>"]      = "open",
          ["q"]         = "close_window",
          ["<esc>"]     = "cancel",
          ["R"]         = "refresh",
          ["?"]         = "show_help",
          [">"]         = "next_source",
          ["<"]         = "prev_source",
          ["z"]         = "close_all_nodes",

          -- ── Safe action keys (none of these are in the Colemak remap table) ──
          ["a"]     = { "add", config = { show_path = "relative" } },
          ["A"]     = "add_directory",
          ["c"]     = "copy",
          ["m"]     = "move",
          ["x"]     = "cut_to_clipboard",
          ["<del>"] = "delete",

          -- ── Disable every default that collides with a Colemak remap ────
          -- physical 'e' → neo-tree default: "toggle_auto_expand_width" (THE RESIZE BUG)
          ["e"]     = "none",
          -- physical 'i' → neo-tree default: "show_file_details"
          ["i"]     = "none",
          -- physical 's' → noremap s→d → default: "delete"
          ["d"]     = "none",
          -- physical 'p' → noremap p→r → default: "rename"
          ["r"]     = "none",
          -- physical 'r' → noremap r→s → default: "open_vsplit"
          ["s"]     = "none",
          -- physical 'g' → noremap g→t → default: "open_tabnew"
          ["t"]     = "none",
          -- physical 'j' → noremap j→y → default: "copy_to_clipboard"
          ["y"]     = "none",
          -- physical 'o' → noremap o→p → default: "paste_from_clipboard"
          ["p"]     = "none",
          -- physical 'l' → noremap l→u → default: (nothing, but clear to be safe)
          ["u"]     = "none",
        },
      },
      filesystem = {
        window = {
          mappings = {
            -- physical 't' → noremap t→f → default: "filter_on_submit"
            ["f"]     = "none",
            ["/"]     = "fuzzy_finder",
            ["<bs>"]  = "navigate_up",
            ["."]     = "set_root",
            ["H"]     = "toggle_hidden",
            ["[g"]    = "prev_git_modified",
            ["]g"]    = "next_git_modified",
            -- physical 'i' → default: "show_file_details" (filesystem-level)
            ["i"]     = "none",
          },
        },
        filtered_items = {
          visible        = true,
          hide_dotfiles  = false,
          hide_gitignored = true,
        },
        follow_current_file    = { enabled = true },
        use_libuv_file_watcher = true,
      },
    },
  },
}
