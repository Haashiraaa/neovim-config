
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


-- Your custom keybindings file (add THIS below)
require("keymaps")

-- Set default colorscheme
vim.cmd("colorscheme ron")
