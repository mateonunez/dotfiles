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
  local lines = vim.fn.systemlist({ "gwm-workspace", "list", "--format", "tsv" })
  if vim.v.shell_error ~= 0 then
    return {}
  end

  local workspaces = {}
  for _, line in ipairs(lines) do
    local name, count, manifest, directory = line:match("^([^\t]+)\t([^\t]+)\t([^\t]+)\t(.+)$")
    if name and directory then
      table.insert(workspaces, {
        kind = "workspace",
        name = name,
        count = tonumber(count),
        manifest = manifest,
        directory = directory,
      })
    end
  end

  return workspaces
end

local function configured_folders()
  local lines = vim.fn.systemlist({ "gwm-workspace", "folders" })
  if vim.v.shell_error ~= 0 then
    return {}
  end

  local folders = {}
  for _, line in ipairs(lines) do
    local name, path = line:match("^([^\t]+)\t(.+)$")
    if name and path then
      table.insert(folders, { kind = "folder", name = name, path = path })
    end
  end

  return folders
end

local function display_path(path)
  return path:gsub("^" .. vim.pesc(vim.env.HOME), "~")
end

local function select_workspace(workspace, prompt, callback)
  if workspace and workspace ~= "" then
    callback({ name = workspace })
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

local function workspace_names()
  return vim.tbl_map(function(workspace)
    return workspace.name
  end, configured_workspaces())
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

  local command = target.kind == "folder" and { "gwm-workspace", "open-folder", target.path }
    or { "gwm-workspace", "open", target.name }
  local job = vim.fn.termopen(command, {
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
    open_terminal({ kind = "workspace", name = workspace })
    return
  end

  local targets = configured_workspaces()
  vim.list_extend(targets, configured_folders())
  if #targets == 0 then
    vim.notify("No GWM folders or workspaces are configured", vim.log.levels.ERROR)
    return
  end

  vim.ui.select(targets, {
    prompt = "Open GWM folder or workspace",
    format_item = function(item)
      if item.kind == "workspace" then
        return ("[workspace] %s  ·  %d repos"):format(item.name, item.count)
      end
      return ("[folder]    %s  ·  %s"):format(item.name, display_path(item.path))
    end,
  }, function(choice)
    if choice then
      open_terminal(choice)
    end
  end)
end

function M.open_folder(path)
  if vim.fn.executable("gwm-workspace") ~= 1 then
    vim.notify("gwm-workspace is not on PATH", vim.log.levels.ERROR)
    return
  end

  if path and path ~= "" then
    open_terminal({ kind = "folder", name = vim.fs.basename(path), path = path })
    return
  end

  local folders = configured_folders()
  if #folders == 0 then
    vim.notify("No GWM folders are configured", vim.log.levels.ERROR)
    return
  end
  vim.ui.select(folders, {
    prompt = "Open GWM folder",
    format_item = function(item)
      return ("%s  ·  %s"):format(item.name, display_path(item.path))
    end,
  }, function(choice)
    if choice then
      open_terminal(choice)
    end
  end)
end

function M.add(workspace)
  local buffer_path = vim.api.nvim_buf_get_name(0)
  local repository = buffer_path ~= "" and vim.fs.dirname(buffer_path) or vim.fn.getcwd()
  select_workspace(workspace, "Add current repository to workspace", function(choice)
    run({ "gwm-workspace", "add", choice.name, repository }, ("Added repository to %s"):format(choice.name))
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
        return ("%s  %s"):format(item.name, item.path)
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

function M.sync(workspace)
  select_workspace(workspace, "Sync GWM workspace", function(choice)
    run({ "gwm-workspace", "sync", choice.name })
  end)
end

function M.edit(workspace)
  select_workspace(workspace, "Edit GWM workspace", function(choice)
    local manifest = choice.manifest
    if not manifest then
      local rows = configured_workspaces()
      for _, candidate in ipairs(rows) do
        if candidate.name == choice.name or candidate.name:match("/([^/]+)$") == choice.name then
          manifest = candidate.manifest
          break
        end
      end
    end
    if manifest then
      vim.cmd.edit(vim.fn.fnameescape(manifest))
    else
      vim.notify(("Cannot resolve manifest for %s"):format(choice.name), vim.log.levels.ERROR)
    end
  end)
end

vim.api.nvim_create_user_command("GwmWorkspace", function(options)
  M.open(options.args)
end, {
  nargs = "?",
  complete = workspace_names,
  desc = "Choose and open a Git folder or worktree workspace",
})

vim.api.nvim_create_user_command("GwmFolder", function(options)
  M.open_folder(options.args)
end, {
  nargs = "?",
  complete = "dir",
  desc = "Choose and open a Git folder with GWM",
})

vim.api.nvim_create_user_command("GwmWorkspaceAdd", function(options)
  M.add(options.args)
end, {
  nargs = "?",
  complete = workspace_names,
  desc = "Add the current repository to a Git worktree workspace",
})

vim.api.nvim_create_user_command("GwmWorkspaceRemove", function(options)
  M.remove(options.args)
end, {
  nargs = "?",
  complete = workspace_names,
  desc = "Remove a repository from a Git worktree workspace",
})

vim.api.nvim_create_user_command("GwmWorkspaceSync", function(options)
  M.sync(options.args)
end, {
  nargs = "?",
  complete = workspace_names,
  desc = "Synchronize a Git worktree workspace",
})

vim.api.nvim_create_user_command("GwmWorkspaceEdit", function(options)
  M.edit(options.args)
end, {
  nargs = "?",
  complete = workspace_names,
  desc = "Edit a Git worktree workspace manifest",
})

vim.keymap.set("n", "<leader>gw", M.open, {
  desc = "Choose Git folder or workspace (gwm)",
})

return M
