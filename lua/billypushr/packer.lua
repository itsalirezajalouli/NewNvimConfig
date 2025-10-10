--leader This file can be loaded by calling `lua require('lugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Telescope fuzzy finder
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Ros-pine theme
    use { 
        'rose-pine/neovim', 
        as = "rose-pine",
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    }

    -- Treesitter
    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    use('nvim-treesitter/playground')
    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')

    -- Zen mode
    use('folke/zen-mode.nvim')

    -- lsp
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},

            -- Comment api
            {'numToStr/Comment.nvim'}
        }
    }

    -- Markdown
    use {
        'MeanderingProgrammer/markdown.nvim',
        as = 'render-markdown', -- Optional alias
        after = { 'nvim-treesitter' }, -- Requires treesitter
        config = function()
            require('render-markdown').setup({
                checkbox = {
                    enabled = true,
                    unchecked = {
                        icon = '○',
                        highlight = 'RenderMarkdownUnchecked',
                    },
                    checked = {
                        icon = '●',
                        highlight = 'RenderMarkdownChecked',
                    },
                },
            })
        end,
    }
    -- Ruby-specific plugins (add these use statements)
    use 'vim-ruby/vim-ruby'
    use 'tpope/vim-endwise' -- Auto-adds 'end' in Ruby
    
end)

