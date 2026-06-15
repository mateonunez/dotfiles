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
        ├── codecompanion.lua
        ├── lsp.lua
        ├── blink.lua
        ├── lualine.lua
        ├── gitsigns.lua
        └── trouble.lua
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
| `<leader>c` | code / LSP |
| `<leader>f` | find (telescope) |
| `<leader>h` | git hunks |
| `<leader>x` | trouble / diagnostics |
| `<leader>m` | harpoon |
| `<leader>w` | window (splits) |
| `<leader>t` | tabs |
| `]` / `[` | next / prev |

---

### Full keymap cheatsheet

#### File explorer — Neo-tree
| Key | Action |
|-----|--------|
| `<leader>a` | Toggle Neo-tree |

#### Windows & tabs

> **Why `<leader>w`, not `Ctrl`?** `<C-h>`/`<C-n>`/`<C-e>` would shadow native normal-mode commands — `<C-e>` (scroll down) especially. And Apple Terminal can't send `<C-i>` distinctly from `<Tab>` for "right". So all window nav lives under `<leader>w` (sequential keys, terminal-agnostic, no native conflicts), keeping `Ctrl` free for its built-ins.

**Window management** — `<leader>w` (physical `hnei` for the four directions):
| Key | Action |
|-----|--------|
| `<leader>wh` / `<leader>wn` / `<leader>we` / `<leader>wi` | Focus left / down / up / right |
| `<leader>w-` | Split below (mirrors tmux `prefix -`) |
| `<leader>w\` | Split right (mirrors tmux `prefix _`) |
| `<leader>wq` | Close window |
| `<leader>wH` / `<leader>wI` | Resize narrower / wider (mirrors tmux `prefix H/I`) |
| `<leader>wN` / `<leader>wE` | Resize taller / shorter (mirrors tmux `prefix N/E`) |
| `<leader>w=` | Equalize all windows |

**Tabs** — `<leader>t` (≈ tmux windows; built-in `gt`/`gT` are awkward under Colemak):
| Key | Action |
|-----|--------|
| `<leader>tt` | New tab |
| `<leader>tn` | Next tab |
| `<leader>tp` | Previous tab |
| `<leader>tx` | Close tab |

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
| `lua-language-server` | LSP |
| `typescript-language-server` | LSP |
| `pyright` | LSP |
| `rust-analyzer` | LSP |
| `biome` | Formatter (JS/TS/JSON) |
| `stylua` | Formatter (Lua) |

Add more tools to the `ensure_installed` list in `lua/plugins/mason.lua`.

---

### Conform

Format on save via [conform.nvim](https://github.com/stevearc/conform.nvim). Uses Biome for TypeScript/JavaScript/JSON and Stylua for Lua.

| Key | Action |
|-----|--------|
| `<leader>z` | Format buffer manually (`z` is not remapped in Colemak) |

Format-on-save is enabled by default with a 1 s timeout and LSP fallback. To disable it for a buffer: `:ConformInfo`.

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
| `<leader>a` | Toggle Neo-tree |

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

Config in `lua/plugins/lsp.lua`. Servers enabled by default: `lua_ls`, `ts_ls`, `rust_analyzer`, `pyright`. Add more to the `servers` table.

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
| `]x` | Next diagnostic |
| `[x` | Prev diagnostic |

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
| `<leader>w` | Open search & replace panel (`w` = workspace, not remapped) |
| `<leader>W` | Open with word under cursor pre-filled |

---

### CodeCompanion — AI chat

[codecompanion.nvim](https://github.com/olimorris/codecompanion.nvim) — inline AI chat and code actions. Configured to use Anthropic (Claude) by default. Requires `ANTHROPIC_API_KEY` in your environment.

| Key | Action |
|-----|--------|
| `<leader>cc` | Toggle chat panel |
| `<leader>cC` | Open actions menu |

Both bindings work in normal and visual mode — select code first to send it as context.
