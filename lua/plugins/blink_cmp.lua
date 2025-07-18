return {
    {
        'saghen/blink.cmp',
        version = '*',
        opts = {
            keymap = { preset = 'super-tab' },
            sources = {
                default = {'lsp', 'path', 'snippets', 'omni', 'buffer'},
            },
            completion = {
                list = { selection = {
                    auto_insert = true
                }},
            },
        },
        signature = { enabled = true }
    },
}
