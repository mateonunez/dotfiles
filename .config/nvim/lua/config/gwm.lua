local M = {}

local state = {
  buffer = nil,
  window = nil,
}

local function close_terminal()
  if state.window and vim.api.nvim_win_is_valid(state.window) then
    vim.api.nvim_win_close(state.window, true)
  end

  if state.buffer and vim.api.nvim_buf_is_valid(state.buffer) then
    vim.api.nvim_buf_delete(state.buffer, { force = true })
  end

  state.buffer = nil
  state.window = nil
end

function M.open()
  if state.window and vim.api.nvim_win_is_valid(state.window) then
    vim.api.nvim_set_current_win(state.window)
    vim.cmd.startinsert()
    return
  end

  if vim.fn.executable("gwm-studiojin") ~= 1 then
    vim.notify("gwm-studiojin is not on PATH", vim.log.levels.ERROR)
    return
  end

  local width = math.max(80, math.floor(vim.o.columns * 0.92))
  local height = math.max(20, math.floor((vim.o.lines - vim.o.cmdheight) * 0.90))
  width = math.min(width, vim.o.columns - 2)
  height = math.min(height, vim.o.lines - vim.o.cmdheight - 2)

  local buffer = vim.api.nvim_create_buf(false, true)
  local window = vim.api.nvim_open_win(buffer, true, {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2) - 1,
    col = math.floor((vim.o.columns - width) / 2),
    style = "minimal",
    border = "rounded",
    title = " gwm · StudioJin ",
    title_pos = "center",
  })

  state.buffer = buffer
  state.window = window

  vim.bo[buffer].bufhidden = "wipe"
  vim.bo[buffer].filetype = "gwm"

  local job = vim.fn.termopen({ "gwm-studiojin" }, {
    on_exit = function(_, exit_code)
      vim.schedule(function()
        close_terminal()
        if exit_code ~= 0 then
          vim.notify(("gwm-studiojin exited with code %d"):format(exit_code), vim.log.levels.ERROR)
        end
      end)
    end,
  })

  if job <= 0 then
    close_terminal()
    vim.notify("Failed to start gwm-studiojin", vim.log.levels.ERROR)
    return
  end

  vim.cmd.startinsert()
end

vim.api.nvim_create_user_command("GwmStudiojin", M.open, {
  desc = "Open the StudioJin worktree workspace",
})

vim.keymap.set("n", "<leader>gw", M.open, {
  desc = "Worktree workspace (gwm)",
})

return M
