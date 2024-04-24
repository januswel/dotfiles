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

  vim.keymap.set('v', 'k', moveCursor('up', true), { expr = true })
  vim.keymap.set('v', 'j', moveCursor('down', true), { expr = true })
  vim.keymap.set('v', '0', moveCursor('wrappedLineStart', true), { expr = true })
  vim.keymap.set('v', '^', moveCursor('wrappedLineFirstNonWhitespaceCharacter', true), { expr = true })
  vim.keymap.set('v', '$', moveCursor('wrappedLineEnd', true), { expr = true })
end

vim.notify('initialization complated')
