require('packer').startup(function(use)
   use 'wbthomason/packer.nvim'
----------------------------------------------------------------------
--                              EDITOR                              --
----------------------------------------------------------------------
   use {
      'neovim/nvim-lspconfig',
      config = function()
         require('plugins.lspconfig')
      end
   }

   use { "williamboman/mason.nvim" }
   use { 'williamboman/mason-lspconfig.nvim'}
   use('ray-x/lsp_signature.nvim')
   use {
      'hrsh7th/nvim-cmp',
      config = function()
         require('plugins.cmp')
      end
   }
   use('hrsh7th/cmp-buffer')
   use('hrsh7th/cmp-path')
   use('hrsh7th/cmp-calc')
   use('hrsh7th/cmp-nvim-lua')
   use('hrsh7th/cmp-nvim-lsp')
   use('hrsh7th/cmp-emoji')
   use('saadparwaiz1/cmp_luasnip')
   use('octaltree/cmp-look')
   use { 'tzachar/cmp-tabnine', run = './install.sh' }
   use {
      'L3MON4D3/LuaSnip',
      config = function()
         require('plugins.luasnip')
      end

   }
   use('rafamadriz/friendly-snippets')
   use {
      'nvim-treesitter/nvim-treesitter',
      config = function()
         require('plugins.treesitter')
      end
   }
   use {
      'windwp/nvim-ts-autotag',
      requires = 'nvim-treesitter/nvim-treesitter'
   }
   use {
      'p00f/nvim-ts-rainbow',
      requires = 'nvim-treesitter/nvim-treesitter'
   }
   use {
      'windwp/nvim-autopairs',
      config = function()
         require('plugins.autopairs')
      end
   }
   use 'editorconfig/editorconfig-vim'
----------------------------------------------------------------------
--                          MISCELLANEOUS                           --
----------------------------------------------------------------------
   use {
      'kyazdani42/nvim-web-devicons',
      config = function()
         require('plugins.devicons')
      end
   }
   use {
      'akinsho/bufferline.nvim',
      config = function()
         require('plugins.bufferline')
      end,
      requires = 'kyazdani42/nvim-web-devicons'
   }
   use {
      'kyazdani42/nvim-tree.lua',
      config = function()
         require('plugins.nvimtree')
      end
   }
   use {
      'nvim-lualine/lualine.nvim',
      config = function()
         require('plugins.lualine')
      end
   }
   use {
      'folke/zen-mode.nvim',
      config = function()
         require('plugins.zenmode')
      end
   }
   use {
      'folke/twilight.nvim',
      config = function()
         require('plugins.twilight')
      end
   }
   use {
      'winston0410/commented.nvim',
      config = function()
         require('plugins.commented')
      end
   }
   use {
      'lewis6991/gitsigns.nvim',
      config = function()
         require('plugins.gitsigns')
      end
   }
   use {
      'lukas-reineke/indent-blankline.nvim',
      config = function()
         require('plugins.blankline')
      end
   }
   use{
      'norcalli/nvim-colorizer.lua',
      config = function()
         require('plugins.colorizer')
      end
   }
   use {
      'famiu/bufdelete.nvim',
      config = function()
         require('plugins.bufdelete')
      end
   }
   use {
      'nvim-telescope/telescope.nvim',
      requires = {
         {'nvim-lua/popup.nvim'},
         {'nvim-lua/plenary.nvim'}
      },
      config = function()
         require('plugins.telescope')
      end
   }
   use {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make'
   }
   use 'nvim-telescope/telescope-media-files.nvim'
   use 'jvgrootveld/telescope-zoxide'
   use {
      'folke/trouble.nvim',
      requires = 'kyazdani42/nvim-web-devicons',
      config = function()
         require('plugins.trouble')
      end
   }
   use {
      'folke/todo-comments.nvim',
      requires = 'nvim-lua/plenary.nvim',
      config = function()
         require('plugins.todocomments')
      end
   }
   use {
      's1n7ax/nvim-comment-frame',
      config = function()
         require('plugins.commentframe')
      end,
      requires = 'treesitter/nvim-treesitter'
   }
   use {
      'michaelb/sniprun',
      config = function()
         require('plugins.sniprun')
      end,
      run = 'bash ./install.sh'
   }
----------------------------------------------------------------------
--                              COLORS                              --
----------------------------------------------------------------------
   use {
      'catppuccin/nvim',
      config = function()
         require('plugins.catppuccin')
      end,
   }
end)
