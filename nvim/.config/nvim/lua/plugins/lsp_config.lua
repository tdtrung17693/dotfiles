-- signature help hover
require "lsp_signature".setup({})

local icons = require "icons"
local signs = {
  { name = "DiagnosticSignError", text = icons.Error },
  { name = "DiagnosticSignWarn",  text = icons.Warning },
  { name = "DiagnosticSignHint",  text = icons.Hint },
  { name = "DiagnosticSignInfo",  text = icons.Info },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
end
