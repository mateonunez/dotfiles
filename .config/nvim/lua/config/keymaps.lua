-- Colemak remappings (physical key → QWERTY action)
-- h stays h (left), n=j (down), e=k (up), i=l (right)
local remap = function(from, to)
  vim.keymap.set("", from, to, { noremap = true })
end

-- Single keys
remap("d", "g")
remap("e", "k")
remap("f", "e")
remap("g", "t")
remap("i", "l")
remap("j", "y")
remap("k", "n")
remap("l", "u")
remap("n", "j")
remap("o", "p")
remap("p", "r")
remap("r", "s")
remap("s", "d")
remap("t", "f")
remap("u", "i")
remap("y", "o")

-- Uppercase
remap("D", "G")
remap("E", "K")
remap("F", "E")
remap("G", "T")
remap("I", "L")
remap("J", "Y")
remap("K", "N")
remap("L", "U")
remap("N", "J")
remap("O", "P")
remap("P", "R")
remap("R", "S")
remap("S", "D")
remap("T", "F")
remap("U", "I")
remap("Y", "O")

-- Compound remaps
remap("dd", "gg")
remap("df", "ge")
remap("dF", "gE")
remap("jj", "yy")
remap("jf", "yf")
remap("jF", "yF")
remap("gg", "tt")
remap("gG", "tT")

-- Window navigation lives entirely under <leader>w, NOT on Ctrl.
-- Why not Ctrl: <C-h>/<C-n>/<C-e> would shadow useful native normal-mode
-- commands — <C-e> (scroll down a line) especially, plus <C-n>/<C-h> (cursor
-- motion). And Apple Terminal can't send <C-i> (= <Tab>) for "right" anyway.
-- So all four directions go under <leader>w, keeping native Ctrl intact.
--
-- Window management under <leader>w (physical h/n/e/i match Colemak nav; as
-- mapping continuations they are literal, so the single-key noremaps don't fire).
--   tmux `prefix -` (split -v, stacked)    → :split
--   tmux `prefix _` (split -h, side x side) → :vsplit
vim.keymap.set("n", "<leader>wh", "<C-w>h",        { noremap = true, desc = "Focus left"  })
vim.keymap.set("n", "<leader>wn", "<C-w>j",        { noremap = true, desc = "Focus down"  })
vim.keymap.set("n", "<leader>we", "<C-w>k",        { noremap = true, desc = "Focus up"    })
vim.keymap.set("n", "<leader>wi", "<C-w>l",        { noremap = true, desc = "Focus right" })
vim.keymap.set("n", "<leader>w-", "<cmd>split<cr>",  { noremap = true, desc = "Split below"  })
vim.keymap.set("n", "<leader>w\\", "<cmd>vsplit<cr>", { noremap = true, desc = "Split right" })
vim.keymap.set("n", "<leader>wq", "<cmd>close<cr>",  { noremap = true, desc = "Close window" })

-- One-shot resize with capital H/N/E/I (mirrors tmux `prefix H/N/E/I`). Each
-- press resizes once; for repeats use the resize submode below (<leader>wr).
vim.keymap.set("n", "<leader>wH", "<cmd>vertical resize -5<cr>", { noremap = true, desc = "Resize narrower (left)"  })
vim.keymap.set("n", "<leader>wI", "<cmd>vertical resize +5<cr>", { noremap = true, desc = "Resize wider (right)"    })
vim.keymap.set("n", "<leader>wN", "<cmd>resize +3<cr>",          { noremap = true, desc = "Resize taller (down)"    })
vim.keymap.set("n", "<leader>wE", "<cmd>resize -3<cr>",          { noremap = true, desc = "Resize shorter (up)"     })
vim.keymap.set("n", "<leader>w=", "<C-w>=",                      { noremap = true, desc = "Equalize windows"        })

-- Resize submode: press <leader>wr ONCE, then tap the Colemak nav keys to keep
-- resizing the focused window until you exit — this is the tmux `-r` (repeat)
-- behaviour for resizing, but as a sticky mode so you never re-press <leader>w:
--   h / i  → narrower / wider  (width)
--   n / e  → taller   / shorter (height)
--   =      → equalize  ·  q / <Esc> → exit
-- getcharstr() reads raw input (it bypasses the noremap above), so we match the
-- literal h/n/e/i the OS Colemak layout sends; capitals work too for tmux muscle
-- memory. Any other key exits.
local function resize_mode()
  while true do
    vim.api.nvim_echo({ { "-- RESIZE --  h/i width · n/e height · = equalize · q/Esc exit", "ModeMsg" } }, false, {})
    local ok, ch = pcall(vim.fn.getcharstr)
    if not ok then break end
    if     ch == "h" or ch == "H" then vim.cmd("vertical resize -3")
    elseif ch == "i" or ch == "I" then vim.cmd("vertical resize +3")
    elseif ch == "n" or ch == "N" then vim.cmd("resize +2")
    elseif ch == "e" or ch == "E" then vim.cmd("resize -2")
    elseif ch == "="              then vim.cmd("wincmd =")
    else break end
    vim.cmd("redraw")
  end
  vim.cmd("echo ''") -- clear the prompt line on exit
end
vim.keymap.set("n", "<leader>wr", resize_mode, { noremap = true, desc = "Resize mode (repeat h/n/e/i)" })

-- Tabs ≈ tmux windows, under <leader>t. (Built-in gt/gT are awkward under Colemak:
-- physical d→g, g→t, so "gt" is pressed as physical d-then-g.)
vim.keymap.set("n", "<leader>tt", "<cmd>tabnew<cr>",      { noremap = true, desc = "New tab"      })
vim.keymap.set("n", "<leader>tn", "<cmd>tabnext<cr>",     { noremap = true, desc = "Next tab"     })
vim.keymap.set("n", "<leader>tp", "<cmd>tabprevious<cr>", { noremap = true, desc = "Previous tab" })
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<cr>",    { noremap = true, desc = "Close tab"    })

-- Terminal mode → normal mode. The built-in <C-\><C-n> is an awkward two-chord
-- escape, so <C-g> does the same in one press (the built-in still works too).
-- Why <C-g>: Apple Terminal sends it reliably (unlike Ctrl+punctuation), and a
-- TUI like Claude Code doesn't use it (it's the bell) — so we never steal a key
-- the TUI needs, the way mapping <Esc> here would. Terminal-mode maps are immune
-- to the Colemak noremap above (mode "" excludes terminal mode).
vim.keymap.set("t", "<C-g>", "<C-\\><C-n>", { noremap = true, desc = "Exit terminal mode" })

-- Clipboard (system)
vim.keymap.set("n", "Y",  '"+y',      { noremap = true })
vim.keymap.set("v", "Y",  '"+y',      { noremap = true })
vim.keymap.set("n", "yY", '^"+y$',    { noremap = true })
vim.keymap.set("n", "D",  '"+d',      { noremap = true })
vim.keymap.set("v", "D",  '"+d',      { noremap = true })
vim.keymap.set("n", "dD", '^"+d$',    { noremap = true })
