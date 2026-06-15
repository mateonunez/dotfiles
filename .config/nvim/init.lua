-- Leader must be set before any <leader> mappings are created. config.keymaps
-- (and lazy plugin specs) define <leader> maps, so set it here at the very top —
-- otherwise those maps bind under the default leader (\) instead of <Space>.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.options")
require("config.keymaps")
require("config.lazy")
