# 📁 dotfiles

<img width="1512" alt="image" src="https://github.com/mateonunez/dotfiles/assets/11861080/86512709-8141-464a-874e-c138849c11c6">

## ✨ What is this?

This is my personal dotfiles repository. It contains all the configuration files for my system.

I'm using the [Colemak](https://colemak.com/) layout, so I have to change some keybindings in some programs like `tmux`, `vim`, `vscode`, etc.

## 💡 The navigation

Everything is based on _vim navigation_. Usually, you can navigate through the files with `hjkl` keys, but I've changed it for `hnei` keys. This because the Colemak layout has the `h` key in the same position, the `j` key is in the `n` position, the `k` key is in the `e` position and the `l` key is in the `i` position.

> **Note:** All the keys were mapped to the Colemak layout, this means that the `f` key (find char) is in the `t` position, the `d` key (delete char) is in the `s` position, etc.

Yep, it's a little bit confusing 🤯, but it's very useful when you're using the Colemak layout and/or you want easily switch to the `qwerty` layout.

## 📦 vim

The `vim` configuration is really basic. It contains just the basic Colemak keybindings and some general configurations.

### How to run it?

```bash
$ git clone https://github.com/mateonunez/dotfiles ~/.somewhere
$ ln -s ~/.somewhere/.vimrc ~/.vimrc
```

> Please backup your `~/.vimrc` file before running the previous command.

**Create the `swap` and `undo` directories**

```bash
$ mkdir ~/.vim/swap
$ mkdir ~/.vim/undo
```

## 📦 tmux

