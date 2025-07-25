return {
    { 'neovim/nvim-lspconfig' },
    {"nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate"},
    { "nvim-tree/nvim-web-devicons", opts = {} },
    { "j-hui/fidget.nvim", opts = {} },
    { 'HiPhish/rainbow-delimiters.nvim', submodules = false }
}
