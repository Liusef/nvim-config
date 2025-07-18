-- This file must be loaded after lazy.nvim
local lspconfig = require('lspconfig')

-- Automated LSP setup for Neovim using lspconfig
-- Enable Lsp for some language
local lsp_setup = function(server, capabilities)
    lspconfig[server].setup({capabilities = capabilities})
end

local capabilities = require('blink.cmp').get_lsp_capabilities()

lsp_setup("lua_ls", capabilities)
lsp_setup("clangd", capabilities)
lsp_setup("pyright",  capabilities)
lsp_setup("gopls", capabilities)
lsp_setup("ts_ls", capabilities)

-- Manual LSP setup for bash
lspconfig.bashls.setup {
  filetypes = { 'bash', 'sh', 'zsh', 'bashrc', 'zshrc' },
  capabilities = capabilities
}

-- Manual LSP setup for lua
lspconfig.lua_ls.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          'vim',
          'require'
        },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

