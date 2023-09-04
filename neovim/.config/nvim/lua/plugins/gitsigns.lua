return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = function()
    return {
      signs = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
        untracked = { text = '▎' },
      },
      preview_config = {
        border = 'double',
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

        map({ 'n', 'v' }, '<leader>gs', ':Gitsigns stage_hunk<CR>', 'stage hunk')
        map({ 'n', 'v' }, '<leader>gr', ':Gitsigns reset_hunk<CR>', 'reset hunk')
        map('n', '<leader>gu', gs.undo_stage_hunk, 'undo stage hunk')
        map('n', '<leader>gS', gs.stage_buffer, 'stage buffer')
        map('n', '<leader>gR', gs.reset_buffer, 'reset buffer')
        map('n', '<leader>gp', gs.preview_hunk, 'preview hunk')
        map('n', '<leader>gb', function()
          gs.blame_line({ full = true })
        end, 'blame line')
        map('n', '<leader>gd', gs.diffthis, 'diff this')
        map('n', '<leader>gD', function()
          gs.diffthis('~')
        end, 'diff this ~')
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'select hunk')
        map({ 'o', 'x' }, 'ah', ':<C-U>Gitsigns select_hunk<CR>', 'select hunk')
        map('n', '[h', gs.next_hunk, 'Next hunk')
        map('n', ']h', gs.prev_hunk, 'Previous hunk')
      end,
    }
  end,
}
