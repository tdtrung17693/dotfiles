local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
local utils = require("lsp.utils")

require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = {
    "bashls",
    "clangd",
    "jsonls",
    "lua_ls",
    "dockerls",
  },
  automatic_installation = true,
}


local lspconfig = require("lspconfig")
require("mason-lspconfig").setup_handlers {
  function(server_name)
    lspconfig[server_name].setup {
      on_attach = utils.common_on_attach,
      capabilities = capabilities,
    }
  end,
  ["lua_ls"] = function()
    lspconfig["lua_ls"].setup {
      on_attach = utils.common_on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim", "use" },
          },
        },
      },
    }
  end
}
