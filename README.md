# 📝 Neovim Configuration

Just sharing my Neovim configuration with mostly native Lua plugins. 

---

## ✨ Features

### 🔬 LaTeX-Ready (Skim Integration)
- Fully configured for LaTeX editing with `texlab`, `vimtex`, and `ltex-plus`
- Supports **forward/reverse PDF sync** with [Skim](https://skim-app.sourceforge.io/) on macOS
- Includes formatting via `latexindent` and spell/grammar checking via `ltex-plus`

### 🤖 GitHub Copilot Integration
- Seamless autocompletion from GitHub Copilot using `copilot.lua` and `nvim-cmp`
- Prioritized alongside LSP and snippet suggestions

### 🧠 Local AI with Ollama
- Generate text with local LLMs using `gen.lua` and [`Ollama`](https://ollama.com)
- Works offline; great for privacy-conscious workflows

### 🛠 LSP-Ready
- Built-in support for:
  - TypeScript (`tsserver`)
  - Python (`pyright`)
  - C/C++ (`clangd`)
  - HTML/CSS/JS
  - LaTeX & Markdown (`texlab`, `ltex-plus`)
  - Shell scripts, JSON, and more
- Powered by:
  - `nvim-lspconfig`
  - `mason.nvim` + `mason-lspconfig`
  - `cmp-nvim-lsp`, `LuaSnip`, `friendly-snippets`
  - `conform.nvim` for formatting
  - `fidget.nvim` for LSP progress

### 🧩 Plugin Highlights

| Plugin             | Purpose                            |
|--------------------|-------------------------------------|
| `fzf-lua`          | Blazing fast fuzzy finding          |
| `gitsigns.nvim`    | Git signs in gutter                 |
| `auto-session`     | Restore sessions effortlessly       |
| `comment.nvim`     | Fast comment toggling               |
| `lualine.nvim`     | Elegant statusline                  |
| `oil.nvim`         | File explorer in buffer             |
| `nvim-ts-autotag`  | Auto close HTML/JSX tags            |
| `outline.nvim`     | Symbols outline (like VSCode)       |
| `render-markdown`  | Better markdown rendering           |
| `vimtex`           | Advanced LaTeX workflow             |
| `treesitter`       | Syntax highlighting & folding       |
| `copilot.lua`      | GitHub Copilot integration          |
| `gen.lua`          | Ollama + AI generation integration  |

---

## 🛠 Installation

Place the `nvim` folder into your Neovim config directory:

```bash
~/.config/
```

### Option 1: Replace Existing Config

> ⚠️ This will override your current Neovim setup.

```bash
mv ~/.config/nvim ~/.config/nvim_backup   # (optional) backup old config
cp -r path/to/this/repo/nvim ~/.config/nvim
```

### Option 2: Keep Multiple Configs

1. Create a new config folder (e.g., `nvim2`):

   ```bash
   mkdir -p ~/.config/nvim2
   cp -r path/to/this/repo/nvim/* ~/.config/nvim2/
   ```

2. Add an alias to your shell config (`.bashrc` or `.zshrc`):

   ```bash
   alias nvim2='NVIM_APPNAME=nvim2 nvim'
   ```

3. Reload your shell or run:

   ```bash
   source ~/.zshrc  # or source ~/.bashrc
   ```

Now, run `nvim2` to launch Neovim using the alternate config 🎉

---

## 🛡 License

This project is licensed under the [MIT License](LICENSE).
