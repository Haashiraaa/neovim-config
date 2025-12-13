return {
  {
    "supermaven-inc/supermaven-nvim",
    event = "InsertEnter",
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<M-Space>",
          next_suggestion = "<M-]>",
          prev_suggestion = "<M-[>",
        },
      })
    end
  },

}
