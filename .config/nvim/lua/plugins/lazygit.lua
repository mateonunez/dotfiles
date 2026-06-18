return {
  {
    "kdheepak/lazygit.nvim",
    -- Opens the lazygit TUI in a float. Being an external terminal app, it gets
    -- raw keys — the Colemak noremap never touches it, so no keymap conflicts.
    -- Requires the `lazygit` binary on PATH (`brew install lazygit`).
    cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit (git client)" },
    },
  },
}
