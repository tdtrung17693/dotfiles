local utils = require("lsp.utils")
local M = {
  mappings = {},
  vmappings = {},
}
--
M.mappings = {
  [";"] = { "<cmd>Alpha<CR>", "Dashboard" },
  ["w"] = { "<cmd>w!<CR>", "Save" },
  ["/"] = { "<Cmd>set operatorfunc=CommentOperator<CR>g@", "Comment Toggle"},
  ["c"] = { "<cmd>BufferKill<CR>", "Close Buffer" },
  ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
}

M.vmappings["/"] = { "<Cmd>set operatorfunc=CommentOperator<CR>g@", "Comment toggle" }

-- Bufferline {{{
M.mappings["b"] = {
  name = "Buffers",
  j = { "<cmd>BufferLinePick<cr>", "Jump" },
  f = { "<cmd>Telescope buffers<cr>", "Find" },
  b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
  n = { "<cmd>BufferLineCycleNext<cr>", "Next" },
  -- w = { "<cmd>BufferWipeout<cr>", "Wipeout" }, -- TODO: implement this for bufferline
  e = {
    "<cmd>BufferLinePickClose<cr>",
    "Pick which buffer to close",
  },
  h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
  l = {
    "<cmd>BufferLineCloseRight<cr>",
    "Close all to the right",
  },
  D = {
    "<cmd>BufferLineSortByDirectory<cr>",
    "Sort by directory",
  },
  L = {
    "<cmd>BufferLineSortByExtension<cr>",
    "Sort by language",
  },
}
-- }}}

-- Debugging {{{
-- " Available Debug Adapters:
-- "   https://microsoft.github.io/debug-adapter-protocol/implementors/adapters/
-- " Adapter configuration and installation instructions:
-- "   https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
-- " Debug Adapter protocol:
-- "   https://microsoft.github.io/debug-adapter-protocol/
-- " Debugging
M.mappings["d"] = {
  name = "Debug",
  t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
  b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
  c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
  C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
  d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
  g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
  i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
  o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
  u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
  p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
  r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
  s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
  q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
  U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
}
--- }}}

-- Packer {{{
M.mappings["p"] = {
  name = "Packer",
  c = { "<cmd>PackerCompile<cr>", "Compile" },
  i = { "<cmd>PackerInstall<cr>", "Install" },
  s = { "<cmd>PackerSync<cr>", "Sync" },
  S = { "<cmd>PackerStatus<cr>", "Status" },
  u = { "<cmd>PackerUpdate<cr>", "Update" },
}
-- }}}

-- Git {{{
M.mappings["g"] = {
  name = "Git",
  j = { "<cmd>lua require 'vgit'.hunk_up()<cr>", "Next Hunk" },
  k = { "<cmd>lua require 'vgit'.hunk_down()<cr>", "Prev Hunk" },
  h = { "<cmd>lua require 'vgit'.buffer_history_preview()<cr>", "History"},
  f = { "<cmd>lua require 'vgit'.buffer_diff_preview()<cr>", "Diff"},
  l = { "<cmd>lua require 'vgit'.buffer_gutter_blame_preview()<cr>", "Blame"},
  -- p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
  -- r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
  -- R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
  -- s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
  -- u = {
  --   "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
  --   "Undo Stage Hunk",
  -- },
  -- o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
  -- b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
  -- c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
  -- C = {
  --   "<cmd>Telescope git_bcommits<cr>",
  --   "Checkout commit(for current file)",
  -- },
  -- d = {
  --   "<cmd>Gitsigns diffthis HEAD<cr>",
  --   "Git Diff",
  -- },
}
-- }}}

-- LSP {{{
M.mappings["l"] = {
  name = "LSP",
  a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
  -- d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
  d = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Declarations" },
  D = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  R = { "<cmd>Telescope lsp_references show_line=false<CR>", "References" },
  w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
  -- d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
  i = { "<Cmd>lua vim.lsp.buf.implementation()<CR>", "Implementations" },
  o = { utils.organize_imports, "Organize Imports" },
  I = { "<cmd>Mason<cr>", "Mason Info" },
  j = {
    vim.diagnostic.goto_next,
    "Next Diagnostic",
  },
  f = { "<cmd> lua vim.lsp.buf.format { async = true }<CR>", "Format" },
  k = {
    vim.diagnostic.goto_prev,
    "Prev Diagnostic",
  },
  l = { vim.lsp.codelens.run, "CodeLens Action" },
  q = { "<cmd>Trouble workspace_diagnostics<cr>", "Quickfix" },
  r = { vim.lsp.buf.rename, "Rename" },
  s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
  S = {
    "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
    "Workspace Symbols",
  },
  e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
}
-- }}}

-- Telescope search {{{
M.mappings["s"] = {
  name = "Search",
  b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
  c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
  f = { "<cmd>Telescope find_files<cr>", "Find File" },
  h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
  H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
  M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
  r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
  R = { "<cmd>Telescope registers<cr>", "Registers" },
  t = { "<cmd>Telescope live_grep<cr>", "Text" },
  k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
  C = { "<cmd>Telescope commands<cr>", "Commands" },
  p = {
    "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
    "Colorscheme with Preview",
  },
}
-- }}}

-- Treesitter {{{
M.mappings["T"] = {
  name = "Treesitter",
  i = { ":TSConfigInfo<cr>", "Info" },
}
-- }}}

-- Trouble mapping {{{
M.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}
-- }}}


return M
