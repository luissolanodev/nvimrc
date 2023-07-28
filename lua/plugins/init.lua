return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use {
        'neovim/nvim-lspconfig',
        config = function() require('plugins.lspconfig') end
    }
    use {
        'nvim-tree/nvim-tree.lua',
        config = function() require('plugins.tree') end
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        config = function() require('plugins.treesitter') end
    }
    use 'gpanders/editorconfig.nvim'
    use {'hrsh7th/nvim-cmp', config = function() require('plugins.cmp') end}
    use {
        'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-path', 'hrsh7th/cmp-buffer'
    }
    use {
        'akinsho/bufferline.nvim',
        tag = 'v3.*',
        after = 'rose-pine',
        requires = 'nvim-tree/nvim-web-devicons',
        config = function() require('plugins.bufferline') end
    }
    use {
        'L3MON4D3/LuaSnip',
        tag = 'v1.*',
        config = function() require('plugins.luasnip') end
    }
    use 'rafamadriz/friendly-snippets'
    use {
        'nvim-lualine/lualine.nvim',
        config = function() require('plugins.lualine') end
    }
    use {
        'windwp/nvim-autopairs',
        config = function() require('plugins.autopairs') end
    }
    use {
        'lukas-reineke/indent-blankline.nvim',
        tag = 'v2.20.7',
        config = function() require('plugins.blankline') end
    }
    use {
        'famiu/bufdelete.nvim',
        config = function() require('plugins.bufdelete') end
    }
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.x',
        requires = {{'nvim-lua/plenary.nvim'}},
        config = function() require('plugins.telescope') end
    }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
    use {
        'brenoprata10/nvim-highlight-colors',
        config = function() require('plugins.highlightcolors') end
    }
    use 'windwp/nvim-ts-autotag'
    use {
        'lewis6991/gitsigns.nvim',
        config = function() require('plugins.gitsigns') end
    }
    use {
        'SmiteshP/nvim-navic',
        requires = 'neovim/nvim-lspconfig',
        config = function() require('plugins.navic') end
    }
    use 'JoosepAlviste/nvim-ts-context-commentstring'

    use {
        'numToStr/Comment.nvim',
        config = function() require('plugins.comment') end
    }
    --
    use {
        'LudoPinelli/comment-box.nvim',
        config = function() require('plugins.commentbox') end
    }

    use 'onsails/lspkind.nvim'

    use {
        'jose-elias-alvarez/null-ls.nvim',
        requires = {{'nvim-lua/plenary.nvim'}}
    }

    use {
        "folke/zen-mode.nvim",
        config = function() require("plugins.zenmode") end
    }

    use {
        "catppuccin/nvim",
        as = "catppuccin",
        config = function() require('plugins.catppuccin') end
    }

    use {
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function() require('plugins.rosepine') end
    }

    use {
        'tiagovla/tokyodark.nvim',
        config = function() require('plugins.tokyodark') end
    }

    use {
        'folke/tokyonight.nvim',
        config = function() require('plugins.tokyonight') end
    }
end)
