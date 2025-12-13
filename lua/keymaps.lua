-- Run Python file with F12
vim.keymap.set("n", "<F12>", function()
  vim.cmd("w")
  vim.cmd("!python3 %")
end, { desc = "Run Python file" })

vim.keymap.set("n", "<leader>e", function()
  vim.diagnostic.open_float()
end, { desc = "Show diagnostic error" })

vim.o.updatetime = 250

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end,
})
