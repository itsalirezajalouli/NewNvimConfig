local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<leader>m", ui.toggle_quick_menu)

vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) vim.cmd('write') end)
vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) vim.cmd('write') end)
vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) vim.cmd('write') end)
vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) vim.cmd('write') end)
vim.keymap.set("n", "<leader>5", function() ui.nav_file(5) vim.cmd('write') end)
vim.keymap.set("n", "<leader>6", function() ui.nav_file(6) vim.cmd('write') end)
vim.keymap.set("n", "<leader>7", function() ui.nav_file(7) vim.cmd('write') end)
vim.keymap.set("n", "<leader>8", function() ui.nav_file(8) vim.cmd('write') end)
vim.keymap.set("n", "<leader>9", function() ui.nav_file(9) vim.cmd('write') end)
vim.keymap.set("n", "<leader>0", function() ui.nav_file(10) vim.cmd('write') end)

