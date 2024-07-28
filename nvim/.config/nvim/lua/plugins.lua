local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	-- LSP related plugins
	-- nlsp-settings' config goes in mason config file
	"tamago324/nlsp-settings.nvim",
	"artemave/workspace-diagnostics.nvim",
	-- {
	-- 	"rcarriga/nvim-notify",
	-- 	config = function()
	-- 		vim.notify = require("notify")
	-- 	end,
	-- },

	"williamboman/mason.nvim",
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("plugins.mason-lspconfig")
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins.lsp_config")
		end,
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},
	{
		"simrat39/rust-tools.nvim",
	},

	{
		"jay-babu/mason-null-ls.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
		config = function()
			require("plugins.null-ls")
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		-- Sources for nvim-cmp
		dependencies = {
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
	},

	"ray-x/lsp_signature.nvim",

	{
		"SmiteshP/nvim-navic",
		dependencies = "neovim/nvim-lspconfig",
	},

	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
		},
		opts = {
			theme = "tokyonight",
		},
	},

	{
		"Exafunction/codeium.vim",

		config = function()
			-- Change '<C-g>' here to any keycode you like.
			require("plugins.codeium")
		end,
	},

	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("plugins.snippets")
		end,
	},

	-- Trouble
	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
		dependencies = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({})
		end,
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
		},
		config = function()
			require("plugins.telescope-config")
			require("telescope").load_extension("fzf")
		end,
	},

	-- Autopairs
	{
		"windwp/nvim-autopairs",
		config = function()
			require("plugins.autopairs")
		end,
	},

	-- status line
	{
		"hoob3rt/lualine.nvim",
		config = function()
			require("plugins.lualine")
		end,
	},

	-- bufferline
	{
		"akinsho/bufferline.nvim",
		dependencies = "kyazdani42/nvim-web-devicons",
		config = function()
			require("plugins.bufferline")
		end,
		event = "BufWinEnter",
	},

	-- nvim-tree
	-- {
	-- 	"nvim-tree/nvim-tree.lua",
	-- 	after = "nvim-web-devicons",
	-- 	config = function()
	-- 		require("plugins.nvimtree")
	-- 	end,
	-- },
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("plugins.neotree")
		end,
	},

	{
		"simrat39/symbols-outline.nvim",
		config = function()
			require("symbols-outline").setup()
		end,
	},
	--
	"tpope/vim-surround",
	--
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

	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			local tokyonight = require("tokyonight")
			tokyonight.setup({
				style = "day",
			})
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
	-- {
	-- 	"rose-pine/neovim",
	-- 	name = "rose-pine",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("rose-pine").setup({
	-- 			variant = "dawn",
	-- 		})
	-- 		vim.cmd("colorscheme rose-pine")
	-- 	end,
	-- },
	-- {
	-- 	"neanias/everforest-nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	--       local everforest = require("everforest")
	-- 		everforest.setup({
	--         background = "soft",
	--         italics = true,
	--         disable_italic_comment = true,
	--         transparent_background_level = 0,
	-- 		})
	--       everforest.load()
	-- 	end,
	-- },
	-- {
	--   "catppuccin/nvim",
	--   name = "catppuccin",
	--   priority = 1000,
	--   lazy = false,
	--   config = function ()
	--     local catppuccin = require("catppuccin")
	--     catppuccin.setup({
	--       flavour = "mocha"
	--     })
	--     vim.cmd("colorscheme catppuccin")
	--   end
	-- },

	{
		"folke/which-key.nvim",
		config = function()
			require("plugins.whichkey")
		end,
	},

	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("plugins.toggleterm")
		end,
	},

	{
		"f-person/git-blame.nvim",
		config = function()
			vim.cmd([[
      let g:gitblame_message_template = '<author> - <date> - <summary>'
      let g:gitblame_delay=2
      ]])
		end,
	},

	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = function()
			require("git-conflict").setup()
		end,
	},

	-- use({
	-- 	"tanvirtin/vgit.nvim",
	-- 	requires = {
	-- 		"nvim-lua/plenary.nvim",
	-- 	},
	-- 	config = function()
	-- 		require("plugins.vgit")
	-- 	end,
	-- })
	{
		"terrortylor/nvim-comment",
		config = function()
			require("nvim_comment").setup()
		end,
	},

	-- use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })

	{
		"windwp/nvim-ts-autotag",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("plugins.treesitter")
		end,
		run = ":TSUpdate",
	},

	-- use({
	-- 	"gorbit99/codewindow.nvim",
	-- 	config = function()
	-- 		local codewindow = require("codewindow")
	-- 		codewindow.setup()
	-- 		codewindow.apply_default_keybinds()
	-- 	end,
	-- })

	{
		"kevinhwang91/nvim-hlslens",
		requires = "petertriho/nvim-scrollbar",
		config = function()
			-- require('hlslens').setup() is not required
			require("plugins.hlslens")
		end,
	},

	"wakatime/vim-wakatime",
}

require("lazy").setup(plugins)
