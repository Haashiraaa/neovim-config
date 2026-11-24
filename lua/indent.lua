-- =========================
-- Indentation: 4 spaces, every language
-- =========================
--
-- Neovim's own ftplugins override global indent settings per filetype
-- (Lua/JS/JSON get 8-wide tabs, YAML/Ruby get 2, ...). Setting
-- shiftwidth once is therefore not enough, so we set sane global defaults
-- AND re-apply them on every FileType event, after the ftplugins ran.
--
-- A project's .editorconfig that sets indent_style / indent_size / tab_width
-- is respected (Neovim applies those natively), so shared repos keep their
-- own rules. To force 4 spaces even there, add:  vim.g.editorconfig = false

local WIDTH = 4

vim.opt.expandtab = true
vim.opt.tabstop = WIDTH
vim.opt.shiftwidth = WIDTH
vim.opt.softtabstop = WIDTH

-- Formats that REQUIRE real tab characters: still 4 columns wide, just tabs.
local needs_tabs = {
  make = true,
  go = true,
  gomod = true,
  gowork = true,
}

-- Buffers where tab width is part of the content layout (help text aligns on 8).
local skip = {
  help = true,
  man = true,
  checkhealth = true,
  lazy = true,
  mason = true,
}

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("FourSpaceIndent", { clear = true }),
  callback = function(args)
    if skip[args.match] or vim.bo[args.buf].buftype ~= "" then
      return
    end
    -- Deferred so we always run after the runtime's ftplugin/indent files.
    vim.schedule(function()
      if not vim.api.nvim_buf_is_valid(args.buf) then
        return
      end
      local ec = vim.b[args.buf].editorconfig
      if ec and (ec.indent_style or ec.indent_size or ec.tab_width) then
        return
      end
      local bo = vim.bo[args.buf]
      bo.tabstop = WIDTH
      bo.shiftwidth = WIDTH
      bo.softtabstop = WIDTH
      bo.expandtab = not needs_tabs[args.match]
    end)
  end,
})
