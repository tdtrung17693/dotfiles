local icons = require("icons")
require("neo-tree").setup({
	filesystem = {
		follow_current_file = {
			enabled = true,
		},
	},
	buffers = {
		follow_current_file = {
			enabled = true,
		},
	},
	default_component_configs = {
		git_status = {
			symbols = {
				-- Change type
				added = icons.LineAdded, -- or "✚", but this is redundant info if you use git_status_colors on the name
				modified = icons.LineModified, -- or "", but this is redundant info if you use git_status_colors on the name
				deleted = icons.FileDeleted, -- this can only be used in the git_status source
				renamed = icons.FileRenamed, -- this can only be used in the git_status source
				-- Status type
				untracked = icons.FileUnstaged,
				ignored = icons.FileIgnored,
				unstaged = icons.FileUnstaged,
				staged = icons.FileStaged,
				conflict = icons.Conflict,
			},
		},
	},
})

vim.keymap.set("n", "<leader>e", "<cmd>Neotree filesystem toggle left<CR>")
