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

local function configured_workspaces()
  local lines = vim.fn.systemlist({ "gwm-workspace", "--list-workspaces" })
  if vim.v.shell_error ~= 0 then
    return {}
  end

  local workspaces = {}
  for _, line in ipairs(lines) do
    local name, root = line:match("^([^\t]+)\t(.+)$")
    if name and root then
      table.insert(workspaces, { name = name, root = root })
    end
  end

  return workspaces
end

local function workspace_names()
  return vim.tbl_map(function(workspace)
    return workspace.name
  end, configured_workspaces())
end

local function open_terminal(workspace)
  if state.window and vim.api.nvim_win_is_valid(state.window) then
    vim.api.nvim_set_current_win(state.window)
    vim.cmd.startinsert()
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
    title = (" gwm · %s "):format(workspace),
    title_pos = "center",
  })

  state.buffer = buffer
  state.window = window

  vim.bo[buffer].bufhidden = "wipe"
  vim.bo[buffer].filetype = "gwm"

  local job = vim.fn.termopen({ "gwm-workspace", workspace }, {
    on_exit = function(_, exit_code)
      vim.schedule(function()
        close_terminal()
        if exit_code ~= 0 then
          vim.notify(("gwm-workspace exited with code %d"):format(exit_code), vim.log.levels.ERROR)
        end
      end)
    end,
  })

  if job <= 0 then
    close_terminal()
    vim.notify("Failed to start gwm-workspace", vim.log.levels.ERROR)
    return
  end

  vim.cmd.startinsert()
end

function M.open(workspace)
  if vim.fn.executable("gwm-workspace") ~= 1 then
    vim.notify("gwm-workspace is not on PATH", vim.log.levels.ERROR)
    return
  end

  if workspace and workspace ~= "" then
    open_terminal(workspace)
    return
  end

  local workspaces = configured_workspaces()
  if #workspaces == 0 then
    vim.notify("No GWM workspaces are configured", vim.log.levels.ERROR)
    return
  end

  vim.ui.select(workspaces, {
    prompt = "GWM workspace",
    format_item = function(item)
      return ("%s  %s"):format(item.name, item.root)
    end,
  }, function(choice)
    if choice then
      open_terminal(choice.name)
    end
  end)
end

vim.api.nvim_create_user_command("GwmWorkspace", function(options)
  M.open(options.args)
end, {
  nargs = "?",
  complete = workspace_names,
  desc = "Choose and open a Git worktree workspace",
})

vim.api.nvim_create_user_command("GwmStudiojin", function()
  M.open("studiojin")
end, {
  desc = "Open the StudioJin worktree workspace (compatibility alias)",
})

vim.keymap.set("n", "<leader>gw", M.open, {
  desc = "Choose worktree workspace (gwm)",
})

return M
