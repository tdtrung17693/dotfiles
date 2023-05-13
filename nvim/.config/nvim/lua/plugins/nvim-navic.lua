local icons = require "icons"
local opts = {
  active = true,
  on_config_done = nil,
  winbar_filetype_exclude = {
    "help",
    "startify",
    "dashboard",
    "packer",
    "neo-tree",
    "neogitstatus",
    "NvimTree",
    "Trouble",
    "alpha",
    "lir",
    "Outline",
    "spectre_panel",
    "toggleterm",
    "DressingSelect",
    "Jaq",
    "harpoon",
    "dap-repl",
    "dap-terminal",
    "dapui_console",
    "lab",
    "Markdown",
    "notify",
    "noice",
    "",
  },
  options = {
    icons = {
      Array = icons.Array .. " ",
      Boolean = icons.Boolean,
      Class = icons.Class .. " ",
      Color = icons.Color .. " ",
      Constant = icons.Constant .. " ",
      Constructor = icons.Constructor .. " ",
      Enum = icons.Enum .. " ",
      EnumMember = icons.EnumMember .. " ",
      Event = icons.Event .. " ",
      Field = icons.Field .. " ",
      File = icons.File .. " ",
      Folder = icons.Folder .. " ",
      Function = icons.Function .. " ",
      Interface = icons.Interface .. " ",
      Key = icons.Key .. " ",
      Keyword = icons.Keyword .. " ",
      Method = icons.Method .. " ",
      Module = icons.Module .. " ",
      Namespace = icons.Namespace .. " ",
      Null = icons.Null .. " ",
      Number = icons.Number .. " ",
      Object = icons.Object .. " ",
      Operator = icons.Operator .. " ",
      Package = icons.Package .. " ",
      Property = icons.Property .. " ",
      Reference = icons.Reference .. " ",
      Snippet = icons.Snippet .. " ",
      String = icons.String .. " ",
      Struct = icons.Struct .. " ",
      Text = icons.Text .. " ",
      TypeParameter = icons.TypeParameter .. " ",
      Unit = icons.Unit .. " ",
      Value = icons.Value .. " ",
      Variable = icons.Variable .. " ",
    },
    highlight = true,
    separator = " " .. icons.ChevronRight .. " ",
    depth_limit = 0,
    depth_limit_indicator = "..",
  },
}

local M = {}

M.setup = function()
  local status_ok, navic = pcall(require, "nvim-navic")
  if not status_ok then
    return
  end

  M.create_winbar()
  navic.setup(opts)
end

M.get_filename = function()
  local filename = vim.fn.expand "%:t"
  local extension = vim.fn.expand "%:e"

  if not M.isempty(filename) then
    local file_icon, file_icon_color =
        require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })

    local hl_group = "FileIconColor" .. extension

    vim.api.nvim_set_hl(0, hl_group, { fg = file_icon_color })
    if M.isempty(file_icon) then
      file_icon = icons.File
    end

    local buf_ft = vim.bo.filetype

    if buf_ft == "dapui_breakpoints" then
      file_icon = icons.Bug
    end

    if buf_ft == "dapui_stacks" then
      file_icon = icons.Stacks
    end

    if buf_ft == "dapui_scopes" then
      file_icon = icons.Scopes
    end

    if buf_ft == "dapui_watches" then
      file_icon = icons.Watches
    end

    local navic_text = vim.api.nvim_get_hl_by_name("Normal", true)
    vim.api.nvim_set_hl(0, "Winbar", { fg = navic_text.foreground })

    return " " .. "%#" .. hl_group .. "#" .. file_icon .. "%*" .. " " .. "%#Winbar#" .. filename .. "%*"
  end
end

local get_gps = function()
  local status_gps_ok, gps = pcall(require, "nvim-navic")
  if not status_gps_ok then
    return ""
  end

  local status_ok, gps_location = pcall(gps.get_location, {})
  if not status_ok then
    return ""
  end

  if not gps.is_available() or gps_location == "error" then
    return ""
  end

  if not M.isempty(gps_location) then
    return "%#NavicSeparator#" .. icons.ChevronRight .. "%* " .. gps_location
  else
    return ""
  end
end

local excludes = function()
  return vim.tbl_contains({
    "help",
    "startify",
    "dashboard",
    "packer",
    "neo-tree",
    "neogitstatus",
    "NvimTree",
    "Trouble",
    "alpha",
    "lir",
    "Outline",
    "spectre_panel",
    "toggleterm",
    "DressingSelect",
    "Jaq",
    "harpoon",
    "dap-repl",
    "dap-terminal",
    "dapui_console",
    "lab",
    "Markdown",
    "notify",
    "noice",
    "",

  }, vim.bo.filetype)
end

function M.smart_quit()
  local bufnr = vim.api.nvim_get_current_buf()
  local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
  if modified then
    vim.ui.input({
      prompt = "You have unsaved changes. Quit anyway? (y/n) ",
    }, function(input)
      if input == "y" then
        vim.cmd "q!"
      end
    end)
  else
    vim.cmd "q!"
  end
end

function M.isempty(s)
  return s == nil or s == ""
end

function M.get_buf_option(opt)
  local status_ok, buf_option = pcall(vim.api.nvim_buf_get_option, 0, opt)
  if not status_ok then
    return nil
  else
    return buf_option
  end
end

M.get_winbar = function()
  if excludes() then
    return
  end
  local value = M.get_filename()

  local gps_added = false
  if not M.isempty(value) then
    local gps_value = get_gps()
    value = value .. " " .. gps_value
    if not M.isempty(gps_value) then
      gps_added = true
    end
  end

  if not M.isempty(value) and M.get_buf_option "mod" then
    local mod = "%#LspCodeLens#" .. icons.Circle .. "%*"
    if gps_added then
      value = value .. " " .. mod
    else
      value = value .. mod
    end
  end

  local num_tabs = #vim.api.nvim_list_tabpages()

  if num_tabs > 1 and not M.isempty(value) then
    local tabpage_number = tostring(vim.api.nvim_tabpage_get_number(0))
    value = value .. "%=" .. tabpage_number .. "/" .. tostring(num_tabs)
  end

  local status_ok, _ = pcall(vim.api.nvim_set_option_value, "winbar", value, { scope = "local" })
  if not status_ok then
    return
  end
end

M.create_winbar = function()
  vim.api.nvim_create_augroup("_winbar", {})
  if vim.fn.has "nvim-0.8" == 1 then
    vim.api.nvim_create_autocmd(
      { "CursorHoldI", "CursorHold", "BufWinEnter", "BufFilePost", "InsertEnter", "BufWritePost", "TabClosed" },
      {
        group = "_winbar",
        callback = function()
          local status_ok, _ = pcall(vim.api.nvim_buf_get_var, 0, "lsp_floating_window")
          if not status_ok then
            -- TODO:
            M.get_winbar()
          end
        end,
      }
    )
  end
end

M.setup()
