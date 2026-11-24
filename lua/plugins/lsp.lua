return {

  ------------------------------------------------------------------
  -- Mason (LSP / tooling installer)
  ------------------------------------------------------------------
  {
    "mason-org/mason.nvim",
    opts = {},
  },

  ------------------------------------------------------------------
  -- Mason <-> LSP bridge (v2: needs Neovim 0.11+)
  ------------------------------------------------------------------
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "pyright",
        "ts_ls",
        "lua_ls",
      },
      -- We enable servers explicitly below, so a server you merely install
      -- from :Mason never starts behind your back (e.g. ruff would
      -- duplicate the diagnostics nvim-lint already gives you).
      automatic_enable = false,
    },
  },

  ------------------------------------------------------------------
  -- LSP configuration (Neovim 0.11+ native API)
  ------------------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      -- Completion capabilities for every server
      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      -- Shared LSP keymaps (set when a server attaches to a buffer)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
        callback = function(args)
          local opts = { buffer = args.buf, silent = true }

          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "[d", function()
            vim.diagnostic.jump({ count = -1, float = true })
          end, opts)
          vim.keymap.set("n", "]d", function()
            vim.diagnostic.jump({ count = 1, float = true })
          end, opts)
        end,
      })

      --------------------------------------------------------------
      -- PYTHON (Pyright)
      --------------------------------------------------------------
      vim.lsp.config("pyright", {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "strict", -- "basic" if strict feels like a world of pain
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
      })

      --------------------------------------------------------------
      -- LUA (Neovim config)
      --------------------------------------------------------------
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })

      -- TypeScript / JavaScript uses the stock "ts_ls" config from nvim-lspconfig
      -- (the old name "tsserver" was removed upstream).
      vim.lsp.enable({ "pyright", "ts_ls", "lua_ls" })
    end,
  },

  ------------------------------------------------------------------
  -- Diagnostics UI (Trouble v3)
  ------------------------------------------------------------------
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    opts = {},
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        silent = true,
        desc = "Diagnostics (Trouble)",
      },
    },
  },

}
