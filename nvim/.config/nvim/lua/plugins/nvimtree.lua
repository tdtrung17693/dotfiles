local icons = require("icons")
require('nvim-tree').setup({
  -- Allow using gx
  disable_netrw = true,
  hijack_netrw = true,
  update_cwd = true,
  git = {
    enable = true
  },
  diagnostics = {
    enable = true,
    show_on_dirs = false,
    icons = {
      hint = icons.BoldHint,
      info = icons.BoldInformation,
      warning = icons.BoldWarning,
      error = icons.BoldError,
    },
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
  },
  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = false
      }
    }
  }
})

vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>')
