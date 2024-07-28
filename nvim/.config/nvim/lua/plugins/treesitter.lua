-- Treesitter configuration

require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  },
  -- We must manually specify which parsers to install
  ensure_installed = {
    "bash",
    "c",
    "cpp",
    "json",
    "lua",
    "markdown",
    "python",
    "yaml",
    "vim",
    "latex",
    "rust",
    "typescript",
    "javascript",
    "html"
  },
})
require("nvim-ts-autotag").setup({})
