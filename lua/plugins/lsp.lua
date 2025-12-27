return {

  ------------------------------------------------------------------
  -- Mason (LSP / tooling installer)
  ------------------------------------------------------------------
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = true,
  },

  ------------------------------------------------------------------
  -- Mason ↔ LSP bridge
  ------------------------------------------------------------------
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

  ------------------------------------------------------------------
  -- LSP configuration (Neovim 0.11+ API)
  ------------------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Shared LSP keymaps
      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr, silent = true }

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
      end

      --------------------------------------------------------------
      -- PYTHON (Pyright)
      --------------------------------------------------------------
      vim.lsp.config.pyright = {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "strict", -- change to "strict" to feel a world of pain
              diagnosticSeverityOverrides = {
                  reportMissingTypeStubs = "none",
                  reportUnknownVariableType = "warning",
                  reportUnknownMemberType = "none",
              	  
		  -- keep these ON (important)
                  reportOptionalSubscript = "error",
                  reportOptionalMemberAccess = "warning",
                  reportOptionalCall = "error",
                  reportGeneralTypeIssues = "error",
                  reportReturnType = "error",
		  reportUnusedVariable = "none",

	      },
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
          },
        },
      }
      vim.lsp.enable("pyright")

      --------------------------------------------------------------
      -- TYPESCRIPT / JAVASCRIPT
      --------------------------------------------------------------
      vim.lsp.config.tsserver = {
        capabilities = capabilities,
        on_attach = on_attach,
      }
      vim.lsp.enable("tsserver")

      --------------------------------------------------------------
      -- LUA (Neovim config)
      --------------------------------------------------------------
      vim.lsp.config.lua_ls = {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      }
      vim.lsp.enable("lua_ls")
    end,
  },

  ------------------------------------------------------------------
  -- Diagnostics UI
  ------------------------------------------------------------------
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup({})
      vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true })
    end,
  },

}
