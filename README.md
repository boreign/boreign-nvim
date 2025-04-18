# Neovim Configuration with Lazy.nvim and Custom Helper View

Welcome to my Neovim configuration! 🚀 This setup is designed for productivity, featuring a modern plugin manager (`lazy.nvim`), a custom keybindings window (`helper-view`), and a sleek `catppuccin` theme. It’s ideal for Python development with `pyright` LSP, file navigation with `nvim-tree`, and fuzzy finding with `telescope`. The `<leader>` key is set to `;` for quick mappings like `;y` to yank to the system clipboard.

This guide explains how to install and use the config on **macOS** and **Linux**. Grab the files from this repo and get coding! 🎉

## Features
- **Plugin Manager**: `lazy.nvim` for fast plugin management.
- **File Explorer**: `nvim-tree` for easy navigation (`;t` to toggle).
- **LSP Support**: `pyright` for Python, `lua_ls` for Lua, `marksman` for Markdown.
- **Fuzzy Finder**: `telescope` for files (`;f`) and text search (`;g`).
- **Completion**: `nvim-cmp` for LSP-driven autocompletion.
- **Theme**: `catppuccin` (mocha flavor) for a modern look.
- **Custom Plugin**: `helper-view` shows keybindings in a floating window (`;hv` to toggle).
- **Clipboard**: `;y` yanks to the system clipboard (normal/visual modes).

## Prerequisites
Ensure you have:
- **Neovim**: Version 0.8.0+ (`brew install neovim` on macOS, `sudo apt-get install neovim` on Ubuntu).
- **Git**: For cloning `lazy.nvim` (`brew install git` or `sudo apt-get install git`).
- **Node.js/NPM**: For `pyright` LSP (`brew install node` or `sudo apt-get install nodejs npm`).
- **Python**: For `pyright` (`brew install python` or `sudo apt-get install python3`).
- **Clipboard Tools** (Linux only): `xclip` for X11 (`sudo apt-get install xclip`) or `wl-clipboard` for Wayland (`sudo apt-get install wl-clipboard`).

Install `pyright` globally:

```bash
npm install -g pyright
```

## Installation
Follow these steps to set up the configuration:

1. **Backup Existing Config**: If you have a Neovim config, back it up:
   
```bash
   mv ~/.config/nvim ~/.config/nvim.bak
```

3. **Create Config Directory**: Set up the Neovim configuration folder:

```bash
   mkdir -p ~/.config/nvim/lua/helper-view
```

4. **Copy `init.lua`**: Copy the `init.lua` from this repo to `~/.config/nvim/init.lua`. This configures `lazy.nvim`, plugins, LSPs, and key mappings.

5. **Copy `helper-view` Plugin**: Copy the `init.lua` from `lua/helper-view/` in this repo to `~/.config/nvim/lua/helper-view/init.lua`. This defines the custom keybindings window.

6. **Install Plugins**: Open Neovim and run:
   
   :Lazy sync
   
   This installs all plugins (`lazy.nvim`, `nvim-tree`, `catppuccin`, etc.) and loads the configuration.

## Usage
- **Toggle File Explorer**: `;t` to open/close `nvim-tree`.
- **Fuzzy Finding**: `;f` for files, `;g` for text search with `telescope`.
- **LSP Actions**: `;h` for hover documentation (e.g., in Python files).
- **Helper View**: `;hv` or `:HV` to toggle the keybindings window.
- **Clipboard**: `;y` to yank to the system clipboard (normal or visual mode).
- **Save/Quit**: `;w` to save, `;q` to quit.

## Notes
- **Pyright Path**: The `init.lua` assumes `pyright-langserver` is installed globally. If installed elsewhere (e.g., via `nvm`), update the `cmd` path in `init.lua`:
  
  cmd = { "/path/to/pyright-langserver", "--stdio" },
  
- **Linux Clipboard**: Ensure `xclip` (X11) or `wl-clipboard` (Wayland) is installed for `;y` to sync with the system clipboard. Check with `:checkhealth`.
- **Customization**: Edit `M.shortcuts` in `helper-view/init.lua` to add keybindings or adjust the window size/position.

## Preview

<img width="1509" alt="Captura de Tela 2025-04-18 às 09 23 06" src="https://github.com/user-attachments/assets/6380fc2e-32d2-49c3-8c6b-d0e217a12524" />


## Resources
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [Nvim-tree](https://github.com/nvim-tree/nvim-tree.lua)
- [Catppuccin](https://github.com/catppuccin/nvim)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [Fidget.nvim](https://github.com/j-hui/fidget.nvim)
- [Neovim LSP](https://github.com/neovim/nvim-lspconfig)

## Contributing
Found a bug or have a cool addition? Open an issue or PR! Let’s make this config even better. 🌟

## License
MIT License

---

Happy coding with Neovim! 🎉
