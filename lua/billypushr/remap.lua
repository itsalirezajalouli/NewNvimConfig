-- Setting leader
vim.g.mapleader = " "

-- For file exploration
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- Moving multiple lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

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
