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
		-- lspconfig["eslint"].setup {
		--   on_attach = function(client, bufnr)
		--     utils.common_on_attach(client, bufnr)
		--     client.resolved_capabilities.document_formatting = true
		--     client.resolved_capabilities.document_range_formatting = true
		--   end,
		--   capabilities = capabilities,
		--   -- filetypes = {
		--   --   "javascript",
		--   --   "javascriptreact",
		--   --   "javascript.jsx",
		--   --   "typescript",
		--   --   "typescriptreact",
		--   --   "typescript.tsx",
		--   --   "vue",
		--   --   "svelte",
		--   -- },
		--   settings = {
		--     codeAction = {
		--       disableRuleComment = { enable = true, location = "separateLine" },
		--       showDocumentation = { enable = true },
		--     },
		--     -- experimental = { useFlatConfig = true },
		--     -- nodePath = lib.path.resolve_config("linters/eslint/node_modules"),
		--     onIgnoredFiles = "off",
		--     options = {
		--       cache = true,
		--       fix = true,
		--       --overrideConfigFile = lib.path.resolve_config("linters/eslint/dist/main.js"),
		--       -- resolvePluginsRelativeTo = lib.path.resolve_config("linters/eslint/node_modules"),
		--       useEslintrc = true,
		--     },
		--     packageManager = "npm",
		--     run = "onType",
		--     workingDirectory = { mode = "auto" },
		--   },
		-- }
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
})
-- vim.api.nvim_create_autocmd('BufWritePre', {
--   pattern = { '*.tsx', '*.ts', '*.jsx', '*.js' },
--   command = 'silent! EslintFixAll',
--   group = vim.api.nvim_create_augroup('MyAutocmdsJavaScripFormatting', {}),
-- })
