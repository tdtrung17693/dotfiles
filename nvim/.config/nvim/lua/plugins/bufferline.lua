require('bufferline')


require('bufferline').setup({
  options = {
    always_show_bufferline = true,
    numbers = "none",
    show_buffer_icons = true,
    show_buffer_close_icons = false,
    show_close_icon = false,
    separator_style = 'thin',
    -- Don't show bufferline over vertical, unmodifiable buffers
    offsets = {{
        filetype = 'NvimTree',
        text = 'File Explorer',
        highlight = 'Directory'
    }},
  },
  -- Don't use italic on current buffer
  highlights = {buffer_selected = { bold = true },},
})
