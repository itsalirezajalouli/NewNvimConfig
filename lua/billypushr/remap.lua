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


keymap('i', '_', '-', opts)
keymap('i', '-', '_', opts)
keymap('i', ':', ';', opts)
keymap('n', ':', ';', opts)
keymap('i', ';', ':', opts)
keymap('n', ';', ':', opts)

-- Show signature help when '9' (mapped to '(') is typed
vim.keymap.set('i', '9', function()
  -- Insert the '(' character
  vim.api.nvim_feedkeys('(', 'n', false)
  -- Call signature help after a short delay to ensure the LSP server responds to the new context
  vim.defer_fn(function()
    vim.lsp.buf.signature_help()
  end, 1)
end, { noremap = true, silent = true })

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
