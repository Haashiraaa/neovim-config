-- =========================
-- Core safety options (DO NOT SKIP)
-- =========================
vim.opt.undofile = true
vim.opt.backup = true
vim.opt.writebackup = true

local home = vim.fn.expand("~")
vim.opt.undodir = home .. "/.local/state/nvim/undo//"
vim.opt.backupdir = home .. "/.local/state/nvim/backup//"
vim.opt.directory = home .. "/.local/state/nvim/swap//"

-- =========================
-- Lazy.nvim bootstrap
-- =========================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  checker = {
    enabled = true, -- Automatically check for updates
  },
})

-- =========================
-- Keymaps
-- =========================
require("keymaps")

-- =========================
-- UI
-- =========================
vim.cmd("colorscheme ron")