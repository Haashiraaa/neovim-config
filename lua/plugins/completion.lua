return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "kristijanhusak/vim-dadbod-completion",
    },
    opts = function(_, opts)
      -- make sure sources exists
      opts.sources = opts.sources or {}

      table.insert(opts.sources, {
        name = "vim-dadbod-completion",
      })
    end,
  },
}