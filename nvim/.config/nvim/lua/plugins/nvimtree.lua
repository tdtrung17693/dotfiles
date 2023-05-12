require('nvim-tree').setup({
	-- Allow using gx
	disable_netrw = true,
	hijack_netrw = true,
	update_cwd = true,
	git = {
		enable = true
	},
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      diagnostics = false,
      git = false,
      profile = false
    }
  }
})

vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>')
