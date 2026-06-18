local opt = vim.opt

opt.number        = true
opt.relativenumber = true
opt.title         = true
opt.autoindent    = true
opt.showcmd       = true
opt.cmdheight     = 1
opt.shiftwidth    = 2
opt.tabstop       = 2
opt.softtabstop   = 2
opt.expandtab     = true
opt.mouse         = "a"
opt.undofile      = true
opt.backspace     = "indent,eol,start"
opt.history       = 10000
opt.clipboard     = "unnamed"
opt.signcolumn    = "yes"         -- stable gutter (diagnostics/git signs don't shift text)
