return {

  -- Mason (LSP installer)
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = true,
  },

  -- Mason bridge for LSP servers
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "pyright",
          "ts_ls",
          "lua_ls",
        },
        automatic_installation = true,
      })
    end,
  },

  -- LSP configuration (NEW API)
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Common keymaps
      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr, silent = true }

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
      end

      -- PYRIGHT
      vim.lsp.config.pyright = {
        capabilities = capabilities,
        on_attach = on_attach,
      }
      vim.lsp.enable("pyright")

      -- TYPESCRIPT / JAVASCRIPT
      vim.lsp.config.ts_ls = {
        capabilities = capabilities,
        on_attach = on_attach,
      }
      vim.lsp.enable("ts_ls")

      -- LUA (for Neovim config)
      vim.lsp.config.lua_ls = {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = { diagnostics = { globals = { "vim" } } },
        },
      }
      vim.lsp.enable("lua_ls")
    end,
  },

  -- Diagnostics UI
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup({})
      vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>")
    end,
  },

}