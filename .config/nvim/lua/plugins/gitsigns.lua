return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "" },
        topdelete    = { text = "" },
        changedelete = { text = "▎" },
        untracked    = { text = "▎" },
      },
      -- Inline virtual-text blame on the current line (GitLens-style).
      current_line_blame = true,
      current_line_blame_opts = { delay = 400, virt_text_pos = "eol" },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(mode, keys, fn, desc)
          vim.keymap.set(mode, keys, fn, { buffer = bufnr, desc = desc })
        end

        -- Hunk navigation: ] / [ with 'h' (h is not remapped in Colemak)
        map("n", "]h", function()
          if vim.wo.diff then return "]h" end
          vim.schedule(gs.next_hunk)
          return "<ignore>"
        end, "Next hunk")

        map("n", "[h", function()
          if vim.wo.diff then return "[h" end
          vim.schedule(gs.prev_hunk)
          return "<ignore>"
        end, "Prev hunk")

        -- Actions — <leader>h prefix (h not remapped)
        map("n", "<leader>ha", gs.stage_hunk,        "Stage hunk")
        map("n", "<leader>hx", gs.reset_hunk,        "Reset hunk")
        map("n", "<leader>hA", gs.stage_buffer,      "Stage buffer")
        map("n", "<leader>hX", gs.reset_buffer,      "Reset buffer")
        map("n", "<leader>hv", gs.preview_hunk,      "Preview hunk")
        map("n", "<leader>hb", gs.blame_line,        "Blame line (full)")
        map("n", "<leader>hB", gs.toggle_current_line_blame, "Toggle inline blame")
        map("n", "<leader>hq", gs.setqflist,         "Hunks to quickfix")
        map({ "n", "v" }, "<leader>ha", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Stage selected hunk")
      end,
    },
  },
}
