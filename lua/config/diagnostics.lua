-- 1. Configure Nerd Font Symbols for Diagnostics
-- This uses Neovim's built-in diagnostic configuration.
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
        },
        linehl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticErrorLn",
            [vim.diagnostic.severity.WARN]  = "DiagnosticWarnLn",
            [vim.diagnostic.severity.INFO]  = "DiagnosticInfoLn",
            [vim.diagnostic.severity.HINT]  = "DiagnosticHintLn",
        },
        numhl = {
            [vim.diagnostic.severity.WARN] = 'WarningMsg',
        },
    },
    underline = true, -- Underline the diagnostic range
    update_in_insert = false, -- Don't update diagnostics in insert mode
    float = {
        focusable = true,
        style = 'minimal',
        border = 'single',
        source = 'always',
        header = 'Diagnostic',
        prefix = '',
    },
    
})

-- 2. Define Highlight Groups for Line Highlighting
-- You can choose any colors you like. These are just examples.
vim.api.nvim_set_hl(0, "DiagnosticErrorLn", { bg = "#440000" }) -- Dark red background for errors
vim.api.nvim_set_hl(0, "DiagnosticWarnLn", { bg = "#444400" }) -- Dark yellow background for warnings
vim.api.nvim_set_hl(0, "DiagnosticInfoLn", { bg = "#004444" }) -- Dark cyan background for info
vim.api.nvim_set_hl(0, "DiagnosticHintLn", { bg = "#444444" }) -- Dark gray background for hints

-- 3. Autocommand to Highlight Lines with Diagnostics
-- This autocommand will run whenever the buffer is read, entered, or the cursor is idle.
-- It will check for diagnostics on the current line and apply the appropriate highlight.
vim.api.nvim_create_autocmd({ "BufReadPost", "BufEnter", "CursorHold", "CursorHoldI" }, {
  group = vim.api.nvim_create_augroup("DiagnosticLineHighlighter", { clear = true }),
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local current_line = vim.api.nvim_win_get_cursor(0)[1] - 1 -- 0-indexed line number

    -- Clear previous highlights from this autocommand group on the current line
    -- This is important to prevent highlights from stacking or persisting incorrectly
    vim.api.nvim_buf_clear_namespace(bufnr, vim.api.nvim_create_namespace("diagnostic_line_highlight"), current_line, current_line + 1)

    local diagnostics = vim.diagnostic.get(bufnr)
    local has_error = false
    local has_warning = false

    for _, diag in ipairs(diagnostics) do
      if diag.lnum == current_line then
        if diag.severity == vim.diagnostic.severity.ERROR then
          has_error = true
          break -- Error takes precedence, so we can stop
        elseif diag.severity == vim.diagnostic.severity.WARN then
          has_warning = true
        end
      end
    end

    local highlight_group = nil
    if has_error then
      highlight_group = "DiagnosticLineError"
    elseif has_warning then
      highlight_group = "DiagnosticLineWarning"
    end

    if highlight_group then
      -- Apply the highlight to the entire current line
      vim.api.nvim_buf_add_highlight(
        bufnr,
        vim.api.nvim_create_namespace("diagnostic_line_highlight"), -- Unique namespace for our highlights
        highlight_group,
        current_line,
        0, -- Start column
        -1 -- End column (-1 means till the end of the line)
      )
    end
  end,
})

-- Optional: Clear line highlights when leaving a buffer or closing Neovim
vim.api.nvim_create_autocmd({ "BufLeave", "VimLeave" }, {
  group = vim.api.nvim_create_augroup("DiagnosticLineHighlighterCleanup", { clear = true }),
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_clear_namespace(bufnr, vim.api.nvim_create_namespace("diagnostic_line_highlight"), 0, -1) -- Clear all
  end,
})

-- Optional: A function to jump between diagnostics (useful when you have them)
-- You can map these to keys in your init.lua

-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
-- vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Set quickfix list with diagnostics" })

-- print("Nerd Font diagnostic symbols and line highlighting configured.")
