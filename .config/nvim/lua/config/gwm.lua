local M = {}

local launch_directory = vim.fn.getcwd()
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
  local lines = vim.fn.systemlist({ "gwm-workspace", "list", "--format", "tsv" })
  if vim.v.shell_error ~= 0 then
    return {}
  end

  local workspaces = {}
  for _, line in ipairs(lines) do
    local name, count, directory = line:match("^([^\t]+)\t([^\t]+)\t(.+)$")
    if name and directory then
      table.insert(workspaces, {
        kind = "workspace",
        name = name,
        count = tonumber(count),
        directory = directory,
      })
    end
  end
  return workspaces
end

local function native_folder()
  vim.fn.system({ "git", "-C", launch_directory, "rev-parse", "--show-toplevel" })
  if vim.v.shell_error ~= 0 then
    return nil
  end
  return {
    kind = "folder",
    name = vim.fs.basename(launch_directory),
    path = launch_directory,
  }
end

local function display_path(path)
  return path:gsub("^" .. vim.pesc(vim.env.HOME), "~")
end

local function workspace_names()
  return vim.tbl_map(function(workspace)
    return workspace.name
  end, configured_workspaces())
end

local function select_workspace(workspace, prompt, callback)
  if workspace and workspace ~= "" then
    callback({ kind = "workspace", name = workspace })
    return
  end

  local workspaces = configured_workspaces()
  if #workspaces == 0 then
    vim.notify("No GWM workspaces are configured", vim.log.levels.ERROR)
    return
  end
  vim.ui.select(workspaces, {
    prompt = prompt,
    format_item = function(item)
      return ("%s  ·  %d repos"):format(item.name, item.count)
    end,
  }, function(choice)
    if choice then
      callback(choice)
    end
  end)
end

local function run(args, success_message)
  vim.system(args, { text = true }, function(result)
    vim.schedule(function()
      if result.code == 0 then
        vim.notify(success_message or vim.trim(result.stdout), vim.log.levels.INFO)
      else
        vim.notify(vim.trim(result.stderr), vim.log.levels.ERROR)
      end
    end)
  end)
end

local function open_terminal(target)
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
    title = (" gwm · %s "):format(target.name),
    title_pos = "center",
  })

  state.buffer = buffer
  state.window = window
  vim.bo[buffer].bufhidden = "wipe"
  vim.bo[buffer].filetype = "gwm"

  local command = target.kind == "folder" and { "gwm" } or { "gwm-workspace", "open", target.name }
  local job = vim.fn.termopen(command, {
    cwd = target.kind == "folder" and target.path or nil,
    on_exit = function(_, exit_code)
      vim.schedule(function()
        close_terminal()
        if exit_code ~= 0 then
          vim.notify(("GWM exited with code %d"):format(exit_code), vim.log.levels.ERROR)
        end
      end)
    end,
  })

  if job <= 0 then
    close_terminal()
    vim.notify("Failed to start GWM", vim.log.levels.ERROR)
    return
  end
  vim.cmd.startinsert()
end

function M.open(workspace)
  if vim.fn.executable("gwm") ~= 1 or vim.fn.executable("gwm-workspace") ~= 1 then
    vim.notify("gwm or gwm-workspace is not on PATH", vim.log.levels.ERROR)
    return
  end
  if workspace and workspace ~= "" then
    open_terminal({ kind = "workspace", name = workspace })
    return
  end

  local targets = configured_workspaces()
  local folder = native_folder()
  if folder then
    table.insert(targets, 1, folder)
  end
  if #targets == 0 then
    vim.notify("The launch directory is not a Git repository and no GWM workspaces exist", vim.log.levels.ERROR)
    return
  end

  vim.ui.select(targets, {
    prompt = "Open GWM folder or workspace",
    format_item = function(item)
      if item.kind == "folder" then
        return ("[folder]    %s  ·  %s"):format(item.name, display_path(item.path))
      end
      return ("[workspace] %s  ·  %d repos"):format(item.name, item.count)
    end,
  }, function(choice)
    if choice then
      open_terminal(choice)
    end
  end)
end

function M.open_folder(path)
  path = path and path ~= "" and path or launch_directory
  open_terminal({ kind = "folder", name = vim.fs.basename(path), path = path })
end

function M.add(workspace)
  select_workspace(workspace, "Add launch repository to workspace", function(choice)
    run(
      { "gwm-workspace", "add", choice.name, launch_directory },
      ("Added launch repository to %s"):format(choice.name)
    )
  end)
end

function M.remove(workspace)
  select_workspace(workspace, "Remove repository from workspace", function(choice)
    local lines = vim.fn.systemlist({ "gwm-workspace", "repos", choice.name })
    if vim.v.shell_error ~= 0 then
      vim.notify(table.concat(lines, "\n"), vim.log.levels.ERROR)
      return
    end
    local repositories = {}
    for _, line in ipairs(lines) do
      local name, path = line:match("^([^\t]+)\t(.+)$")
      if name and path then
        table.insert(repositories, { name = name, path = path })
      end
    end
    vim.ui.select(repositories, {
      prompt = ("Remove from %s"):format(choice.name),
      format_item = function(item)
        return ("%s  ·  %s"):format(item.name, display_path(item.path))
      end,
    }, function(repository)
      if repository then
        run(
          { "gwm-workspace", "remove", choice.name, repository.name },
          ("Removed %s from %s"):format(repository.name, choice.name)
        )
      end
    end)
  end)
end

vim.api.nvim_create_user_command("GwmWorkspace", function(options)
  M.open(options.args)
end, {
  nargs = "?",
  complete = workspace_names,
  desc = "Open native GWM or a symlink workspace",
})

vim.api.nvim_create_user_command("GwmFolder", function(options)
  M.open_folder(options.args)
end, {
  nargs = "?",
  complete = "dir",
  desc = "Open native GWM from the launch directory or a given folder",
})

vim.api.nvim_create_user_command("GwmWorkspaceAdd", function(options)
  M.add(options.args)
end, {
  nargs = "?",
  complete = workspace_names,
  desc = "Add the launch repository to a symlink workspace",
})

vim.api.nvim_create_user_command("GwmWorkspaceRemove", function(options)
  M.remove(options.args)
end, {
  nargs = "?",
  complete = workspace_names,
  desc = "Remove a repository from a symlink workspace",
})

vim.keymap.set("n", "<leader>gw", M.open, {
  desc = "Open native GWM or a symlink workspace",
})

return M
