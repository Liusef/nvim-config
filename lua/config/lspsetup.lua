-- This file must be loaded after lazy.nvim
-- local lspconfig = require('lspconfig')

-- Automated LSP setup for Neovim using lspconfig
local capabilities = require('blink.cmp').get_lsp_capabilities()

-- Enable LSP for a given server and config
local lsp_setup = function(server, config)
    vim.lsp.config(server, config)
    vim.lsp.enable(server)
end

-- Enable LSP with no additional config other than capabilities
local lsp_basic = function(server)
    lsp_setup(server, {capabilities = capabilities})
end


lsp_basic("clangd")
lsp_basic("pyright")
lsp_basic("gopls")
lsp_basic("ts_ls")

-- Manual LSP setup for bash
lsp_setup('bashls', {
  filetypes = { 'bash', 'sh', 'zsh', 'bashrc', 'zshrc' },
  capabilities = capabilities
})

-- Manual LSP setup for lua
lsp_setup('lua_ls', {
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          "vim",
          'require'
        },
      },
      workspace = { library = vim.api.nvim_get_runtime_file("", true) },
      telemetry = { enable = false },
    },
  },
})


