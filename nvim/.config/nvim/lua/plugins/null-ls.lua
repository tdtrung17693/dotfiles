local null_ls = require 'null-ls'

require ('mason-null-ls').setup({
    ensure_installed = {'stylua', 'jq'},
    handlers = {

    },
})
null_ls.setup()
