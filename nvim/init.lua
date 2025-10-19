vim.opt.tabstop = 4         -- Display 4 spaces for a tab character
vim.opt.shiftwidth = 4      -- Indent and unindent by 4 spaces
vim.opt.expandtab = true    -- Use spaces instead of tabs
vim.opt.softtabstop = 4     -- Add/remove 4 whitespaces when pressing Tab/Backspace

require("config.lazy")

vim.opt.termguicolors = true

vim.cmd.colorscheme('tokyonight')

vim.lsp.config('luals', {})
vim.lsp.enable("luals")
vim.lsp.enable("clangd")

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
        vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }    
        vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

vim.diagnostic.config({ virtual_text = true })

-- run file
vim.keymap.set('n', '<leader>r', function()
  local file = vim.fn.expand('%')
  local cmd = string.format('pbpaste > a.in && ./run.sh %s', file)
  vim.cmd('! ' .. cmd)
end, { desc = 'Run ./run.sh with current file and pbpaste input' })

-- copy into system clipboard
vim.opt.clipboard = "unnamedplus"

