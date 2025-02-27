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


