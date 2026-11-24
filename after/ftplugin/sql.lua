-- SQL buffers: add vim-dadbod's table/column completion on top of the normal sources.
-- (Indentation is handled globally in lua/indent.lua.)
local ok, cmp = pcall(require, "cmp")
if ok then
  cmp.setup.buffer({
    sources = {
      { name = "vim-dadbod-completion" },
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "path" },
    },
  })
end
