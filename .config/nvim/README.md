# 📦 Neovim

> Part of [mateonunez/dotfiles](../../README.md). This guide covers the Neovim setup: install, the Colemak key map, the full keybinding cheatsheet, and per-plugin notes.

The `nvim` configuration is built on [lazy.nvim](https://github.com/folke/lazy.nvim). Each plugin lives in its own file under `~/.config/nvim/lua/plugins/`.

```
~/.config/nvim/
├── init.lua                   # entry point: options → keymaps → lazy
└── lua/
    ├── config/
    │   ├── options.lua        # vim options
    │   ├── keymaps.lua        # Colemak remappings (pure Lua)
    │   └── lazy.lua           # lazy.nvim bootstrap
    └── plugins/
        ├── telescope.lua
        ├── treesitter.lua        # includes textobjects
        ├── mason.lua
        ├── conform.lua
        ├── harpoon.lua
        ├── neo-tree.lua
        ├── autopairs.lua
        ├── surround.lua
        ├── grug-far.lua
        ├── claudecode.lua
        ├── codediff.lua
        ├── lsp.lua
        ├── blink.lua
        ├── lualine.lua
        ├── gitsigns.lua
        ├── trouble.lua
        ├── dap.lua               # debugging (nvim-dap + dap-ui)
        ├── lint.lua              # linters (nvim-lint: eslint_d/ruff/…)
        ├── autotag.lua           # auto-close JSX/HTML tags
        ├── refactoring.lua       # extract/inline refactors
        ├── aerial.lua            # symbols outline + breadcrumbs
        ├── ts-error.lua          # readable TypeScript errors
        └── ui.lua                # dressing + fidget (LSP UX)
```

### How to run it?

```bash
$ git clone https://github.com/mateonunez/dotfiles ~/.somewhere
$ ln -s ~/.somewhere/.config/nvim ~/.config/nvim
```

> Please backup your `~/.config/nvim` directory before running the previous command.

On first launch lazy.nvim will automatically install all plugins.

---

### Colemak key map

Remappings live in `lua/config/keymaps.lua`. They apply to normal, visual, and operator-pending modes — **not** insert mode (Ctrl combos in insert mode are unaffected).

**Navigation — the core four (`hnei` replaces `hjkl`):**

| Physical key (Colemak) | Vim action |
|:----------------------:|:----------:|
| `h` | left (unchanged) |
| `n` | down (`j`) |
| `e` | up (`k`) |
| `i` | right (`l`) |

**Full translation table:**

| Colemak | QWERTY action      | Colemak | QWERTY action      |
|:-------:|:------------------:|:-------:|:------------------:|
| `d`     | `g`                | `D`     | `G`                |
| `e`     | `k` (up)           | `E`     | `K`                |
| `f`     | `e` (word end)     | `F`     | `E`                |
| `g`     | `t` (til char)     | `G`     | `T`                |
| `i`     | `l` (right)        | `I`     | `L`                |
| `j`     | `y` (yank)         | `J`     | `Y`                |
| `k`     | `n` (next search)  | `K`     | `N`                |
| `l`     | `u` (undo)         | `L`     | `U`                |
| `n`     | `j` (down)         | `N`     | `J`                |
| `o`     | `p` (paste)        | `O`     | `P`                |
| `p`     | `r` (replace)      | `P`     | `R`                |
| `r`     | `s` (substitute)   | `R`     | `S`                |
| `s`     | `d` (delete)       | `S`     | `D`                |
| `t`     | `f` (find char)    | `T`     | `F`                |
| `u`     | `i` (insert)       | `U`     | `I`                |
| `y`     | `o` (open line)    | `Y`     | `O`                |

**Compound remaps:**

| Colemak | QWERTY action       |
|:-------:|:-------------------:|
| `dd`    | `gg` (go to top)    |
| `df`    | `ge`                |
| `jj`    | `yy` (yank line)    |
| `gg`    | `tt`                |

**Clipboard (`Y`/`D` are always system clipboard):**

| Key   | Action                          |
|:-----:|---------------------------------|
| `Y`   | Copy to system clipboard        |
| `yY`  | Copy whole line to clipboard    |
| `D`   | Cut to system clipboard         |
| `dD`  | Cut whole line to clipboard     |

> **Safe keys for leader bindings** — these are not remapped and can be used freely after `<Space>`: `a b c h m q v w x z`

---

### `<leader>` = `Space`

> **Colemak note on keymaps:** All remappings use `noremap` — they are **non-recursive**. Pressing physical `f` sends `e` (word-end), not `e→k`. Each key maps directly to its QWERTY target with no chaining.

---

### Exploring plugins and keymaps

**Built-in commands (no extra plugin needed):**

| Command | What it shows |
|---------|---------------|
| `:Lazy` | All installed plugins — update, install, profile |
| `:Mason` | LSP servers and formatters — install / uninstall |
| `:checkhealth` | Health status of every plugin |
| `<leader>fc` | Search all available commands via Telescope |
| `<leader>fh` | Search all help docs via Telescope |

**which-key** — press `<Space>` and wait ~0.5 s. A popup lists every binding under that prefix. Works for any prefix: `<leader>`, `]`, `[`.

Groups shown in the popup:

| Prefix | Group |
|--------|-------|
| `<leader>a` | ai / claude |
| `<leader>c` | code / LSP |
| `<leader>d` | diff (codediff) |
| `<leader>f` | find (telescope) |
| `<leader>h` | git hunks |
| `<leader>x` | trouble / diagnostics |
| `<leader>v` | debug (DAP) |
| `<leader>m` | harpoon |
| `<leader>w` | window (splits) |
| `<leader>t` | tabs |
| `]` / `[` | next / prev |

---

### Full keymap cheatsheet

> **`]` / `[` navigation at a glance:**
> `]h`/`[h` = git hunk · `]x`/`[x` = diagnostic (LSP buf) or conflict (diff buf) · `]e`/`[e` = function · `]c`/`[c` = class · `]v`/`[v` = diff hunk · `]m`/`[m` = harpoon · `]f`/`[f` = file (codediff)

#### File explorer — Neo-tree
| Key | Action |
|-----|--------|
| `<leader>b` | Toggle Neo-tree |

#### Windows & tabs

> **Why `<leader>w`, not `Ctrl`?** `<C-h>`/`<C-n>`/`<C-e>` would shadow native normal-mode commands — `<C-e>` (scroll down) especially. And Apple Terminal can't send `<C-i>` distinctly from `<Tab>` for "right". So all window nav lives under `<leader>w` (sequential keys, terminal-agnostic, no native conflicts), keeping `Ctrl` free for its built-ins.

**Window management** — `<leader>w` (physical `hnei` for the four directions):
| Key | Action |
|-----|--------|
| `<leader>wh` / `<leader>wn` / `<leader>we` / `<leader>wi` | Focus left / down / up / right |
| `<leader>w-` | Split below (mirrors tmux `prefix -`) |
| `<leader>w\` | Split right (mirrors tmux `prefix _`) |
| `<leader>wq` | Close window |
| `<leader>wH` / `<leader>wO` | Resize **left** (wider) / **right** (narrower), one step |
| `<leader>wI` / `<leader>wN` | Resize **up** (taller) / **bottom** (shorter), one step |
| `<leader>wr` | **Resize submode** — then tap `h`←wider `o`→narrower `i`↑taller `n`↓shorter, `=` equalize; `q`/`<Esc>` exits |
| `<leader>w=` | Equalize all windows |

> **Resize cluster:** the keys form a direction pad — `H`←left, `O`→right, `I`↑up, `N`↓bottom — where **each key grows the pane toward its own direction** (pulls that wall outward). So on the right-docked Claude pane, `H` (pull the left wall left) widens it and `O` narrows it; `I` makes a pane taller, `N` shorter. This is independent of tmux's `prefix H/N/E/I`.
>
> **Why a submode?** Each one-shot resize drops you back to normal mode, so you'd re-press the whole chord every step. `<leader>wr` enters a sticky mode (the Neovim equivalent of tmux's `-r` repeat): press `<leader>w` once, then tap the bare cluster keys to keep resizing — `hhhh` to widen, `iiii` to grow taller, etc. `getcharstr()` reads raw keys, so it matches the literal `h/o/n/i` the OS sends regardless of the noremap.

**Tabs** — `<leader>t` (≈ tmux windows; built-in `gt`/`gT` are awkward under Colemak):
| Key | Action |
|-----|--------|
| `<leader>tt` | New tab |
| `<leader>tn` | Next tab (one-shot) |
| `<leader>tp` | Previous tab (one-shot) |
| `<leader>tx` | Close tab |
| `<leader>tc` | **Tab submode** — then `h`/`i` switch prev/next, `H`/`I` move tab left/right; `q`/`<Esc>` exits |

> Like `<leader>wr` for windows, `<leader>tc` is a sticky submode: press `<leader>t` once, then tap `i`/`i`/`i` to walk forward through tabs (or `h` back), and `H`/`I` to reorder the current tab — no re-pressing the chord.

#### Telescope — find
| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Buffers |
| `<leader>fh` | Help tags |
| `<leader>fr` | Recent files |
| `<leader>fc` | Commands |
| `<leader>fd` | Diagnostics |

#### Harpoon — bookmarks
| Key | Action |
|-----|--------|
| `<leader>m` | Add current file |
| `<leader>M` | Open quick menu |
| `<leader>1`–`4` | Jump to slot 1–4 |
| `]m` / `[m` | Next / prev file |

#### LSP — code
| Key | Action |
|-----|--------|
| `<leader>ch` | Hover docs |
| `<leader>ca` | Code action |
| `<leader>cw` | Rename symbol |
| `<leader>cq` | Go to definition |
| `<leader>cv` | References |
| `<leader>cm` | Go to implementation |
| `<leader>cx` | Diagnostics float |
| `]x` / `[x` | Next / prev diagnostic |

#### Conform — formatting
| Key | Action |
|-----|--------|
| `<leader>z` | Format buffer manually |

#### Gitsigns — hunks
| Key | Action |
|-----|--------|
| `]h` / `[h` | Next / prev hunk |
| `<leader>ha` | Stage hunk |
| `<leader>hx` | Reset hunk |
| `<leader>hA` | Stage buffer |
| `<leader>hX` | Reset buffer |
| `<leader>hv` | Preview hunk |
| `<leader>hb` | Blame line |
| `<leader>hq` | Hunks → quickfix |

#### Trouble — diagnostics panel
| Key | Action |
|-----|--------|
| `<leader>xx` | Workspace diagnostics |
| `<leader>xb` | Buffer diagnostics |
| `<leader>xq` | Quickfix list |
| `<leader>xv` | LSP refs / definitions |

#### Treesitter — selection
| Key | Action |
|-----|--------|
| `<C-space>` | Expand selection |
| `<bs>` | Shrink selection |

#### Completion — blink.cmp (insert mode)
| Key | Action |
|-----|--------|
| `<C-space>` | Trigger / toggle docs |
| `<C-n>` / `<C-p>` | Next / prev item |
| `<CR>` | Accept |
| `<C-e>` | Hide menu |
| `<Tab>` / `<S-Tab>` | Snippet forward / back |

---

### Treesitter

Syntax highlighting, indentation, and incremental selection for all languages via [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter).

Parsers auto-installed: `typescript`, `tsx`, `javascript`, `lua`, `json`, `jsonc`, `yaml`, `toml`, `markdown`, `bash`, `dockerfile`, `rust`, `python`, `html`, `css`, `gitignore`.

| Key | Action |
|-----|--------|
| `<C-space>` | Expand selection (incremental) |
| `<bs>` | Shrink selection |

---

### Mason

LSP server installer — [mason.nvim](https://github.com/williamboman/mason.nvim) + [mason-lspconfig](https://github.com/williamboman/mason-lspconfig.nvim).

Open the UI with `:Mason`. On first launch, the following tools are auto-installed:

| Tool | Purpose |
|------|---------|
| `lua-language-server`, `typescript-language-server`, `pyright`, `rust-analyzer` | LSP (core) |
| `tailwindcss-language-server`, `css-lsp`, `html-lsp`, `marksman` | LSP (web / markdown) |
| `vscode-eslint-language-server`, `yaml-language-server`, `taplo`, `dockerfile-language-server`, `bash-language-server`, `clangd` | LSP (extra) |
| `biome` | Formatter (JS/TS/JSON) |
| `stylua` | Formatter (Lua) |
| `prettierd` | Formatter (CSS/HTML/YAML/Markdown/MDX) |
| `eslint_d`, `ruff`, `shellcheck`, `markdownlint` | Linters (via nvim-lint) |

The LSP set mirrors your VS Code extensions. Add more tools to the `ensure_installed` list in `lua/plugins/mason.lua`.

---

### Conform

Formatting via [conform.nvim](https://github.com/stevearc/conform.nvim), mirroring your VS Code defaults: **Biome** for JS/TS/JSON, **Stylua** for Lua, **prettierd** for CSS/HTML/YAML/Markdown/MDX.

| Key | Action |
|-----|--------|
| `<leader>z` | Format buffer manually (`z` is not remapped in Colemak) |

**Manual only** — there is no format-on-save (matches your VS Code `editor.formatOnSave: false`); run `<leader>z` to format. `:ConformInfo` shows the resolved formatters for the current buffer.

---

### Harpoon

Per-project file bookmarks for fast jumping — [harpoon2](https://github.com/ThePrimeagen/harpoon/tree/harpoon2).

Designed for monorepo workflows: bookmark the 3–4 files you're actively editing and jump between them without Telescope.

| Key | Action |
|-----|--------|
| `<leader>m` | Add current file to list (`m` not remapped) |
| `<leader>M` | Open harpoon quick menu |
| `<leader>1` – `<leader>4` | Jump directly to slot 1–4 |
| `]m` | Next file in list |
| `[m` | Prev file in list |

---

### Telescope

Fuzzy finder — [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) + [fzf-native](https://github.com/nvim-telescope/telescope-fzf-native.nvim).

| Keymap | Action |
|--------|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Buffers |
| `<leader>fh` | Help tags |
| `<leader>fr` | Recent files |
| `<leader>fc` | Commands |
| `<leader>fd` | Diagnostics |

**Inside a picker (Colemak-aware):**

| Key | Mode | Action |
|-----|:----:|--------|
| `n` | normal | Move down |
| `e` | normal | Move up |
| `<C-n>` | insert | Move down |
| `<C-e>` | insert | Move up |
| `q` | normal | Close |

---

### File explorer — Neo-tree

| Keymap | Action |
|--------|--------|
| `<leader>b` | Toggle Neo-tree |

**Navigation** — the global Colemak noremap applies automatically:

| Physical key | Action |
|:------------:|--------|
| `n` | Move cursor down |
| `e` | Move cursor up |
| `i` | Open / expand node |
| `h` | Close / collapse node |
| `q` | Close tree |

> `d` (triggered by physical `s`) is disabled in Neo-tree to prevent accidental deletions. Use `<del>` to delete.

---

### LSP

Config in `lua/plugins/lsp.lua`. Servers enabled: `lua_ls`, `ts_ls`, `rust_analyzer`, `pyright`, `tailwindcss`, `eslint`, `yamlls`, `taplo`, `cssls`, `html`, `marksman`, `dockerls`, `bashls`, `clangd` — mirroring your VS Code extensions. Edit the `vim.lsp.enable({…})` list to add more.

**Inlay hints** (parameter names / inferred types, like VS Code) are enabled automatically for any server that supports them; toggle per-buffer with `<leader>ci`. Diagnostics show inline virtual text + signs.

All bindings use the `<leader>c` prefix (`c` = code, not remapped).

| Keymap | Action |
|--------|--------|
| `<leader>ch` | Hover documentation |
| `<leader>ca` | Code action |
| `<leader>cw` | Rename symbol |
| `<leader>cq` | Go to definition |
| `<leader>cv` | References |
| `<leader>cm` | Go to implementation |
| `<leader>cx` | Diagnostics float |
| `<leader>ci` | Toggle inlay hints |
| `<leader>cr` | Refactor menu (extract / inline — normal + visual) |
| `<leader>cs` | Symbols outline (aerial) |
| `]x` | Next diagnostic |
| `[x` | Prev diagnostic |

> **IDE UX (no keymaps, automatic):** `refactoring.nvim` powers `<leader>cr`; `aerial.nvim` the `<leader>cs` outline; **barbecue** shows breadcrumbs in the winbar; **dressing** turns code-action / rename / refactor pickers into floats; **fidget** shows LSP progress; **ts-error-translator** rewrites cryptic TS errors (like `pretty-ts-errors`).

---

### Linting — nvim-lint

[nvim-lint](https://github.com/mfussenegger/nvim-lint) runs standalone linters where the LSP doesn't, on write / read / leaving insert. Each linter no-ops when a project has no matching config, so they're safe to leave on.

| Filetype | Linter |
|----------|--------|
| JS / TS (+ react) | `eslint_d` |
| Python | `ruff` |
| Shell | `shellcheck` |
| Markdown | `markdownlint` |

---

### Debugging — nvim-dap

[nvim-dap](https://github.com/mfussenegger/nvim-dap) + [dap-ui](https://github.com/rcarriga/nvim-dap-ui) + virtual-text, with adapters installed via `mason-nvim-dap` (Python `debugpy`, JS/TS `js-debug`, Rust/C `codelldb`) — the equivalent of your VS Code `debugpy` / `cpptools`.

**Hot path uses VS Code's F-keys** (layout-independent):

| Key | Action |
|-----|--------|
| `<F5>` | Start / continue |
| `<F9>` | Toggle breakpoint |
| `<F10>` | Step over |
| `<F11>` | Step into |
| `<F12>` | Step out |

**Full group** — `<leader>v` (debug; `v` is a free, Colemak-safe leader key):

| Key | Action |
|-----|--------|
| `<leader>vv` / `<leader>vc` | Start / continue |
| `<leader>vb` / `<leader>vB` | Toggle / conditional breakpoint |
| `<leader>vo` / `<leader>vi` / `<leader>vu` | Step over / into / out |
| `<leader>vd` | Toggle DAP UI |
| `<leader>ve` | Eval expression (normal/visual) |
| `<leader>vr` / `<leader>vl` / `<leader>vt` | REPL / run last / terminate |

The DAP UI opens automatically when a session starts and closes when it ends.

---

### Completion — blink.cmp

[blink.cmp](https://github.com/Saghen/blink.cmp) replaces nvim-cmp. Ctrl combos work in **insert mode** — unaffected by Colemak noremap.

| Key | Action |
|-----|--------|
| `<C-Space>` | Trigger / toggle docs |
| `<C-n>` | Select next item |
| `<C-p>` | Select prev item |
| `<CR>` | Accept suggestion |
| `<C-e>` | Hide menu |
| `<Tab>` | Next snippet stop / next item |
| `<S-Tab>` | Prev snippet stop / prev item |

---

### Lualine

Statusline matching the tmux color palette (dark background, amber active mode, blue insert, red/visual, green command). `globalstatus = true` — single bar across all splits.

---

### Gitsigns

Git hunk decorations in the sign column. `<leader>h` prefix (`h` = hunk, not remapped).

| Keymap | Action |
|--------|--------|
| `]h` | Next hunk |
| `[h` | Prev hunk |
| `<leader>ha` | Stage hunk |
| `<leader>hx` | Reset hunk |
| `<leader>hA` | Stage entire buffer |
| `<leader>hX` | Reset entire buffer |
| `<leader>hv` | Preview hunk |
| `<leader>hb` | Blame current line |
| `<leader>hq` | Send hunks to quickfix |

---

### Trouble

Diagnostics and LSP results panel — [trouble.nvim](https://github.com/folke/trouble.nvim).

| Keymap | Action |
|--------|--------|
| `<leader>xx` | Toggle workspace diagnostics |
| `<leader>xb` | Toggle buffer diagnostics |
| `<leader>xq` | Toggle quickfix list |
| `<leader>xv` | Toggle LSP definitions / references |

**Inside the Trouble panel:**

| Key | Action |
|:---:|--------|
| `n` | Next item |
| `e` | Prev item |
| `q` / `<esc>` | Close |

### Autopairs

[nvim-autopairs](https://github.com/windwp/nvim-autopairs) — auto-closes `()`, `{}`, `[]`, `""`, etc. Treesitter-aware (won't pair inside strings/comments). Integrated with blink.cmp so `<CR>` acceptance doesn't leave a dangling bracket.

| Key | Action |
|-----|--------|
| `<M-e>` | Fast-wrap: wrap the nearest pair around cursor |

---

### Surround

[nvim-surround](https://github.com/kylechui/nvim-surround) — add, change, delete surrounding characters.

Default triggers (`ys`/`cs`/`ds`) all collide with Colemak remaps, so everything is rebased on `z` (not remapped).

| Physical keys | Action | Example |
|---------------|--------|---------|
| `za` + motion + char | Add surrounding | `za` + `w` + `"` → wrap word in `"` |
| `zaa` | Surround current line | |
| `zx` + char | Delete surrounding | `zx` + `"` → remove `"` |
| `zc` + old + new | Change surrounding | `zc` + `"` + `'` → `"` → `'` |
| `Z` (visual) | Surround selection | |

---

### Treesitter text objects

[nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) — select/jump by function, class, block.

> **Colemak note:** the noremap applies in operator-pending mode too. Physical `i` sends `l`, physical `f` sends `e`. Keymaps are defined for what vim *receives*, not what you physically type.

**Select** (use after `s` = delete, `j` = yank, `za` = surround, etc.):

| Physical keys | Vim sees | Object |
|:---:|:---:|---|
| `a` + `f` | `ae` | outer function |
| `i` + `f` | `le` | inner function |
| `a` + `c` | `ac` | outer class |
| `i` + `c` | `lc` | inner class |
| `a` + `b` | `ab` | outer block |
| `i` + `b` | `lb` | inner block |
| `a` + `a` | `aa` | outer parameter |
| `i` + `a` | `la` | inner parameter |

**Jump to next/prev function or class:**

| Key | Action |
|-----|--------|
| `]e` | Next function start (physical `]` + `f`) |
| `[e` | Prev function start |
| `]c` | Next class start |
| `[c` | Prev class start |

---

### Grug-far — search & replace

[grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim) — project-wide ripgrep search & replace in a buffer. Supports regex, flags, and live preview.

| Key | Action |
|-----|--------|
| `<leader>sr` | Open search & replace panel |
| `<leader>sw` | Open with word under cursor pre-filled |

---

### Claude Code — agentic AI in the editor

[claudecode.nvim](https://github.com/coder/claudecode.nvim) — runs the Claude Code CLI inside Neovim over the same WebSocket IDE protocol used by the official VS Code / JetBrains extensions. Gives in-editor diff review (accept / reject Claude's changes), selection sharing, and `@`-file mentions.

**Prerequisites:** the [`claude`](https://docs.claude.com/en/docs/claude-code) CLI on your `PATH` (authenticate once with `claude` in a terminal). No `ANTHROPIC_API_KEY` env var needed — the CLI handles auth.

> Uses Neovim's **native** terminal (`provider = "native"`, `split_side = "right"`, 35% width), so it pulls in no extra UI dependency — only `plenary.nvim`, which is already installed.

**Bindings** — `<leader>a` prefix (`a` = ai, not remapped in Colemak):

| Key | Mode | Action |
|-----|:----:|--------|
| `<leader>ac` | n | Toggle Claude terminal |
| `<C-l>` | n, t | Toggle Claude — **also works from inside the terminal** |
| `<leader>af` | n | Focus Claude window |
| `<leader>ar` | n | Resume a previous session |
| `<leader>aC` | n | Continue last conversation |
| `<leader>am` | n | Select model |
| `<leader>ab` | n | Add current buffer to context |
| `<leader>as` | v | Send visual selection to Claude |
| `<leader>as` | neo-tree | Add file/folder under cursor |
| `<leader>aa` | n | Accept Claude's proposed diff |
| `<leader>ad` | n | Reject Claude's proposed diff |

**Terminal mode (Colemak-aware):** when focused inside the Claude terminal you are in **terminal mode** — keystrokes go to the Claude TUI, not Neovim, so `<leader>` maps don't fire there.

- `<C-l>` — one press toggles Claude show/hide from anywhere, terminal mode included. It's a `<cmd>` mapping, so it runs without disturbing Claude's input. (Trade-off: shadows normal-mode `<C-l>` redraw, and Claude itself never receives `<C-l>`.)
- `<C-g>` / `<C-\><C-n>` — exit terminal mode → normal mode (e.g. to scroll/yank Claude's output), then re-enter with `a`/`u`. The `<C-g>` alias lives in `keymaps.lua` (global, any `:terminal`); both are unaffected by the Colemak noremap, which only touches normal/visual/operator modes.

---

### CodeDiff — VSCode-style diff view

[codediff.nvim](https://github.com/esmuellert/codediff.nvim) — two-tier diff highlighting (line-level + character-level), side-by-side and inline layouts, git explorer, file history, and merge conflict resolution. Uses the same diff engine as VSCode.

> **Colemak note:** All keymaps inside the diff window are **buffer-local**, so physical keys work correctly — they override the global noremap (same rule as Neo-tree). `]v`/`[v` are used for hunk navigation to keep `]c`/`[c` free for treesitter class jumps.

**Open CodeDiff** (global, normal mode):

| Key | Action |
|-----|--------|
| `<leader>dg` | Open git diff explorer (changed files) |
| `<leader>df` | Diff current file vs HEAD |
| `<leader>dh` | File history (commit log) |

**Commands:**

| Command | Action |
|---------|--------|
| `:CodeDiff` | Git status explorer |
| `:CodeDiff HEAD~5` | Compare working tree vs 5 commits ago |
| `:CodeDiff main...` | PR-style diff (only your branch changes) |
| `:CodeDiff file HEAD` | Current file vs HEAD |
| `:CodeDiff history` | Per-commit history viewer |
| `:CodeDiff --inline` | Force inline (unified) layout |

**Inside diff view — navigation:**

| Key | Action |
|-----|--------|
| `]v` / `[v` | Next / prev hunk |
| `]f` / `[f` | Next / prev file (explorer/history) |
| `t` | Toggle side-by-side ↔ inline layout |
| `gc` | Toggle compact mode (fold unchanged regions) |
| `g?` | Show help (all available keys) |
| `q` | Close diff tab |

**Inside diff view — staging / hunks:**

| Key | Action |
|-----|--------|
| `-` | Stage / unstage current file |
| `<leader>hs` | Stage hunk under cursor |
| `<leader>hu` | Unstage hunk under cursor |
| `<leader>hr` | Discard hunk (working tree only) |
| `do` | Get change from other buffer (vimdiff-style) |
| `dp` | Put change to other buffer |
| `ih` | Textobject: select hunk (`vih` = visual, `yih` = yank) |

**Explorer panel** (inside the file list):

| Key | Action |
|-----|--------|
| `<CR>` | Open diff for selected file |
| `K` | Hover: preview file diff |
| `R` | Refresh git status |
| `i` | Toggle list ↔ tree view |
| `S` / `U` | Stage all / unstage all |
| `X` | Discard changes (restore file) |
| `<leader>b` | Toggle explorer visibility |
| `<leader>de` | Focus explorer panel |
| `gm` | Align moved code blocks across panes |

**Merge conflict resolution** (`<leader>d` group, active in conflict diff view):

| Key | Action |
|-----|--------|
| `<leader>di` | Accept incoming (theirs) |
| `<leader>dc` | Accept current (ours) |
| `<leader>db` | Accept both |
| `<leader>dx` | Discard (keep base) |
| `<leader>dI` | Accept ALL incoming |
| `<leader>dC` | Accept ALL current |
| `<leader>dB` | Accept ALL both |
| `<leader>dX` | Discard ALL |
| `]x` / `[x` | Next / prev conflict |

> Conflict keymaps moved off `<leader>c` (our code/LSP group) to `<leader>d`. `]x`/`[x` are buffer-local in the conflict view and don't shadow LSP diagnostic jumps (which are buffer-local to LSP buffers).
