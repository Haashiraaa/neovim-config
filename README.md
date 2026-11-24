## Neovim Configuration (Batteries Included)

This repository contains my personal Neovim configuration, pre-wired so you don't have to suffer through hours of setup.

It focuses on Python development, but it's clean and extendable for other languages too.

### ✨ What you get out of the box

- ⚡ Smart auto-completion (native LSP + nvim-cmp + LuaSnip snippets)
- 🧰 Language servers installed for you by Mason: **Python** (pyright), **TypeScript/JavaScript** (ts_ls), **Lua** (lua_ls)
- 🤖 AI inline suggestions (Supermaven, see the note under [Notes](#️-notes))
- 🎨 Syntax highlighting (Treesitter, `main` branch)
- 🧹 Format on save (autopep8 for Python, LSP formatting as fallback)
- 🔍 Linting & diagnostics (Ruff + Pyright), shown inline, in the sign column, and in Trouble
- 🗄️ SQL: vim-dadbod UI + table/column completion
- 📐 **4-space indentation in every language** (details [below](#-indentation))
- 🧠 Sensible defaults, no bloat

# No IDE cosplay. Just a sharp editor that minds its business.

---

## Requirements

Tested on **Neovim 0.12.6**.

| Need | Why |
| --- | --- |
| **Neovim 0.12+** | Treesitter `main` needs it. On 0.11 everything else works, Treesitter is skipped automatically. Below 0.11 this config won't work (native `vim.lsp.config`). |
| `git`, `curl`, `tar`, a C compiler (`gcc`/`clang`) | Plugin install, parser compilation |
| [`tree-sitter-cli`](https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md) **0.26.1+** | Builds Treesitter parsers. Install with your package manager, **not npm** |
| Node.js + npm | Mason installs pyright and the TypeScript server through npm |
| Python 3 + `ruff` + `autopep8` | Linter and formatter (they run from your `PATH`, Mason doesn't manage them) |
| A [Nerd Font](https://www.nerdfonts.com/) | Diagnostic icons |
| `make` (optional) | Builds LuaSnip's regex engine (nicer snippet transformations) |

Install the Python tools (pipx / uv keep modern distros happy about "externally managed" Python):

```bash
pipx install ruff
pipx install autopep8
# or: pip3 install ruff autopep8
```

> ruff → fast linter & diagnostics
> autopep8 → formatter

---

## Installation

1️⃣ Move your old Neovim config out of the way

```bash
mv ~/.config/nvim ~/.config/nvim.bak
```

(Clean slate. Delete the backup later if you're feeling brave.)

---

2️⃣ Clone the config straight into place

```bash
git clone https://github.com/Haashiraaa/neovim-config.git ~/.config/nvim
```

---

3️⃣ Start Neovim

```bash
nvim
```

Neovim will:

- bootstrap lazy.nvim and install every plugin at the versions in `lazy-lock.json`
- have Mason install pyright, ts_ls and lua_ls
- compile the Treesitter parsers (python, lua, vim, sql)

Let it cook. First launch takes a minute or two. If something looks half-done, restart once.

---

4️⃣ (Optional) Check everything is healthy

```
:checkhealth
```

---

5️⃣ (Optional) Update plugins later

Inside Neovim:

```
:Lazy update
```

Commit the new `lazy-lock.json` afterwards so every machine gets the same versions.
(`:Lazy restore` puts a machine back on the locked versions.)

---

## ⌨️ Keymaps

Leader is `\` (Neovim's default).

| Key | Mode | What it does |
| --- | --- | --- |
| `F12` | normal | Save and run the current file with `python3` |
| `\e` | normal | Show the diagnostic under the cursor |
| `\xx` | normal | Toggle the Trouble diagnostics list |
| `gd` | normal | Go to definition (LSP) |
| `K` | normal | Hover docs (LSP) |
| `\rn` | normal | Rename symbol (LSP) |
| `\ca` | normal | Code actions (LSP) |
| `[d` / `]d` | normal | Previous / next diagnostic |
| `Tab` / `Shift-Tab` | insert | Next / previous completion item, or jump through snippet fields |
| `Enter` | insert | Confirm the selected completion |
| `Ctrl-Space` | insert | Open the completion menu |
| `Alt-Space` | insert | Accept the AI suggestion |
| `Alt-]` / `Alt-[` | insert | Next / previous AI suggestion |

Also included: `vim-eunuch` (`:Rename`, `:Move`, `:Delete`, `:Chmod`, ...) and `:DBUI` for databases.

---

## 📐 Indentation

Every language indents with **4 spaces**. It lives in `lua/indent.lua`.

Neovim's built-in filetype plugins love to override your settings per language (8-wide tabs for Lua/JS/JSON, 2 spaces for YAML/Ruby, ...), so setting `shiftwidth` once isn't enough. This config sets 4-space defaults **and** re-applies them after the filetype plugins run.

The rules:

- **Spaces, width 4** for everything.
- **Real tabs, shown 4 wide** for formats that require tabs: `make`, `go`, `gomod`, `gowork`.
- **Help, man and plugin windows** are left alone (help text is laid out on 8-column tabs).
- **A project's `.editorconfig` wins** when it sets `indent_style`, `indent_size` or `tab_width`, so shared repos keep their own rules. Want 4 everywhere regardless? Add `vim.g.editorconfig = false` to `lua/options.lua`.
- Want a different width? Change `WIDTH` at the top of `lua/indent.lua`.

Formatters follow along: LSP formatting uses the buffer's `shiftwidth`, and autopep8 is 4 by default.

---

## 🧩 Adding a language

Everything is plain Lua in `lua/plugins/`:

| File | What to touch |
| --- | --- |
| `lsp.lua` | Add the server to `ensure_installed` and to `vim.lsp.enable({ ... })`, optional settings via `vim.lsp.config("name", { ... })` |
| `conform.lua` | `formatters_by_ft = { rust = { "rustfmt" } }` |
| `lint.lua` | `linters_by_ft = { ... }` |
| `treesitter.lua` | Add the parser name to the `parsers` list |

---

## 🧪 What this setup is good for

- Writing Python without fighting your editor
- Seeing errors before you run the code
- Clean formatting without thinking about it
- Getting AI help inside the editor
- Coding on low-spec machines

---

## 🤔 Why Neovim?

Why should you use Neovim, you ask?

Because it's fast, keyboard-first, and doesn't treat you like a toddler.
And now, thanks to this config, you don't have to set it up yourself.

You're welcome.

---

## ⚠️ Notes

- This config is opinionated. Fork and tweak, that's the point.
- **Pyright runs in `strict` mode.** It's loud. Set `typeCheckingMode = "basic"` in `lua/plugins/lsp.lua` if you want peace.
- **Supermaven is being sunset.** The standalone product was shut down after Cursor acquired it; existing Neovim users reportedly keep free completions, but new accounts can't be created. If it stops working for you, swap `lua/plugins/ai.lua` for another completion plugin.
- **Treesitter shows a warning at startup?** `tree-sitter-cli` isn't on your `PATH` (see Requirements). Highlighting for Lua/Vim/Markdown still works through Neovim's bundled parsers.
- **Mason on Termux / non-glibc systems:** Mason's prebuilt binaries (e.g. lua-language-server) usually won't run there. Install those servers with your package manager and remove them from `ensure_installed`.
- Treesitter-based *indenting* is intentionally off (still experimental upstream); Neovim's built-in indent rules handle it. There's a one-line opt-in in `lua/plugins/treesitter.lua`.
- If something breaks, it's probably because Neovim updated again (classic). `:Lazy restore` and `:checkhealth` are your friends.
