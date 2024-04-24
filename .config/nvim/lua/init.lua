if vim.g.vscode then
  local vscode = require('vscode-neovim')
  local function moveCursor(to, select)
    return function()
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

  local table = {
    up = 'k',
    down = 'j',
    wrappedLineStart = '0',
    wrappedLineFirstNonWhitespaceCharacter = '^',
    wrappedLineEnd = '$',
  }

  local function moveCursorInVisualMode(to)
    return function()
      local mode = vim.api.nvim_get_mode()
      if mode.mode == 'V' or mode.mode == '' then
        return table[to]
      end

      vscode.action('cursorMove', {
        args = {
          {
            to = to,
            by = 'wrappedLine',
            value = vim.v.count1,
            select = true
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

  vim.keymap.set('v', 'k', moveCursorInVisualMode('up', true), { expr = true })
  vim.keymap.set('v', 'j', moveCursorInVisualMode('down', true), { expr = true })
  vim.keymap.set('v', '0', moveCursorInVisualMode('wrappedLineStart', true), { expr = true })
  vim.keymap.set('v', '^', moveCursorInVisualMode('wrappedLineFirstNonWhitespaceCharacter', true), { expr = true })
  vim.keymap.set('v', '$', moveCursorInVisualMode('wrappedLineEnd', true), { expr = true })
end

vim.notify('initialization complated')
