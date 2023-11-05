local navic = require("nvim-navic")
local cmd = vim.cmd

local E = {}

--cmd([[autocmd ColorScheme * highlight NormalFloat guibg=#1f2335]])
--cmd([[autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]])

function E.common_on_attach(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local opts = { noremap = true, silent = true }
  local function bufnnoremap(lhs, rhs)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', lhs, rhs, opts)
  end
  bufnnoremap("K", "<Cmd>lua vim.lsp.buf.hover()<CR>")

  bufnnoremap("<A-k>", "<Cmd>lua vim.lsp.buf.signature_help()<CR>")

  if client.server_capabilities.document_formatting then
    --cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
  end

  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
end

function E.organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = {vim.api.nvim_buf_get_name(0)},
    title = ""
  }
  vim.lsp.buf.execute_command(params)
end


return E
