local RATIO = 0.35

-- Toggle the Claude pane between a right vertical split and a bottom split,
-- re-applying the RATIO each way. Stateless: a side split is narrower than the
-- full editor width, a bottom/top split spans it. Run while focused on Claude
-- in normal mode — press <C-g> first if you're typing in the terminal.
local function toggle_claude_position()
  if vim.api.nvim_win_get_width(0) < vim.o.columns then
    vim.cmd("wincmd J") -- side split -> bottom (full width)
    vim.cmd("resize " .. math.floor(vim.o.lines * RATIO))
  else
    vim.cmd("wincmd L") -- bottom split -> far right (full height)
    vim.cmd("vertical resize " .. math.floor(vim.o.columns * RATIO))
  end
end

return {
  {
    "greggh/claude-code.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "ClaudeCode", "ClaudeCodeContinue", "ClaudeCodeResume", "ClaudeCodeVerbose" },
    keys = {
      -- <leader>a = "ai / claude". 'a' is not remapped in Colemak, and the
      -- continuation letters compose literally after the leader.
      { "<leader>ac", "<cmd>ClaudeCode<cr>",         desc = "Claude: toggle" },
      { "<leader>ar", "<cmd>ClaudeCodeResume<cr>",   desc = "Claude: resume (picker)" },
      { "<leader>aC", "<cmd>ClaudeCodeContinue<cr>", desc = "Claude: continue last" },
      -- Move the pane: flip right vertical split <-> bottom split. Run while
      -- focused on Claude in normal mode (<C-g> out of the terminal first).
      { "<leader>am", toggle_claude_position, desc = "Claude: move pane (right <-> bottom)" },
      -- One-press toggle that also fires from INSIDE the terminal. <cmd> runs
      -- without leaving terminal mode, so Claude's TUI input is undisturbed.
      { "<C-l>", "<cmd>ClaudeCode<cr>", mode = { "n", "t" }, desc = "Claude: toggle (works in terminal)" },
    },
    opts = {
      -- Every binding is driven from the `keys` table above, so disable all of
      -- the plugin's built-in keymaps — especially window_navigation, which
      -- would map <C-h/j/k/l> and clobber the Colemak layout.
      keymaps = {
        toggle            = { normal = false, terminal = false },
        window_navigation = false,
        scrolling         = true,
      },
      window = {
        -- Right-side vertical pane. greggh runs `position` verbatim as the split
        -- command when it contains "split", so "botright vsplit" = far-right
        -- vertical window. For a bottom pane instead, use "botright" (horizontal).
        position        = "botright vsplit",
        split_ratio     = 0.35, -- WIDTH fraction for a vertical split (height if horizontal)
        enter_insert    = true,
        hide_numbers    = true,
        hide_signcolumn = true,
      },
      -- Launch Claude at the git repo root, not the buffer's cwd.
      git = {
        use_git_root = true,
      },
    },
    config = function(_, opts)
      require("claude-code").setup(opts)
    end,
  },
}
