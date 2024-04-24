if vim.g.vscode then
  local vscode = require('vscode-neovim')
  local mappings = {
    up = 'k',
    down = 'j',
    wrappedLineStart = '0',
    wrappedLineFirstNonWhitespaceCharacter = '^',
    wrappedLineEnd = '$',
  }

  local function moveCursor(to, select)
    return function()
      local mode = vim.api.nvim_get_mode()
      if mode.mode == 'V' or mode.mode == '' then
        return mappings[to]
      end

      vscode.action('cursorMove', {
        args = {
          {
            to = to,
            by = 'wrappedLine',
            value = vim.v.count1,
            select = select
          },
        },
      })
      return '<Ignore>'
    end
  end

  vim.keymap.set('n', 'k', moveCursor('up'), { expr = true })
  vim.keymap.set('n', 'j', moveCursor('down'), { expr = true })
  vim.keymap.set('n', '0', moveCursor('wrappedLineStart'), { expr = true })
  vim.keymap.set('n', '^', moveCursor('wrappedLineFirstNonWhitespaceCharacter'), { expr = true })
  vim.keymap.set('n', '$', moveCursor('wrappedLineEnd'), { expr = true })

  vim.keymap.set('v', 'k', moveCursorIn('up', true), { expr = true })
  vim.keymap.set('v', 'j', moveCursorIn('down', true), { expr = true })
  vim.keymap.set('v', '0', moveCursorIn('wrappedLineStart', true), { expr = true })
  vim.keymap.set('v', '^', moveCursorIn('wrappedLineFirstNonWhitespaceCharacter', true), { expr = true })
  vim.keymap.set('v', '$', moveCursorIn('wrappedLineEnd', true), { expr = true })
end

vim.notify('initialization complated')
