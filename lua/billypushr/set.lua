vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes" 
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- Function to split long lines at appropriate points
vim.api.nvim_exec([[
function! SplitLongLine()
    " Get the current line
    let line = getline('.')
    let col = virtcol('$')
    
    " Only proceed if line is longer than colorcolumn
    if col <= 80
        return
    endif
    
    " Check if line contains comma (for parameter lists, etc.)
    if line =~ ','
        " Find the last comma before column 80
        let parts = split(line, ',')
        let current_length = 0
        let split_index = 0
        
        for i in range(len(parts))
            let part_length = len(parts[i]) + 1  " +1 for the comma
            if current_length + part_length > 80
                break
            endif
            let current_length += part_length
            let split_index = i
        endfor
        
        " Create the split lines
        let first_line = join(parts[0:split_index], ',') . ','
        let second_line = join(parts[split_index+1:], ',')
        
        " Replace the current line with the split lines
        call setline('.', first_line)
        call append('.', substitute(second_line, '^\s*', repeat(' ', indent('.')), ''))
    
    " Check if line contains logical operators (and, or)
    elseif line =~ '\<and\>\|\<or\>'
        " Find the last logical operator before column 80
        let pos = 0
        let last_op_pos = -1
        while pos < 80
            let and_pos = match(line, '\<and\>', pos)
            let or_pos = match(line, '\<or\>', pos)
            
            if and_pos != -1 && and_pos < 80
                let last_op_pos = and_pos
                let pos = and_pos + 1
            elseif or_pos != -1 && or_pos < 80
                let last_op_pos = or_pos
                let pos = or_pos + 1
            else
                break
            endif
        endwhile
        
        if last_op_pos != -1
            " Split at the operator and add continuation character
            let first_line = strpart(line, 0, last_op_pos) . ' \'
            let second_line = repeat(' ', indent('.')) . strpart(line, last_op_pos)
            
            " Replace the current line with the split lines
            call setline('.', first_line)
            call append('.', second_line)
        endif
    endif
endfunction

" Key mapping for the function (using <leader>s)
nnoremap <leader>s :call SplitLongLine()<CR>
]], true)

-- Set colorcolumn
vim.opt.colorcolumn = "80"
