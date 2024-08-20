local utils = require("lsp.utils")
local M = {
  mappings = {},
  vmappings = {},
}
--
-- M.vmappings["/"] = { "<Cmd>set operatorfunc=CommentOperator<CR>g@", "Comment toggle" }
--
-- -- Bufferline {{{
-- M.mappings["b"] = {
--   name = "Buffers",
--   j = { "<cmd>BufferLinePick<cr>", "Jump" },
--   f = { "<cmd>Telescope buffers<cr>", "Find" },
--   b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
--   n = { "<cmd>BufferLineCycleNext<cr>", "Next" },
--   -- w = { "<cmd>BufferWipeout<cr>", "Wipeout" }, -- TODO: implement this for bufferline
--   e = {
--     "<cmd>BufferLinePickClose<cr>",
--     "Pick which buffer to close",
--   },
--   h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
--   l = {
--     "<cmd>BufferLineCloseRight<cr>",
--     "Close all to the right",
--   },
--   D = {
--     "<cmd>BufferLineSortByDirectory<cr>",
--     "Sort by directory",
--   },
--   L = {
--     "<cmd>BufferLineSortByExtension<cr>",
--     "Sort by language",
--   },
-- }
-- -- }}}
--
-- -- Debugging {{{
-- -- " Available Debug Adapters:
-- -- "   https://microsoft.github.io/debug-adapter-protocol/implementors/adapters/
-- -- " Adapter configuration and installation instructions:
-- -- "   https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
-- -- " Debug Adapter protocol:
-- -- "   https://microsoft.github.io/debug-adapter-protocol/
-- -- " Debugging
-- M.mappings["d"] = {
--   name = "Debug",
--   t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
--   b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
--   c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
--   C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
--   d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
--   g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
--   i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
--   o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
--   u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
--   p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
--   r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
--   s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
--   q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
--   U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
-- }
-- --- }}}
--
-- -- Packer {{{
-- M.mappings["p"] = {
--   name = "Packer",
--   c = { "<cmd>PackerCompile<cr>", "Compile" },
--   i = { "<cmd>PackerInstall<cr>", "Install" },
--   s = { "<cmd>PackerSync<cr>", "Sync" },
--   S = { "<cmd>PackerStatus<cr>", "Status" },
--   u = { "<cmd>PackerUpdate<cr>", "Update" },
-- }
-- -- }}}
--
-- -- Git {{{
-- M.mappings["g"] = {
--   name = "Git",
--   j = { "<cmd>lua require 'vgit'.hunk_up()<cr>", "Next Hunk" },
--   k = { "<cmd>lua require 'vgit'.hunk_down()<cr>", "Prev Hunk" },
--   h = { "<cmd>lua require 'vgit'.buffer_history_preview()<cr>", "History"},
--   f = { "<cmd>lua require 'vgit'.buffer_diff_preview()<cr>", "Diff"},
--   l = { "<cmd>lua require 'vgit'.buffer_gutter_blame_preview()<cr>", "Blame"},
--   -- p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
--   -- r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
--   -- R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
--   -- s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
--   -- u = {
--   --   "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
--   --   "Undo Stage Hunk",
--   -- },
--   -- o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
--   -- b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
--   -- c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
--   -- C = {
--   --   "<cmd>Telescope git_bcommits<cr>",
--   --   "Checkout commit(for current file)",
--   -- },
--   -- d = {
--   --   "<cmd>Gitsigns diffthis HEAD<cr>",
--   --   "Git Diff",
--   -- },
-- }
-- -- }}}
--
-- -- LSP {{{
-- M.mappings["l"] = {
--   name = "LSP",
--   a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
--   -- d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
--   d = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Declarations" },
--   D = { "<cmd>Trouble toggle lsp_definitions focus=true<cr>", "Definitions" },
--   R = { "<cmd>Telescope lsp_references show_line=false<CR>", "References" },
--   w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
--   -- d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
--   i = { "<Cmd>lua vim.lsp.buf.implementation()<CR>", "Implementations" },
--   o = { utils.organize_imports, "Organize Imports" },
--   I = { "<cmd>Mason<cr>", "Mason Info" },
--   j = {
--     vim.diagnostic.goto_next,
--     "Next Diagnostic",
--   },
--   f = { "<cmd> lua vim.lsp.buf.format { async = true }<CR>", "Format" },
--   k = {
--     vim.diagnostic.goto_prev,
--     "Prev Diagnostic",
--   },
--   l = { vim.lsp.codelens.run, "CodeLens Action" },
--   q = { "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", "Quickfix" },
--   x = { vim.diagnostic.setloclist, "Quickfix Dia" },
--   Q = { "<cmd>Trouble diagnostics toggle<cr>", "Quickfix" },
--   r = { vim.lsp.buf.rename, "Rename" },
--   s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
--   S = {
--     "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
--     "Workspace Symbols",
--   },
--   e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
-- }
-- -- }}}
--
-- -- Telescope search {{{
-- M.mappings["s"] = {
--   name = "Search",
--   b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
--   c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
--   f = { "<cmd>Telescope find_files<cr>", "Find File" },
--   h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
--   H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
--   M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
--   r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
--   R = { "<cmd>Telescope registers<cr>", "Registers" },
--   t = { "<cmd>Telescope live_grep<cr>", "Text" },
--   k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
--   C = { "<cmd>Telescope commands<cr>", "Commands" },
--   p = {
--     "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
--     "Colorscheme with Preview",
--   },
-- }
-- -- }}}
--
-- -- Treesitter {{{
-- M.mappings["T"] = {
--   name = "Treesitter",
--   i = { ":TSConfigInfo<cr>", "Info" },
-- }
-- -- }}}
--
-- -- Trouble mapping {{{
-- M.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
-- }
-- -- }}}
M.mappings = {
  {
    "<leader>/",
    "<Cmd>set operatorfunc=CommentOperator<CR>g@",
    desc = "Comment Toggle",
    nowait = true,
    remap = false,
  },
  { "<leader>;",  "<cmd>Alpha<CR>",                            desc = "Dashboard",                  nowait = true, remap = false },
  { "<leader>T",  group = "Treesitter",                        nowait = true,                       remap = false },
  { "<leader>Ti", ":TSConfigInfo<cr>",                         desc = "Info",                       nowait = true, remap = false },
  { "<leader>b",  group = "Buffers",                           nowait = true,                       remap = false },
  { "<leader>bD", "<cmd>BufferLineSortByDirectory<cr>",        desc = "Sort by directory",          nowait = true, remap = false },
  { "<leader>bL", "<cmd>BufferLineSortByExtension<cr>",        desc = "Sort by language",           nowait = true, remap = false },
  { "<leader>bb", "<cmd>BufferLineCyclePrev<cr>",              desc = "Previous",                   nowait = true, remap = false },
  { "<leader>be", "<cmd>BufferLinePickClose<cr>",              desc = "Pick which buffer to close", nowait = true, remap = false },
  { "<leader>bf", "<cmd>Telescope buffers<cr>",                desc = "Find",                       nowait = true, remap = false },
  { "<leader>bh", "<cmd>BufferLineCloseLeft<cr>",              desc = "Close all to the left",      nowait = true, remap = false },
  { "<leader>bj", "<cmd>BufferLinePick<cr>",                   desc = "Jump",                       nowait = true, remap = false },
  { "<leader>bl", "<cmd>BufferLineCloseRight<cr>",             desc = "Close all to the right",     nowait = true, remap = false },
  { "<leader>bn", "<cmd>BufferLineCycleNext<cr>",              desc = "Next",                       nowait = true, remap = false },
  { "<leader>c",  "<cmd>BufferKill<CR>",                       desc = "Close Buffer",               nowait = true, remap = false },
  { "<leader>d",  group = "Debug",                             nowait = true,                       remap = false },
  { "<leader>dC", "<cmd>lua require'dap'.run_to_cursor()<cr>", desc = "Run To Cursor",              nowait = true, remap = false },
  { "<leader>dU", "<cmd>lua require'dapui'.toggle()<cr>",      desc = "Toggle UI",                  nowait = true, remap = false },
  { "<leader>db", "<cmd>lua require'dap'.step_back()<cr>",     desc = "Step Back",                  nowait = true, remap = false },
  { "<leader>dc", "<cmd>lua require'dap'.continue()<cr>",      desc = "Continue",                   nowait = true, remap = false },
  { "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>",    desc = "Disconnect",                 nowait = true, remap = false },
  { "<leader>dg", "<cmd>lua require'dap'.session()<cr>",       desc = "Get Session",                nowait = true, remap = false },
  { "<leader>di", "<cmd>lua require'dap'.step_into()<cr>",     desc = "Step Into",                  nowait = true, remap = false },
  { "<leader>do", "<cmd>lua require'dap'.step_over()<cr>",     desc = "Step Over",                  nowait = true, remap = false },
  { "<leader>dp", "<cmd>lua require'dap'.pause()<cr>",         desc = "Pause",                      nowait = true, remap = false },
  { "<leader>dq", "<cmd>lua require'dap'.close()<cr>",         desc = "Quit",                       nowait = true, remap = false },
  { "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>",   desc = "Toggle Repl",                nowait = true, remap = false },
  { "<leader>ds", "<cmd>lua require'dap'.continue()<cr>",      desc = "Start",                      nowait = true, remap = false },
  {
    "<leader>dt",
    "<cmd>lua require'dap'.toggle_breakpoint()<cr>",
    desc = "Toggle Breakpoint",
    nowait = true,
    remap = false,
  },
  { "<leader>du", "<cmd>lua require'dap'.step_out()<cr>",              desc = "Step Out", nowait = true, remap = false },
  { "<leader>g",  group = "Git",                                       nowait = true,     remap = false },
  { "<leader>gf", "<cmd>lua require 'vgit'.buffer_diff_preview()<cr>", desc = "Diff",     nowait = true, remap = false },
  {
    "<leader>gh",
    "<cmd>lua require 'vgit'.buffer_history_preview()<cr>",
    desc = "History",
    nowait = true,
    remap = false,
  },
  { "<leader>gj", "<cmd>lua require 'vgit'.hunk_up()<cr>",   desc = "Next Hunk", nowait = true, remap = false },
  { "<leader>gk", "<cmd>lua require 'vgit'.hunk_down()<cr>", desc = "Prev Hunk", nowait = true, remap = false },
  {
    "<leader>gl",
    "<cmd>lua require 'vgit'.buffer_gutter_blame_preview()<cr>",
    desc = "Blame",
    nowait = true,
    remap = false,
  },
  { "<leader>h", "<cmd>nohlsearch<CR>", desc = "No Highlight", nowait = true, remap = false },
  { "<leader>l", group = "LSP",         nowait = true,         remap = false },
  {
    "<leader>lD",
    "<cmd>Trouble toggle lsp_definitions focus=true<cr>",
    desc = "Definitions",
    nowait = true,
    remap = false,
  },
  { "<leader>lI", "<cmd>Mason<cr>",                      desc = "Mason Info", nowait = true, remap = false },
  { "<leader>lQ", "<cmd>Trouble diagnostics toggle<cr>", desc = "Quickfix",   nowait = true, remap = false },
  {
    "<leader>lR",
    "<cmd>Telescope lsp_references show_line=false<CR>",
    desc = "References",
    nowait = true,
    remap = false,
  },
  {
    "<leader>lS",
    "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
    desc = "Workspace Symbols",
    nowait = true,
    remap = false,
  },
  { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action",        nowait = true, remap = false },
  { "<leader>ld", "<Cmd>lua vim.lsp.buf.declaration()<CR>", desc = "Declarations",       nowait = true, remap = false },
  { "<leader>le", "<cmd>Telescope quickfix<cr>",            desc = "Telescope Quickfix", nowait = true, remap = false },
  {
    "<leader>lf",
    "<cmd> lua vim.lsp.buf.format { async = true }<CR>",
    desc = "Format",
    nowait = true,
    remap = false,
  },
  {
    "<leader>li",
    "<Cmd>lua vim.lsp.buf.implementation()<CR>",
    desc = "Implementations",
    nowait = true,
    remap = false,
  },
  { "<leader>lj", vim.diagnostic.goto_next, desc = "Next Diagnostic",  nowait = true, remap = false },
  { "<leader>lk", vim.diagnostic.goto_prev, desc = "Prev Diagnostic",  nowait = true, remap = false },
  { "<leader>ll", vim.lsp.codelens.run,     desc = "CodeLens Action",  nowait = true, remap = false },
  { "<leader>lo", utils.organize_imports,   desc = "Organize Imports", nowait = true, remap = false },
  {
    "<leader>lq",
    "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
    desc = "Quickfix",
    nowait = true,
    remap = false,
  },
  { "<leader>lr", vim.lsp.buf.rename,                desc = "Rename",                nowait = true, remap = false },
  {
    "<leader>ls",
    "<cmd>Telescope lsp_document_symbols<cr>",
    desc = "Document Symbols",
    nowait = true,
    remap = false,
  },
  { "<leader>lw", "<cmd>Telescope diagnostics<cr>",  desc = "Diagnostics",           nowait = true, remap = false },
  { "<leader>lx", vim.lsp.diagnostic.setloclist,     desc = "Quickfix Dia",          nowait = true, remap = false },
  { "<leader>p",  group = "Packer",                  nowait = true,                  remap = false },
  { "<leader>pS", "<cmd>PackerStatus<cr>",           desc = "Status",                nowait = true, remap = false },
  { "<leader>pc", "<cmd>PackerCompile<cr>",          desc = "Compile",               nowait = true, remap = false },
  { "<leader>pi", "<cmd>PackerInstall<cr>",          desc = "Install",               nowait = true, remap = false },
  { "<leader>ps", "<cmd>PackerSync<cr>",             desc = "Sync",                  nowait = true, remap = false },
  { "<leader>pu", "<cmd>PackerUpdate<cr>",           desc = "Update",                nowait = true, remap = false },
  { "<leader>s",  group = "Search",                  nowait = true,                  remap = false },
  { "<leader>sC", "<cmd>Telescope commands<cr>",     desc = "Commands",              nowait = true, remap = false },
  { "<leader>sH", "<cmd>Telescope highlights<cr>",   desc = "Find highlight groups", nowait = true, remap = false },
  { "<leader>sM", "<cmd>Telescope man_pages<cr>",    desc = "Man Pages",             nowait = true, remap = false },
  { "<leader>sR", "<cmd>Telescope registers<cr>",    desc = "Registers",             nowait = true, remap = false },
  { "<leader>sb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch",       nowait = true, remap = false },
  { "<leader>sc", "<cmd>Telescope colorscheme<cr>",  desc = "Colorscheme",           nowait = true, remap = false },
  { "<leader>sf", "<cmd>Telescope find_files<cr>",   desc = "Find File",             nowait = true, remap = false },
  { "<leader>sh", "<cmd>Telescope help_tags<cr>",    desc = "Find Help",             nowait = true, remap = false },
  { "<leader>sk", "<cmd>Telescope keymaps<cr>",      desc = "Keymaps",               nowait = true, remap = false },
  {
    "<leader>sp",
    "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
    desc = "Colorscheme with Preview",
    nowait = true,
    remap = false,
  },
  { "<leader>sr", "<cmd>Telescope oldfiles<cr>",           desc = "Open Recent File", nowait = true, remap = false },
  { "<leader>st", "<cmd>Telescope live_grep<cr>",          desc = "Text",             nowait = true, remap = false },
  { "<leader>t",  group = "Trouble",                       nowait = true,             remap = false },
  { "<leader>td", "<cmd>Trouble document_diagnostics<cr>", desc = "Diagnostics",      nowait = true, remap = false },
  { "<leader>tf", "<cmd>Trouble lsp_definitions<cr>",      desc = "Definitions",      nowait = true, remap = false },
  { "<leader>tl", "<cmd>Trouble loclist<cr>",              desc = "LocationList",     nowait = true, remap = false },
  { "<leader>tq", "<cmd>Trouble quickfix<cr>",             desc = "QuickFix",         nowait = true, remap = false },
  { "<leader>tr", "<cmd>Trouble lsp_references<cr>",       desc = "References",       nowait = true, remap = false },
  {
    "<leader>tw",
    "<cmd>Trouble workspace_diagnostics<cr>",
    desc = "Workspace Diagnostics",
    nowait = true,
    remap = false,
  },
  { "<leader>w", "<cmd>w!<CR>", desc = "Save", nowait = true, remap = false },
  {
    "<leader>/",
    "<Cmd>set operatorfunc=CommentOperator<CR>g@",
    desc = "Comment toggle",
    mode = "v",
    nowait = true,
    remap = false,
  },
}

vim.cmd([[
  nnoremap <C-j> <C-e>j
  nnoremap <C-k> <C-y>k
]])

return M
