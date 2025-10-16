-- Setting leader
vim.g.mapleader = " "

-- For file exploration
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- Moving multiple lines
vim.keymap.set("n", "<M-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<M-k>", ":m .-2<CR>==")
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv")

-- Stays in visual mode after tabing
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Append to previous line
vim.keymap.set("n", "J", "mzJ`z")

-- Jumping around
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set('n', 'gg', 'ggzz', { noremap = true })
vim.keymap.set('n', 'G', 'Gzz', { noremap = true })

-- Pasting without loosing the register to new thing
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Using the system's clipboard
-- Copying
vim.keymap.set("n", "y", "\"+y")
vim.keymap.set("v", "y", "\"+y")
vim.keymap.set("n", "Y", "\"+Y")
-- Cuting
vim.keymap.set("n", "d", "\"+d")
vim.keymap.set("v", "d", "\"+d")

-- Commenting
vim.keymap.set("n", "<leader>/", function()
    require("Comment.api").toggle.linewise.current()
end)
vim.keymap.set("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")

-- Open terminal in current file path
vim.keymap.set('n', '<leader>t', ':cd %:p:h<CR>:!', { noremap = true })

local opts = { noremap = true, silent = true }

-- Center screen when pressing Enter in insert mode
vim.api.nvim_set_keymap('i', '<CR>', '<CR><C-o>zz', opts)

-- Lua version for init.lua
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Map each shift + number to the corresponding number
keymap('i', '!', '1', opts)
keymap('i', '@', '2', opts)
keymap('i', '#', '3', opts)
keymap('i', '$', '4', opts)
keymap('i', '%', '5', opts)
keymap('i', '^', '6', opts)
keymap('i', '&', '7', opts)
keymap('i', '*', '8', opts)
keymap('i', '(', '9', opts)
keymap('i', ')', '0', opts)

keymap('n', '!', '1', opts)
keymap('n', '@', '2', opts)
keymap('n', '#', '3', opts)
keymap('n', '$', '4', opts)
keymap('n', '%', '5', opts)
keymap('n', '^', '6', opts)
keymap('n', '&', '7', opts)
keymap('n', '*', '8', opts)
keymap('n', '(', '9', opts)
keymap('n', ')', '0', opts)
keymap('n', 'r', 'R', opts)
keymap('n', 'R', 'r', opts)

-- Map the normal number keys to behave normally
keymap('i', '1', '!', opts)
keymap('i', '2', '@', opts)
keymap('i', '3', '#', opts)
keymap('i', '4', '$', opts)
keymap('i', '5', '%', opts)
keymap('i', '6', '^', opts)
keymap('i', '7', '&', opts)
keymap('i', '8', '*', opts)
keymap('i', '9', '(', opts)
keymap('i', '0', ')', opts)

keymap('n', '1', '!', opts)
keymap('n', '2', '@', opts)
keymap('n', '3', '#', opts)
keymap('n', '4', '$', opts)
keymap('n', '5', '%', opts)
keymap('n', '6', '^', opts)
keymap('n', '7', '&', opts)
keymap('n', '8', '*', opts)
keymap('n', '9', '(', opts)
keymap('n', '0', ')', opts)
keymap('n', '(', '9', opts)
keymap('n', ')', '0', opts)

keymap('i', '-', '_', opts)
keymap('i', '_', '-', opts)
keymap('i', ':', '@', opts)
keymap('i', '2', ':', opts)
-- keymap('i', ':', ';', opts)
-- keymap('i', ';', ':', opts)
keymap('n', ':', ';', opts)
keymap('n', ';', ':', opts)

-- Show signature help when '9' (mapped to '(') is typed AND handle auto-pairing
vim.keymap.set('i', '9', function()
  -- Insert the '()' pair and position cursor between them
  local keys = vim.api.nvim_replace_termcodes('()<Left>', true, false, true)
  vim.api.nvim_feedkeys(keys, 'n', false)
  -- Call signature help after a short delay to ensure the LSP server responds to the new context
  vim.defer_fn(function()
    vim.lsp.buf.signature_help()
  end, 1)
end, { noremap = true, silent = true })

-- Also make sure Shift+9 gives you the actual number 9
vim.keymap.set('i', '(', '9', { noremap = true, silent = true })
vim.keymap.set('i', '[', '{', { noremap = true, silent = true })

-- Show signature help when ',' is typed or right after it
vim.api.nvim_create_autocmd("InsertCharPre", {
  pattern = "*",
  callback = function()
    local prev_char = vim.fn.getline('.'):sub(vim.fn.col('.') - 1, vim.fn.col('.') - 1)
    if vim.v.char == ',' or prev_char == ',' then
      vim.defer_fn(function()
        vim.lsp.buf.signature_help()
      end, 1)
    end
  end,
})
-- Simple auto-pairing configuration
local opts = { noremap = true, silent = true }

-- Function to handle auto-pairing with cursor positioning
local function autopair(open, close)
  return function()
    local keys = vim.api.nvim_replace_termcodes(open .. close .. '<Left>', true, false, true)
    vim.api.nvim_feedkeys(keys, 'n', false)
  end
end

-- Function to handle smart closing (skip if next char is the closing pair)
local function smart_close(char)
  return function()
    local col = vim.fn.col('.')
    local line = vim.fn.getline('.')
    local next_char = line:sub(col, col)
    
    if next_char == char then
      -- Skip the existing closing character
      local keys = vim.api.nvim_replace_termcodes('<Right>', true, false, true)
      vim.api.nvim_feedkeys(keys, 'n', false)
    else
      -- Insert the character normally
      local keys = vim.api.nvim_replace_termcodes(char, true, false, true)
      vim.api.nvim_feedkeys(keys, 'n', false)
    end
  end
end

-- Replace { with [ and } with ]
vim.keymap.set('i', '{', '[', opts)
vim.keymap.set('i', '}', ']', opts)

-- Auto-pairing for brackets (using the original keys)
vim.keymap.set('i', '{', autopair('[', ']'), opts)
vim.keymap.set('i', '[', autopair('{', '}'), opts)
vim.keymap.set('i', '<', autopair('<', '>'), opts)
vim.keymap.set('i', '5', autopair('%', '%'), opts)
vim.keymap.set('i', '}', smart_close(']'), opts)
vim.keymap.set('i', ']', smart_close('}'), opts)

-- Auto-pairing for quotes
vim.keymap.set('i', '"', function()
  local keys = vim.api.nvim_replace_termcodes('"",<Left><Left>', true, false, true)
  vim.api.nvim_feedkeys(keys, 'n', false)
end, opts)

vim.keymap.set('i', "'", function()
  local keys = vim.api.nvim_replace_termcodes("'',<Left><Left>", true, false, true)
  vim.api.nvim_feedkeys(keys, 'n', false)
end, opts)

-- Dev docs
vim.keymap.set('n', '<leader>dd', vim.cmd.DevdocsOpenCurrent,
                { noremap = true })
