return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main", -- the rewrite; `master` is frozen
    lazy = false, -- this plugin does not support lazy-loading
    enabled = vim.fn.has("nvim-0.12") == 1, -- `main` needs Neovim 0.12+; skipped cleanly on older versions
    build = ":TSUpdate",
    config = function()
      -- Parsers to install (async, no-op when already installed).
      -- Building parsers needs: tree-sitter-cli (0.26.1+, NOT from npm),
      -- a C compiler, tar and curl. See the README.
      local parsers = { "python", "lua", "vim", "sql" }

      if vim.fn.executable("tree-sitter") == 1 then
        require("nvim-treesitter").install(parsers)
      else
        vim.schedule(function()
          vim.notify(
            "nvim-treesitter: `tree-sitter` CLI not found, cannot install parsers.\n"
              .. "Install tree-sitter-cli (0.26.1+) via your package manager.",
            vim.log.levels.WARN
          )
        end)
      end

      -- Highlighting is no longer enabled by setup(); start it per buffer.
      -- Silently skips filetypes whose parser isn't installed.
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("UserTreesitterStart", { clear = true }),
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match) or args.match
          if pcall(vim.treesitter.language.add, lang) then
            pcall(vim.treesitter.start, args.buf, lang)
          end
        end,
      })

      -- Treesitter-based indenting is still experimental upstream, so Neovim's
      -- built-in indent rules stay in charge. To opt in, add to the callback:
      --   vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  },
}
