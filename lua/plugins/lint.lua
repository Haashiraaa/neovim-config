return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufWritePost", "InsertLeave" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        python = { "ruff" },
      }

      -- Run linting automatically
      vim.api.nvim_create_autocmd(
        { "BufWritePost", "BufReadPost", "InsertLeave" },
        {
          group = vim.api.nvim_create_augroup("UserLint", { clear = true }),
          callback = function()
            lint.try_lint()
          end,
        }
      )
    end,
  },
}
