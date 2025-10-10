-- Character horizontal movement functions
local function move_char_left()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  
  -- Check if we're at the beginning of the line or line is empty
  if col == 0 or #line == 0 then
    return
  end
  
  -- Convert to 1-based indexing for string operations
  local pos = col + 1
  
  -- Check if we're at the second character (can't move first char left)
  if pos == 1 then
    return
  end
  
  -- Get characters to swap
  local chars = {}
  for i = 1, #line do
    chars[i] = line:sub(i, i)
  end
  
  -- Swap current character with the one to its left
  chars[pos], chars[pos - 1] = chars[pos - 1], chars[pos]
  
  -- Reconstruct the line
  local new_line = table.concat(chars)
  
  -- Update the line
  vim.api.nvim_set_current_line(new_line)
  
  -- Move cursor left to follow the character
  vim.api.nvim_win_set_cursor(0, {row, col - 1})
end

local function move_char_right()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  
  -- Check if line is empty
  if #line == 0 then
    return
  end
  
  -- Convert to 1-based indexing for string operations
  local pos = col + 1
  
  -- Check if we're at the last character (can't move right)
  if pos >= #line then
    return
  end
  
  -- Get characters to swap
  local chars = {}
  for i = 1, #line do
    chars[i] = line:sub(i, i)
  end
  
  -- Swap current character with the one to its right
  chars[pos], chars[pos + 1] = chars[pos + 1], chars[pos]
  
  -- Reconstruct the line
  local new_line = table.concat(chars)
  
  -- Update the line
  vim.api.nvim_set_current_line(new_line)
  
  -- Move cursor right to follow the character
  vim.api.nvim_win_set_cursor(0, {row, col + 1})
end

-- Set up the keybindings
vim.keymap.set('n', '<A-h>', move_char_left, { desc = 'Move character left' })
vim.keymap.set('n', '<A-l>', move_char_right, { desc = 'Move character right' })

-- Optional: Also work in insert mode
vim.keymap.set('i', '<A-h>', function()
  move_char_left()
end, { desc = 'Move character left (insert mode)' })

vim.keymap.set('i', '<A-l>', function()
  move_char_right()
end, { desc = 'Move character right (insert mode)' })

