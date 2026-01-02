return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "sql",
      },
      highlight = {
        enable = true,
      },
    },
  },
}