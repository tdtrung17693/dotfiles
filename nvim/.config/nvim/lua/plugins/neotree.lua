require("neo-tree").setup({
  default_component_configs = {
    filesystem = {
      follow_current_file = {
        enabled = true
      },
    },
    buffers = {
      follow_current_file = {
        enabled = true
      },
    },
  }
})

vim.keymap.set("n", "<leader>e", "<cmd>Neotree filesystem toggle left<CR>")
