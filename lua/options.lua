-- =========================
-- Core safety options (DO NOT SKIP)
-- =========================

vim.opt.termguicolors = true
vim.o.background = "dark"

vim.opt.undofile = true
vim.opt.backup = true
vim.opt.writebackup = true

-- Keep undo/backup/swap files out of your projects. The trailing "//" makes
-- Neovim encode the full file path in the filename so same-named files
-- from different folders never clash.
local state = vim.fn.stdpath("state") -- ~/.local/state/nvim on Linux/Termux
for name, option in pairs({ undo = "undodir", backup = "backupdir", swap = "directory" }) do
  vim.fn.mkdir(state .. "/" .. name, "p") -- make sure the folder exists
  vim.opt[option] = state .. "/" .. name .. "//"
end
