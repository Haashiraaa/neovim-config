

## Neovim Configuration (Batteries Included)

This repository contains my personal Neovim configuration, pre-wired so you don’t have to suffer through hours of setup.

It focuses on Python development, but it’s clean and extendable for other languages too.

✨ What you get out of the box

⚡ Smart auto-completion (LSP + CMP)

🤖 AI-powered inline suggestions

🎨 Syntax highlighting (Treesitter)

🧹 Code formatting (autopep8)

🔍 Linting & diagnostics (Ruff)

🚨 Real-time error & warning hints

🧠 Sensible defaults, no bloat


# No IDE cosplay. Just a sharp editor that minds its business.


---

## Requirements

Before installing, make sure you have:

Neovim ≥ 0.9 (0.10+ recommended)

Python 3

pip3


Install required Python tools:

```bash
pip3 install neovim autopep8 ruff```


---

## Installation

1️⃣ Remove old Neovim config (important)

```bash
cd ~/.config
rm -rf nvim
```
(Yes. Nuke it. Clean slate.)


---

2️⃣ Clone the config

```bash
git clone https://github.com/Haashiraaa/neovim-config.git
```


---

3️⃣ Move files into Neovim config directory

```bash
mkdir -p ~/.config/nvim
cp nvim-config/init.lua ~/.config/nvim
cp nvim-config/lazy-lock.json ~/.config/nvim
cp -r nvim-config/lua ~/.config/nvim
```

---

4️⃣ Start Neovim

nvim

Neovim will:

install all plugins via lazy.nvim

set up LSP, completion, AI suggestions, formatter, and linter


Let it cook. First launch takes a minute.


---

5️⃣ (Optional) Update plugins later

Inside Neovim:

```bash
:Lazy update
```


---

🧪 What this setup is good for

Writing Python without fighting your editor

Seeing errors before you run the code

Clean formatting without thinking about it

Getting AI help inside the editor

Coding on low-spec machines (yes, even phones)



---

🤔 Why Neovim?

Why should you use Neovim, you ask?

Because it’s fast, keyboard-first, and doesn’t treat you like a toddler.
And now, thanks to this config, you don’t have to set it up yourself.

You’re welcome.


---

⚠️ Notes

This config is opinionated.

If something breaks, it’s probably because Neovim updated again (classic).

Feel free to fork and tweak — that’s the point.




