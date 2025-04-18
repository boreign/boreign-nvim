local M = {}

-- State
M.buf = nil
M.win = nil
M.shortcuts = {
  "<leader>t: Toggle Nvim-tree",
  "<leader>h: LSP Hover",
  "<leader>w: Save File",
  "<leader>q: Quit",
  "<leader>f: Find Files",
  "<leader>g: Live Grep",
  "<leader>y: Yank to Clipboard",
}

-- Create floating window
function M.create_window()
  if M.buf and vim.api.nvim_buf_is_valid(M.buf) then
    return
  end
  M.buf = vim.api.nvim_create_buf(false, true)
  local width = 30
  local height = #M.shortcuts + 2
  local opts = {
    style = "minimal",
    relative = "editor",
    width = width,
    height = height,
    row = vim.o.lines - height - 2,
    col = vim.o.columns - width - 5,
    border = "rounded",
    zindex = 50,
  }
  M.win = vim.api.nvim_open_win(M.buf, false, opts)
  vim.api.nvim_buf_set_option(M.buf, "modifiable", false)
  local lines = { "Keybindings:" }
  for _, shortcut in ipairs(M.shortcuts) do
    table.insert(lines, "  " .. shortcut)
  end
  vim.api.nvim_buf_set_lines(M.buf, 0, -1, false, lines)
end

-- Toggle helper view
function M.toggle()
  if M.win and vim.api.nvim_win_is_valid(M.win) then
    vim.api.nvim_win_close(M.win, true)
    if M.buf and vim.api.nvim_buf_is_valid(M.buf) then
      vim.api.nvim_buf_delete(M.buf, { force = true })
    end
    M.buf = nil
    M.win = nil
  else
    local filetype = vim.bo.filetype
    if filetype ~= "NvimTree" and filetype ~= "TelescopePrompt" then
      M.create_window()
    end
  end
end

-- Manage visibility
vim.api.nvim_create_autocmd({ "VimResized", "WinEnter", "BufEnter" }, {
  callback = function()
    local filetype = vim.bo.filetype
    if M.win and vim.api.nvim_win_is_valid(M.win) then
      if filetype == "NvimTree" or filetype == "TelescopePrompt" then
        vim.api.nvim_win_close(M.win, true)
        M.win = nil
        M.buf = nil
      else
        local width = 30
        local height = #M.shortcuts + 2
        vim.api.nvim_win_set_config(M.win, {
          relative = "editor",
          width = width,
          height = height,
          row = vim.o.lines - height - 2,
          col = vim.o.columns - width - 5,
        })
      end
    elseif filetype ~= "NvimTree" and filetype ~= "TelescopePrompt" then
      vim.defer_fn(M.create_window, 100)
    end
  end,
})

-- Setup keybindings and styling
function M.setup()
  vim.keymap.set("n", "<leader>hv", M.toggle, { noremap = true, silent = true, desc = "Toggle Helper View" })
  vim.api.nvim_set_hl(0, "FloatBorder", { link = "CatppuccinMochaOverlay0" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  vim.defer_fn(function()
    local filetype = vim.bo.filetype
    if filetype ~= "NvimTree" and filetype ~= "TelescopePrompt" then
      M.create_window()
    end
  end, 100)
end

return M