I really love [tmux](https://github.com/tmux/tmux), it's a great tool for managing your terminal sessions. I've created a basic configuration file for it, based on [oh-my-tmux](https://github.com/gpakosz/.tmux) and of course, with the Colemak keybindings (it uses the `vi navigation` to walk on the file).

> **Prefix key:** `Ctrl + a`

### Panel navigation

The panel navigation follows my default Colemak keybindings, so you can navigate through the panels with `hnei` keys.

- **Focus right panel:** `Ctrl + a + i`
- **Focus left panel:** `Ctrl + a + h`
- **Focus top panel:** `Ctrl + a + n`
- **Focus bottom panel:** `Ctrl + a + e`

### Panel resizing

Also, you can resize the panels with `HNEI` keys.

- **Resize to the right:** `Ctrl + a + Shift + i (or I)`
- **Resize to the left:** `Ctrl + a + Shift + h (or H)`
- **Resize to the top:** `Ctrl + a + Shift + n (or N)`
- **Resize to the bottom:** `Ctrl + a + Shift + e (or E)`

### Copy mode

The copy mode is based on the `vi navigation`, so you can navigate through the text with `hnei` keys.

**Requirements:**

- On Linux: `xclip` package and `reattach-to-user-namespace`.
- On macOS: `pbcopy` package.
- On Windows: Who knows.

> For Linux and macOS, you can install the `reattach-to-user-namespace` package with `brew install reattach-to-user-namespace` or `sudo apt install reattach-to-user-namespace` and switch to the right program in the configuration file.

To trigger the copy mode, you have to press `Ctrl + a + [`. Then, you can navigate through the text with `hnei` keys and select the text with `v` key. Once you've selected the text, you can copy it with:

- j (y in qwerty): copy to the clipboard.
- Ctrl + c: copy to the clipboard and exit the copy mode.

### How to run it?

```bash
$ git clone https://github.com/mateonunez/dotfiles ~/.somewhere
$ ln -s ~/.somewhere/.tmux.conf ~/.tmux.conf
$ ln -s ~/.somewhere/.tmux.conf.local ~/.tmux.conf.local
```

> Please backup your `~/.tmux.conf` and `~/.tmux.conf.local` files before running the previous commands.

## 📦 nvim

A full IDE built on [lazy.nvim](https://github.com/folke/lazy.nvim), with Colemak-aware keymaps and one file per plugin. It's tuned to mirror my VS Code toolchain:

- **LSP & completion** — 14 servers (TS, Lua, Rust, Python, Tailwind, ESLint, YAML, TOML, CSS/HTML, Docker, Bash, clangd…) via Mason, `blink.cmp`, inlay hints, breadcrumbs + symbols outline.
- **Diagnostics & quality** — `nvim-lint` (eslint_d/ruff/shellcheck), `conform` formatting (Biome + Prettier + Stylua, manual via `<leader>z`), readable TS errors.
- **Debugging** — `nvim-dap` + dap-ui with VS Code's `F5`/`F9`/`F10`/`F11` keys (Python, JS/TS, Rust/C).
- **Testing** — `neotest` (jest/vitest/python), debug-a-test via DAP.
- **Git** — `gitsigns` (hunks + inline blame), `codediff` (diff/history/conflicts), `octo` (GitHub PRs), `lazygit`.
- **AI** — [Claude Code](https://github.com/coder/claudecode.nvim) in-editor (`<leader>a`).
- **Refactoring & editing** — `refactoring.nvim`, multiple cursors, surround, autopairs, Treesitter textobjects.
- **Navigation** — Telescope, Harpoon, Neo-tree, Trouble, grug-far, which-key.

📖 **Full guide → [.config/nvim/README.md](.config/nvim/README.md)** — install, the Colemak key map, the complete keybinding cheatsheet, and per-plugin notes.

```bash
$ git clone https://github.com/mateonunez/dotfiles ~/.somewhere
$ ln -s ~/.somewhere/.config/nvim ~/.config/nvim
```

> Back up your existing `~/.config/nvim` first. On first launch lazy.nvim installs every plugin (and Mason pulls the LSP/DAP/linter tools — give it a minute). `lazygit` and the `gh` CLI should be on your `PATH` for the git integrations.

## 🌳 Git worktree workspace

[`gwm`](https://github.com/kbrdn1/gwm-cli) provides a multi-repository TUI over
curated workspaces and every linked worktree, including worktrees created by
external coding agents. Existing VS Code `.code-workspace` files are the source
of truth. The launcher materializes each manifest as a sibling directory of
relative repository symlinks—the flat layout GWM expects—without moving or
modifying source repositories.

The compact, stacked TUI uses the same black/surface/amber/blue/green/red
palette as tmux and Powerlevel10k. Its keymap mirrors the Colemak `hnei`
navigation used by Neovim, tmux, and lazygit.

Install and link the versioned configuration:

```bash
brew install kbrdn1/tap/gwm
mkdir -p ~/.config/gwm ~/.config/lazygit ~/.local/bin
ln -s ~/.dotfiles/.config/gwm/config.toml ~/.config/gwm/config.toml
ln -s ~/.dotfiles/.config/gwm/workspaces ~/.config/gwm/workspaces
ln -s ~/.dotfiles/.config/lazygit/config.yml ~/.config/lazygit/config.yml
ln -s ~/.dotfiles/scripts/gwm-codediff ~/.local/bin/gwm-codediff
ln -s ~/.dotfiles/scripts/gwm-workspace ~/.local/bin/gwm-workspace
```

List, synchronize, and open curated workspaces:

```bash
gwm-workspace list
gwm-workspace sync --all
gwm-workspace open studiojin
```

Workspace homes live in `~/.config/gwm/workspaces` as `scope|directory`
entries. Each `<name>.code-workspace` manifest materializes as a sibling
`<name>/` directory. Names can be qualified (`whatwapp/studiojin`) or short
when unique (`studiojin`).

Manage membership from the CLI:

```bash
gwm-workspace create personal/writing
gwm-workspace add writing ~/source/mateonunez/website
gwm-workspace repos writing
gwm-workspace remove writing website
```

From Neovim, use `<leader>gw` or `:GwmWorkspace` to choose either a curated
workspace or one of the Git folders referenced by its manifests. Both open in a
native floating terminal. `:GwmWorkspace studiojin` opens a workspace directly;
`:GwmFolder [path]` opens one repository. Use `:GwmWorkspaceAdd`,
`:GwmWorkspaceRemove`, `:GwmWorkspaceSync`, and `:GwmWorkspaceEdit` to manage
the selected workspace. Quit GWM with `q`; the terminal closes and focus
returns to the editor.

Set `GWM_WORKSPACES_FILE` to use a different workspace registry without editing
the versioned defaults.

Useful bindings:

- `n` / `e`: next / previous worktree (Colemak down / up)
- `N`: create a worktree
- `E`: rename the selected worktree
- `Enter`: exit into the selected worktree
- `l` / `L`: open lazygit in an overlay / fullscreen
- `r` / `R`: review the selected branch with Neovim + CodeDiff
- `t`: open the worktree in a tmux pane
- `a`: inspect detected coding-agent sessions

The CodeDiff launcher resolves the selected base and head to commit IDs before
starting Neovim, then opens a PR-style three-dot comparison. Validate changes
to the configuration with:

```bash
gwm config validate
gwm-workspace list
gwm-workspace open studiojin list
```

`gwm doctor` currently operates on one repository at a time; run it from the
repository you want to diagnose.

---

## 📦 vscode

The `vscode` configuration contains just the generics settings and some keybindings to improve UX.

## 📦 zsh

Generic `zsh` configuration that contains some aliases, the theme and the plugins.

## 📝 License

[MIT](MIT).
