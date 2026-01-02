return {
  -- Core database plugin
  {
    "tpope/vim-dadbod",
    lazy = true,
  },

  -- UI for browsing databases
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = { "tpope/vim-dadbod" },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection" },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },

  -- Completion for SQL (tables, columns, etc.)
  {
    "kristijanhusak/vim-dadbod-completion",
    dependencies = { "tpope/vim-dadbod" },
    ft = { "sql", "psql" },
  },
}