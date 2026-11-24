-- =========================
-- Neovim config entry point
-- Requires Neovim 0.11+ (developed and tested on 0.12)
-- =========================

-- Leader must be set BEFORE lazy.nvim loads (backslash = Neovim's default)
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- Core options (undo/backup safety, UI) and 4-space indentation everywhere
require("options")
require("indent")

-- =========================
-- Lazy.nvim bootstrap
-- =========================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  checker = {
    enabled = true, -- Automatically check for updates
  },
})

-- =========================
-- Keymaps & diagnostics
-- =========================
require("keymaps")
require("diagnostics")

-- =========================
-- UI
-- =========================
vim.cmd("colorscheme ron")
