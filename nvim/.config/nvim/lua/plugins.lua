-- bootstrapping packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end


local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local packer_config = {
  display = {
    open_fn = require("packer.util").float,
  }
}

local function packer_startup()
  use 'wbthomason/packer.nvim'

  -- LSP
  use {
    "williamboman/mason.nvim",
  }
  use {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("plugins.mason-lspconfig")
    end
  }
  use {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.lspconfig")
    end
  }

  use({
    "hrsh7th/nvim-cmp",
    -- Sources for nvim-cmp
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function() require('plugins.cmp') end,
  })

  use {
    "ray-x/lsp_signature.nvim",
  }

  use {
    "zbirenbaum/copilot.lua",
    -- event = { "VimEnter" },
    config = function()
      -- vim.defer_fn(function()
      --   require("copilot").setup {
      --     plugin_manager_path = os.getenv "LUNARVIM_RUNTIME_DIR" .. "/site/pack/packer",
      --   }
      -- end, 100)
      require("copilot").setup({
        panel = {
          auto_refresh = false,
          keymap = {
            accept = "<CR>",
            jump_prev = "[[",
            jump_next = "]]",
            refresh = "gr",
            open = "<M-CR>",
          },
        },
        suggestion = {
          auto_trigger = true,
          keymap = {
            accept = "<M-l>",
            prev = "<M-[>",
            next = "<M-]>",
            dismiss = "<C-]>",
          },
        },
      })
    end,
  }


  -- Trouble
  use {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end
  }

  -- Treesitter
  use({
    'nvim-treesitter/nvim-treesitter',
    -- config = function() require('plugins.treesitter') end,
    run = ':TSUpdate'
  })

  -- Telescope
  use({
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } },
    config = function() require('plugins.telescope') end,
  })

  use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })

  -- Autopairs
  use({
    "windwp/nvim-autopairs",
    config = function() require("plugins.autopairs") end,
  })

  -- status line
  use({
    'hoob3rt/lualine.nvim',
    config = function() require('plugins.lualine') end,
  })

  -- bufferline
  use({
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require('plugins.bufferline') end,
    event = 'BufWinEnter',
  })

  use { "L3MON4D3/LuaSnip", config = function() require('plugins.snippets') end }

  -- nvim-tree
  use {
    "kyazdani42/nvim-tree.lua",
    -- event = "BufWinOpen",
    -- cmd = "NvimTreeToggle",
    config = function()
      require("plugins.nvimtree")
    end
  }
  use {
    "simrat39/symbols-outline.nvim",
    config = function()
      require('symbols-outline').setup()
    end
  }
  use {
    "tpope/vim-surround"
  }

  use {
    "loctvl842/monokai-pro.nvim",
    config = function()
      require("monokai-pro").setup({
        filter = "octagon",
        background_clear = { "float_win" }
      })
      vim.cmd [[colorscheme monokai-pro]]
      -- lvim.colorscheme="monokai-pro"
    end
  }

  use {
    "folke/which-key.nvim",
    config = function()
      require("plugins.whichkey")
    end
  }



  if packer_bootstrap then
    require('packer').sync()
  end
end
return require('packer').startup({
  packer_startup,
  config = packer_config
})
