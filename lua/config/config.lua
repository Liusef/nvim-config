vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.mouse = 'a'

vim.diagnostic.config({ virtual_text = true })

vim.cmd('hi Normal ctermbg=NONE guibg=NONE')
vim.cmd('hi NonText ctermbg=NONE guibg=NONE')


-- Make sure to setup `mapleader` and `maplocalleader` before loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- WSL Clipboard config 
if vim.fn.has("wsl") == 1 then
    vim.g.clipboard = {
        name = "WSLClipboard",
        copy = {
            ["+"] = '/mnt/c/windows/system32/clip.exe',
            ["*"] = '/mnt/c/windows/system32/clip.exe',
        },
        paste = {
            ["+"] = (function()
                return vim.fn.systemlist('/mnt/c/windows/system32/windowspowershell/v1.0/powershell.exe -NoLogo -NoProfile -c \'[Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))\'', {''}, 1) -- '1' keeps empty lines
            end),
            ["*"] = (function()
                return vim.fn.systemlist('/mnt/c/windows/system32/windowspowershell/v1.0/powershell.exe -NoLogo -NoProfile -c \'[Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))\'', {''}, 1)
            end),
        },
        cache_enabled = true
    }
end
