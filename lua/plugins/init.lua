return require("packer").startup(function()
   use("wbthomason/packer.nvim")

   ------------------ Editor ------------------
   use {
      {
         "neovim/nvim-lspconfig",
         config = function()
            require("plugins.lspconfig")
         end
      },
      -- {
         -- "glepnir/lspsaga.nvim",
         -- config = function()
            -- require("plugins.lspsaga")
         -- end
      -- },
      {
         "onsails/lspkind-nvim",
         config = function()
            require("plugins.lspkind")
         end
      },
      "kabouzeid/nvim-lspinstall",
   }

   use {
      {
         "hrsh7th/nvim-compe",
         config = function()
            require("plugins.compe")
         end
      },
      {
         "L3MON4D3/LuaSnip",
         config = function()
            require("plugins.luasnip")
         end
      },
      "rafamadriz/friendly-snippets",
   }
   use {
      {
         "nvim-treesitter/nvim-treesitter",
         config = function()
            require("plugins.treesitter")
         end
      },
      "windwp/nvim-ts-autotag",
      "p00f/nvim-ts-rainbow",
   }
   use {
      "windwp/nvim-autopairs",
      config = function()
         require("plugins.autopairs")
      end
   }
   use("editorconfig/editorconfig-vim")

   --------------- Miscellaneous ---------------

   use("kyazdani42/nvim-web-devicons")
   use {
      "kyazdani42/nvim-tree.lua",
      config = function()
         require("plugins.nvimtree")
      end
   }
   use {
      "akinsho/nvim-bufferline.lua",
      config = function()
         require("plugins.bufferline")
      end
   }
   use {
      "hoob3rt/lualine.nvim",
      config = function()
         require("plugins.lualine")
      end
   }
   use("yamatsum/nvim-cursorline")
   use {
      "folke/zen-mode.nvim",
      config = function()
         require("plugins.zenmode")
      end
   }
   use {
      "folke/twilight.nvim",
      config = function()
         require("twilight").setup()
      end
   }
   use {
      "winston0410/commented.nvim",
      config = function()
         require("commented").setup()
      end
   }
   use("vhyrro/neorg")
   use {
      "lewis6991/gitsigns.nvim",
      config = function()
         require("plugins.gitsigns")
      end
   }
   use {
      "lukas-reineke/indent-blankline.nvim",
      config = function()
         require("plugins.blankline")
      end
   }
   use("norcalli/nvim-colorizer.lua")
   use("jbyuki/venn.nvim")
   use("famiu/bufdelete.nvim")
   -- use("code-biscuits/nvim-biscuits")
   use {
      "nvim-telescope/telescope.nvim",
      requires = {
         {"nvim-lua/popup.nvim"},
         {"nvim-lua/plenary.nvim"}
      },
      config = function()
         require("plugins.telescope")
      end
   }
   use("nvim-telescope/telescope-media-files.nvim")
   use("nvim-telescope/telescope-fzf-native.nvim")
   -- use {
      -- "folke/which-key.nvim",
      -- config = function()
         -- require("plugins.whichkey")
      -- end
   -- }


   ------------------ Colors ------------------
   use {
      "folke/tokyonight.nvim",
      config = function()
         require("plugins.tokyonight")
      end
   }
end)
