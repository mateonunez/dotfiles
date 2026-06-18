return {
  {
    "coder/claudecode.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    -- Lazy-load on the commands and the <leader>a* keys below.
    cmd = {
      "ClaudeCode",
      "ClaudeCodeFocus",
      "ClaudeCodeSelectModel",
      "ClaudeCodeAdd",
      "ClaudeCodeSend",
      "ClaudeCodeTreeAdd",
      "ClaudeCodeDiffAccept",
      "ClaudeCodeDiffDeny",
    },
    keys = {
      -- <leader>a = "ai / claude". 'a' is not remapped in Colemak; the
      -- continuation keys (c/f/r/C/m/b/s/a/d) compose literally after the leader.
      { "<leader>ac", "<cmd>ClaudeCode<cr>",            desc = "Claude: toggle" },
      -- One-press toggle that also fires from INSIDE the terminal (<cmd> runs
      -- without leaving terminal mode, so Claude's TUI input is undisturbed).
      { "<C-l>", "<cmd>ClaudeCode<cr>", mode = { "n", "t" }, desc = "Claude: toggle (works in terminal)" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",       desc = "Claude: focus" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",   desc = "Claude: resume session" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Claude: continue last" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Claude: select model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",        desc = "Claude: add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Claude: send selection" },
      -- File-tree integration: add the file/folder under cursor in neo-tree.
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Claude: add file (tree)",
        ft = { "neo-tree", "neo-tree-popup" },
      },
      -- Diff review: accept / reject Claude's proposed changes in-editor.
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Claude: accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Claude: reject diff" },
    },
    opts = {
      -- Use Neovim's built-in terminal so we don't pull in snacks.nvim.
      terminal = {
        provider = "native",
        split_side = "right",
        split_width_percentage = 0.35,
      },
      -- Show Claude's edits as a normal vertical diff to accept/reject.
      diff_opts = {
        layout = "vertical",
      },
    },
  },
}
