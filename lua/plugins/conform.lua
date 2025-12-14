return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python = { "autopep8" },
        },

        format_on_save = {
          timeout_ms = 10000,
          lsp_fallback = true,
        },
      })
    end,
  },
}
