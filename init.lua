-- Set <leader> key to semicolon
vim.g.mapleader = ";"
vim.g.maplocalleader = ","

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.wrap = true
vim.opt.termguicolors = true
vim.opt.textwidth = 80
vim.opt.colorcolumn = "81"
vim.opt.formatoptions = "tcq"

-- Bootstrap lazy.nvim
local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazy_path) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazy_path })
end
vim.opt.rtp:prepend(lazy_path)

-- Plugins
require("lazy").setup({
  { "nvim-tree/nvim-tree.lua", opts = { view = { width = 30 } } },
  { "catppuccin/nvim", name = "catppuccin", config = function() require("catppuccin").setup({ flavour = "mocha" }) vim.cmd.colorscheme "catppuccin-mocha" end },
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  { "j-hui/fidget.nvim", opts = { progress = { display = { done_icon = "✓" } } } },
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "bbm/helper-view", dir = vim.fn.stdpath("config") .. "/lua/helper-view", module = "helper-view", lazy = false, config = function() require("helper-view").setup() end },
})

-- Fallback mapping for helper-view
vim.keymap.set("n", "<leader>hv", function() require("helper-view").toggle() end, { noremap = true, silent = true, desc = "Toggle Helper View" })
vim.api.nvim_create_user_command("HV", function() require("helper-view").toggle() end, { desc = "Toggle Helper View" })

-- Optional: Keybindings for flavor switching
vim.keymap.set('n', '<leader>tm', ':colorscheme catppuccin-mocha<CR>', { desc = 'Catppuccin Mocha' })
vim.keymap.set('n', '<leader>tl', ':colorscheme catppuccin-latte<CR>', { desc = 'Catppuccin Latte' })
vim.keymap.set('n', '<leader>tf', ':colorscheme catppuccin-frappe<CR>', { desc = 'Catppuccin Frappe' })
vim.keymap.set('n', '<leader>tc', ':colorscheme catppuccin-macchiato<CR>', { desc = 'Catppuccin Macchiato' })

-- LSPs
require("lspconfig").pyright.setup {
  cmd = { "pyright-langserver", "--stdio" },
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
}
require("lspconfig").lua_ls.setup { settings = { Lua = { diagnostics = { globals = { "vim" } } } } }
require("lspconfig").marksman.setup { root_dir = function() return vim.fn.getcwd() end }

-- Plugin setups
require("nvim-tree").setup()
require("telescope").setup()
require("cmp").setup {
  sources = { { name = "nvim_lsp" } },
  mapping = {
    ["<Tab>"] = require("cmp").mapping.select_next_item(),
    ["<S-Tab>"] = require("cmp").mapping.select_prev_item(),
    ["<CR>"] = require("cmp").mapping.confirm({ select = true }),
  },
}

-- Keymaps
vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, { desc = "Show LSP hover" })
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>t", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })
vim.keymap.set("n", "<leader>f", ":Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>g", ":Telescope live_grep<CR>", { desc = "Search text" })
vim.keymap.set("n", "<leader>y", '"+y', { noremap = true, silent = true, desc = "Yank to system clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { noremap = true, silent = true, desc = "Yank to system clipboard" })
vim.keymap.set("n", "j", "gj", { desc = "Move down wrapped lines" })
vim.keymap.set("n", "k", "gk", { desc = "Move up wrapped lines" })
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', { desc = 'Find Files' })
vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<CR>', { desc = 'Live Grep' })
vim.keymap.set('n', '<leader>fb', ':Telescope buffers<CR>', { desc = 'Buffers' })
vim.keymap.set('n', '<leader>gf', ':Telescope git_files<CR>', { desc = 'Git Files' })
