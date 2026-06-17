-- codediff.nvim — VSCode-style diff view with two-tier highlighting.
-- All keymaps inside the diff window are buffer-local, so physical keys work
-- correctly under Colemak (buffer-local maps beat global noremap).
--
-- Changes from defaults:
--   next_hunk/prev_hunk : ]v/[v  — ]c/[c reserved for treesitter next/prev class
--   conflict keymaps    : <leader>d* — <leader>c is the code/LSP group
--   focus_explorer      : <leader>de — <leader>e is ambiguous with Colemak e→k
return {
  {
    "esmuellert/codediff.nvim",
    cmd  = "CodeDiff",
    keys = {
      { "<leader>dg", "<cmd>CodeDiff<cr>",           desc = "Git diff explorer" },
      { "<leader>df", "<cmd>CodeDiff file HEAD<cr>", desc = "Diff file vs HEAD" },
      { "<leader>dh", "<cmd>CodeDiff history<cr>",   desc = "File history" },
    },
    opts = {
      diff = {
        layout = "side-by-side",
      },
      explorer = {
        auto_open_on_cursor = false, -- keep false: rebinding j/k collides with Colemak n/e
        icons = {
          -- ASCII fallbacks — avoids ? boxes if a Nerd Font is not installed
          folder_closed = "+",
          folder_open   = "-",
        },
      },
      keymaps = {
        view = {
          quit                         = "q",
          toggle_explorer              = "<leader>b",
          focus_explorer               = "<leader>de",
          -- ]v/[v instead of default ]c/[c (treesitter uses ]c/[c for class nav)
          next_hunk                    = "]v",
          prev_hunk                    = "[v",
          next_file                    = "]f",
          prev_file                    = "[f",
          -- buffer-local: physical d/g/t work unremapped inside diff window
          diff_get                     = "do",
          diff_put                     = "dp",
          open_in_prev_tab             = "gf",
          toggle_stage                 = "-",
          -- <leader>h* consistent with gitsigns hunk group (ha/hx taken, hs/hu/hr free)
          stage_hunk                   = "<leader>hs",
          unstage_hunk                 = "<leader>hu",
          discard_hunk                 = "<leader>hr",
          hunk_textobject              = "ih",   -- buffer-local op-pending
          show_help                    = "g?",
          align_move                   = "gm",
          toggle_layout                = "t",    -- buffer-local: physical t fires (not f)
          toggle_compact               = "gc",
        },
        explorer = {
          select           = "<CR>",
          hover            = "K",          -- buffer-local: physical K fires (not N)
          refresh          = "R",          -- buffer-local: physical R fires (not S)
          toggle_view_mode = "i",          -- buffer-local: physical i fires (not l)
          stage_all        = "S",
          unstage_all      = "U",
          restore          = "X",
          toggle_changes   = "gu",
          toggle_staged    = "gs",
        },
        -- Conflict keymaps moved off <leader>c (our code/LSP group) → <leader>d
        -- ]x/[x are buffer-local in the conflict diff view; LSP ]x/[x live in LSP bufs
        conflict = {
          accept_incoming     = "<leader>di",  -- incoming = i
          accept_current      = "<leader>dc",  -- current  = c
          accept_both         = "<leader>db",  -- both     = b
          discard             = "<leader>dx",  -- discard  = x
          accept_all_incoming = "<leader>dI",
          accept_all_current  = "<leader>dC",
          accept_all_both     = "<leader>dB",
          discard_all         = "<leader>dX",
          next_conflict       = "]x",
          prev_conflict       = "[x",
          diffget_incoming    = "2do",
          diffget_current     = "3do",
        },
      },
    },
  },
}
