require("zen-mode").setup({
  window = {
    backdrop = 0.4,
    width = 86, -- width of the zen window
    height = 1, -- height of the zen window
    options = {
      signcolumn = "no", -- disable signcolumn
      number = true, -- disable number column
      relativenumber = true, -- disable relative numbers
      cursorline = true, -- disable cursorline
      cursorcolumn = false, -- disable cursor column
      foldcolumn = "0", -- disable fold column
      list = false, -- disable whitespace characters
    },
  },
  plugins = {
    -- disable some global vim options (vim.o...)
    options = {
      enabled = true,
      ruler = true, -- disables the ruler text in the cmd line area
      showcmd = true, -- disables the command in the last line
    },
    twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
    gitsigns = { enabled = false }, -- disables git signs
    tmux = { enabled = false }, -- disables the tmux statusline
  },
})
vim.keymap.set('n', '<leader>z', ':ZenMode<CR> :lua ColorMyPencils()<CR>', { silent = true })
