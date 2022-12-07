local function map(mode, keybind, command)
	vim.keymap.set(mode, keybind, command, { silent = true })
end

map("n", "i", "l")
map("n", "j", "y")
map("n", "g", "t")
map("n", "d", "g")
map("n", "e", "k")
map("n", "f", "e")
map("n", "k", "n")
map("n", "l", "u")
map("n", "n", "j")
map("n", "o", "p")
map("n", "p", "r")
map("n", "r", "s")
map("n", "s", "d")
map("n", "t", "f")
map("n", "u", "i")
map("n", "y", "o")
map("n", "D", "G")
map("n", "E", "K")
map("n", "F", "E")
map("n", "G", "T")
map("n", "I", "L")
map("n", "J", "Y")
map("n", "K", "N")
map("n", "L", "U")
map("n", "N", "J")
map("n", "O", "P")
map("n", "P", "R")
map("n", "R", "S")
map("n", "S", "D")
map("n", "T", "F")
map("n", "U", "I")
map("n", "Y", "O")
map("n", "Y" '"+y')
map("v", "Y" '"+y')
map("n", "D", '"+d')
map("v", "D", '"+d')
map("n", "dd", "gg")
map("n", "df", "ge")
map("n", "dF", "gE")
map("n", "dD" '^"+d$')
map("i", "yy", "<Esc>")
map("n", "yY", '^"+y$')

vim.o.mouse = "a"
vim.o.title = true
vim.o.cmdheight = 1
vim.o.number = true
vim.o.showcmd = true
vim.o.shiftwidth = 2
vim.o.history = 10000
vim.o.undofile = true
vim.o.autoindent = true
vim.o.clipboard = "unnamed"
vim.o.undodir = "~/.vim/undo"
vim.o.directory = "~/.vim/swap"
vim.o.backspace = "indent,eol,start"