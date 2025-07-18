-- Basic configuration for Neovim
require('config.config')

-- Load settings for nvim diagnostics
require('config.diagnostics')

-- Initialize lazy.nvim and load plugins in lua/plugins
require('config.lazy')

-- Setup LSP configs
require('config.lspsetup')
