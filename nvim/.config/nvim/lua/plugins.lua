-- bootstrapping packer
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
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
	},
}

local function packer_startup()
	use("wbthomason/packer.nvim")

	-- LSP related plugins
	-- nlsp-settings' config goes in mason config file
	use("tamago324/nlsp-settings.nvim")

	use({
		"williamboman/mason.nvim",
	})
	use({
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("plugins.mason-lspconfig")
		end,
	})
	use({
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins.lsp_config")
		end,
	})

	use({
		"jay-babu/mason-null-ls.nvim",
		requires = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
		config = function()
			require("plugins.null-ls")
		end,
	})

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
		config = function()
			require("plugins.cmp")
		end,
	})

	use({
		"ray-x/lsp_signature.nvim",
	})

	use({
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
		config = function()
			require("plugins.nvim-navic")
		end,
	})

	-- use {
	--   "jose-elias-alvarez/null-ls.nvim",
	--   config = function ()
	--     require("plugins.null-ls")
	--   end
	-- }

	use({
		"Exafunction/codeium.vim",

		config = function()
			-- Change '<C-g>' here to any keycode you like.
			vim.keymap.set("i", "<C-g>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true })
			vim.keymap.set("i", "<c-;>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true })
			vim.keymap.set("i", "<c-,>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true })
			vim.keymap.set("i", "<c-x>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true })
		end,
	})

	use({
		"L3MON4D3/LuaSnip",
		config = function()
			require("plugins.snippets")
		end,
	})

	-- Trouble
	use({
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({})
		end,
	})

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("plugins.treesitter")
		end,
		run = ":TSUpdate",
	})

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-ui-select.nvim" } },
		config = function()
			require("plugins.telescope")
		end,
	})

	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use({
    "nvim-telescope/telescope-ui-select.nvim",
  })

	-- Autopairs
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("plugins.autopairs")
		end,
	})

	-- status line
	use({
		"hoob3rt/lualine.nvim",
		config = function()
			require("plugins.lualine")
		end,
	})

	-- bufferline
	use({
		"akinsho/bufferline.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("plugins.bufferline")
		end,
		event = "BufWinEnter",
	})

	-- nvim-tree
	use("nvim-tree/nvim-web-devicons")
	use({
		"nvim-tree/nvim-tree.lua",
		after = "nvim-web-devicons",
		config = function()
			require("plugins.nvimtree")
		end,
	})

	use({
		"simrat39/symbols-outline.nvim",
		config = function()
			require("symbols-outline").setup()
		end,
	})

	use("tpope/vim-surround")

	-- use({
	-- 	"loctvl842/monokai-pro.nvim",
	-- 	config = function()
	-- 		require("monokai-pro").setup({
	-- 			filter = "octagon",
	-- 			background_clear = { "float_win" },
	-- 		})
	-- 		vim.cmd([[colorscheme monokai-pro]])
	-- 	end,
	-- })

	-- use({
	-- 	"tiagovla/tokyodark.nvim",
	-- 	config = function()
	-- 		vim.g.tokyodark_transparent_background = false
	-- 		vim.g.tokyodark_enable_italic_comment = true
	-- 		vim.g.tokyodark_enable_italic = true
	-- 		vim.g.tokyodark_color_gamma = "1.0"
	-- 		vim.cmd("colorscheme tokyodark")
	-- 	end,
	-- })
	use({
		"rose-pine/neovim",
		as = "rose-pine",
		config = function()
			require("rose-pine").setup({
				variant = "dawn",
			})
			vim.cmd("colorscheme rose-pine")
		end,
	})

	use({
		"folke/which-key.nvim",
		config = function()
			require("plugins.whichkey")
		end,
	})

	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("plugins.toggleterm")
		end,
	})

	use({
		"f-person/git-blame.nvim",
		config = function()
			vim.cmd([[
        let g:gitblame_message_template = '<author> - <date> - <summary>'
      ]])
		end,
	})

	use({
		"akinsho/git-conflict.nvim",
		tag = "*",
		config = function()
			require("git-conflict").setup()
		end,
	})

	-- use({
	-- 	"tanvirtin/vgit.nvim",
	-- 	requires = {
	-- 		"nvim-lua/plenary.nvim",
	-- 	},
	-- 	config = function()
	-- 		require("plugins.vgit")
	-- 	end,
	-- })
	use({
		"terrortylor/nvim-comment",
		config = function()
			require("nvim_comment").setup()
		end,
	})

	use({
		"simrat39/rust-tools.nvim",
		--config = function()
		--  require("plugins.rust-tools")
		--end
	})

	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })

	use({
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	})

	use({
		"gorbit99/codewindow.nvim",
		config = function()
			local codewindow = require("codewindow")
			codewindow.setup()
			codewindow.apply_default_keybinds()
		end,
	})

	use({
		"kevinhwang91/nvim-hlslens",
		requires = "petertriho/nvim-scrollbar",
		config = function()
			-- require('hlslens').setup() is not required
			require("plugins.hlslens")
		end,
	})

  use 'wakatime/vim-wakatime'

	if packer_bootstrap then
		require("packer").sync()
	end
end
return require("packer").startup({
	packer_startup,
	config = packer_config,
})
