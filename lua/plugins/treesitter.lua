return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "python", "lua", "vim", "sql" },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
}
