local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local utils = require("lsp.utils")

require("nlspsettings").setup({
  config_home = vim.fn.stdpath("config") .. "/nlsp-settings",
  append_default_schemas = true,
  ignored_servers = {},
  loader = "json",
})

require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = {
    "bashls",
    "clangd",
    "jsonls",
    "lua_ls",
    "dockerls",
  },
  automatic_installation = true,
})

local lspconfig = require("lspconfig")

require("mason-lspconfig").setup_handlers({
  function(server_name)
    lspconfig[server_name].setup({
      on_attach = utils.common_on_attach,
      capabilities = capabilities,
      init_options = {
        userLanguages = {
          eelixir = "html-eex",
          eruby = "erb",
          rust = "html",
        },
      },
    })
  end,
  ["lua_ls"] = function()
    lspconfig["lua_ls"].setup({
      on_attach = utils.common_on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim", "use" },
          },
        },
      },
    })
  end,
  ["clangd"] = function()
    lspconfig["clangd"].setup({
      filetypes = { "c", "cpp", "objc", "objcpp" },
    })
  end,
  ["cssls"] = function()
    lspconfig["cssls"].setup({
      on_attach = utils.common_on_attach,
      capabilities = capabilities,

      settings = {
        css = {
          lint = {
            unknownAtRules = "ignore",
          }
        },
        scss = {
          validate = true,
        },
        less = {
          validate = true,
        },
      },
    })
  end,
  ["tsserver"] = function()
    require("lspconfig").tsserver.setup({
      on_init = function(client)
        client.server_capabilities.documentFormattingProvider = false
      end,
      on_attach = function(client, bufnr)
        utils.common_on_attach(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
      end,
      commands = {
        OrganizeImports = {
          utils.organize_imports,
          description = "Organize Imports",
        },
      },
    })
  end,
  ["eslint"] = function()
    lspconfig.eslint.setup({
      on_init = function(client)
        client.server_capabilities.documentFormattingProvider = true
      end,
      on_attach = function(client, bufnr)
        utils.common_on_attach(client, bufnr)
        client.resolved_capabilities.document_formatting = true
        client.resolved_capabilities.document_range_formatting = true
      end,
      capabilities = capabilities,
    })
  end,
  ["rust_analyzer"] = function()
    require("plugins.rust-tools")
  end,
})
-- vim.api.nvim_create_autocmd('BufWritePre', {
--   pattern = { '*.tsx', '*.ts', '*.jsx', '*.js' },
--   command = 'silent! EslintFixAll',
--   group = vim.api.nvim_create_augroup('MyAutocmdsJavaScripFormatting', {}),
-- })
