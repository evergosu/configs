local vitestCommand = 'pnpm vitest run'

return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      { 'evergosu/neotest-vitest', { dir = '~/projects/neotest-vitest' } },
    },
    keys = function()
      require('which-key').add({ '<leader>t', group = 'test' })

      local function runOnTestOrNearest(callback, opts)
        local file

        local currentFile = vim.fn.expand('%:p')

        if string.match(currentFile, '%.test%.') or string.match(currentFile, '%.spec%.') then
          file = currentFile
        else
          local testFile = vim.fn.expand('%:r') .. '.test.' .. vim.fn.expand('%:e')
          local specFile = vim.fn.expand('%:r') .. '.spec.' .. vim.fn.expand('%:e')

          if vim.loop.fs_stat(testFile) then
            file = testFile
            vim.cmd.edit(file)
          elseif vim.loop.fs_stat(specFile) then
            file = specFile
            vim.cmd.edit(file)
          else
            vim.notify('No nearest test files', vim.log.levels.WARN)
          end
        end

        table.insert(opts or {}, 1, file)
        callback(opts)
        require('neotest').summary.open()
      end

      return {
        {
          '<leader>tf',
          function()
            runOnTestOrNearest(require('neotest').run.run)
          end,
          desc = 'run file tests',
        },
        {
          '<leader>tt',
          function()
            require('neotest').run.run(
              vim.fs.dirname(vim.fs.find('.git', { path = vim.fn.expand('%'), upward = true })[1])
            )
            require('neotest').summary.open()
          end,
          desc = 'run all',
        },
        {
          '<leader>tw',
          function()
            require('neotest').watch.toggle(vim.fn.expand('%'))
          end,
          desc = 'watch toggle',
        },
        {
          '<leader>tW',
          function()
            require('neotest').watch.toggle(
              vim.fs.dirname(vim.fs.find('.git', { path = vim.fn.expand('%'), upward = true })[1])
            )
          end,
          desc = 'watch toggle',
        },
        {
          '<leader>ta',
          function()
            require('neotest').run.stop()
          end,
          desc = 'abort',
        },
        {
          '<leader>tl',
          function()
            require('neotest').run.run_last()
          end,
          desc = 'last',
        },
        {
          '<leader>ts',
          function()
            require('neotest').summary.toggle()
          end,
          desc = 'summary toggle',
        },
        {
          '<leader>to',
          function()
            require('neotest').output_panel.toggle()
          end,
          desc = 'output toggle',
        },
        {
          '<leader>td',
          function()
            runOnTestOrNearest(require('neotest').run.run, { strategy = 'dap' })
          end,
          desc = 'debug',
        },
        {
          '[t',
          function()
            require('neotest').jump.prev({ status = 'failed' })
          end,
          desc = 'previous failed test',
        },
        {
          ']t',
          function()
            require('neotest').jump.next({ status = 'failed' })
          end,
          desc = 'next failed test',
        },
      }
    end,
    config = function()
      require('neotest').setup({
        consumers = {
          trouble = function(client)
            client.listeners.results = function(adapter_id, results, partial)
              if partial then
                return
              end
              local tree = assert(client:get_position(nil, { adapter = adapter_id }))

              local failed = 0
              for pos_id, result in pairs(results) do
                if result.status == 'failed' and tree:get_key(pos_id) then
                  failed = failed + 1
                end
              end
              vim.schedule(function()
                local trouble = require('trouble')
                if trouble.is_open() then
                  trouble.refresh()
                  if failed == 0 then
                    trouble.close()
                  end
                end
              end)
            end
            return {}
          end,
        },
        adapters = {
          require('neotest-vitest')({
            root = vim.fs.dirname(vim.fs.find('.git', { path = vim.fn.expand('%:p'), upward = true })[1]),
            filter_dir = function(name)
              return name ~= 'node_modules' and name ~= 'dist'
            end,
            vitestCommand = vitestCommand,
            typecheck = {
              enabled = true,
            },
          }),
        },
        default_strategy = 'integrated',
        floating = { border = 'double' },
        output = { open_on_run = true },
        quickfix = {
          enabled = true,
          open = function()
            vim.cmd('Trouble quickfix toggle')
          end,
        },
      })
    end,
  },
}
