return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2",
    build = "make install_jsregexp", -- optional but recommended
  },

  {
    "rafamadriz/friendly-snippets",
    dependencies = { "L3MON4D3/LuaSnip" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}