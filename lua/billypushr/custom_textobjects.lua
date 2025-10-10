-- Custom text objects for remapped keys
-- Save this as ~/.config/nvim/lua/custom_textobjects.lua

local M = {}

-- Setup function to create custom text object mappings
function M.setup(opts)
  opts = opts or {}
  
  -- Default key remappings - modify this to match your actual remappings
  local key_remappings = opts.key_remappings or {
    ["9"] = "(",  -- 9 should behave like (
    ["0"] = ")",  -- 0 should behave like )
    ["{"] = "[",  -- { should behave like [
    ["}"] = "]",  -- } should behave like ]
    -- Add more mappings as needed
  }
  
  -- Text object operators to map
  local operators = { "d", "y", "c", "v" }  -- delete, yank, change, select
  local scopes = { "i", "a" }               -- inner, around
  
  -- Create mappings for each combination
  for remapped_key, original_key in pairs(key_remappings) do
    for _, operator in ipairs(operators) do
      for _, scope in ipairs(scopes) do
        local new_mapping = operator .. scope .. remapped_key
        local original_mapping = operator .. scope .. original_key
        
        -- Create the keymap
        vim.keymap.set("n", new_mapping, original_mapping, {
          noremap = false,  -- Allow remapping to the original
          silent = true,
          desc = string.format("%s %s %s (remapped from %s)", 
            operator == "d" and "Delete" or 
            operator == "y" and "Yank" or 
            operator == "c" and "Change" or "Select",
            scope == "i" and "inside" or "around",
            remapped_key,
            original_key
          )
        })
        
        -- For visual mode as well
        vim.keymap.set("x", scope .. remapped_key, scope .. original_key, {
          noremap = false,
          silent = true,
          desc = string.format("Select %s %s (remapped)", 
            scope == "i" and "inside" or "around", remapped_key)
        })
      end
    end
  end
  
  -- Also create operator-pending mode mappings (for when you just press the text object)
  for remapped_key, original_key in pairs(key_remappings) do
    for _, scope in ipairs(scopes) do
      vim.keymap.set("o", scope .. remapped_key, scope .. original_key, {
        noremap = false,
        silent = true,
        desc = string.format("Text object: %s %s", scope, remapped_key)
      })
    end
  end
end

return M
