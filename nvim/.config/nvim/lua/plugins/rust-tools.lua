local mason_registry = require("mason-registry")

local codelldb_root = mason_registry.get_package("codelldb"):get_install_path() .. "/extension/"
local codelldb_path = codelldb_root .. "adapter/codelldb"
local liblldb_path = codelldb_root .. "lldb/lib/liblldb.so"


local rt = require("rust-tools")
local utils = require("lsp.utils")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

rt.setup({
  tools = {
    hover_actions = {
      -- whether the hover action window gets automatically focused
      auto_focus = false,
    },
  },
  server = {
    on_attach = function(client, bufnr)
      utils.common_on_attach(client, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
      require("dap")
      require("dapui").setup()
    end,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          enable = true,
          command = "clippy",
        },
        cargo = {
          allFeatures = true,
        },
      },
    },
  },
  dap = { adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path) },
})
