vim.o.conceallevel = 0 -- Don't hide quotes in markdown
vim.o.cmdheight = 1
vim.o.pumheight = 10
vim.o.showmode = false
vim.o.showtabline = 2 -- Always show tabline
vim.o.title = true
vim.o.termguicolors = true -- Use true colors, required for some plugins
vim.o.laststatus = 3
vim.o.incsearch = false

vim.o.title = false -- fix ghost line printed to buffer

vim.o.swapfile = false

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = "yes"
vim.wo.cursorline = true

vim.o.colorcolumn = "100"

-- Behavior
vim.o.hlsearch = false
vim.o.ignorecase = true -- Ignore case when using lowercase in search
vim.o.smartcase = true -- But don't ignore it when using upper case
vim.o.smarttab = true
vim.o.smartindent = true
vim.o.expandtab = true -- Convert tabs to spaces.
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.scrolloff = 12 -- Minimum offset in lines to screen borders
vim.o.sidescrolloff = 8
vim.o.mouse = "a"

-- Vim specific
vim.o.hidden = true -- Do not save when switching buffers
vim.o.fileencoding = "utf-8"
vim.o.spell = false -- As of v0.8.0 it only checks comments
vim.o.spelllang = "en_us"
vim.o.completeopt = "menuone,noinsert,noselect"
vim.o.wildmode = "longest,full" -- Display auto-complete in Command Mode
vim.o.updatetime = 300 -- Delay until write to Swap and HoldCommand event
vim.g.do_file_type_lua = 1
vim.g.mapleader = " "

-- Disable default plugins

-- Disable unused providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Disable inline error messages
vim.diagnostic.config({
	virtual_text = false,
	underline = false,
	signs = true, -- Keep gutter signs
})

-- File type mapping
vim.filetype.add({
	extension = {
		tf = "terraform",
		tfvars = "terraform",
		tfstate = "json",
	},
})
