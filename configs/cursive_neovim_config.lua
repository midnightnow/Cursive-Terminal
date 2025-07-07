-- Cursive Neovim Configuration
-- Beautiful setup for cursive programming fonts

-- Font settings
vim.opt.guifont = "Victor Mono:h14:i"  -- Cursive italic

-- Enable ligatures if using Neovide or similar GUI
if vim.g.neovide then
    vim.g.neovide_cursor_vfx_mode = "railgun"
    vim.g.neovide_cursor_animation_length = 0.05
    vim.g.neovide_cursor_trail_length = 0.8
    vim.g.neovide_transparency = 0.95
    vim.g.neovide_floating_blur_amount_x = 2.0
    vim.g.neovide_floating_blur_amount_y = 2.0
end

-- Enhanced syntax highlighting for cursive
vim.cmd([[
  " Make comments italic (cursive)
  highlight Comment gui=italic cterm=italic
  
  " Make strings italic in cursive fonts
  highlight String gui=italic cterm=italic
  
  " Keywords in bold italic
  highlight Keyword gui=bold,italic cterm=bold,italic
  
  " Function names in italic
  highlight Function gui=italic cterm=italic
  
  " Types in italic
  highlight Type gui=italic cterm=italic
  
  " Make operators elegant
  highlight Operator gui=bold cterm=bold
  
  " Constants in italic
  highlight Constant gui=italic cterm=italic
  
  " Special characters
  highlight Special gui=bold,italic cterm=bold,italic
]])

-- Cursive-friendly colorscheme adjustments
local function setup_cursive_highlights()
    local highlights = {
        Comment = { italic = true, fg = "#6B5B95" },
        String = { italic = true, fg = "#4ECDC4" },
        Keyword = { bold = true, italic = true, fg = "#FFD700" },
        Function = { italic = true, fg = "#FF6B6B" },
        Type = { italic = true, fg = "#C44569" },
        Constant = { italic = true, fg = "#88D8B0" },
        Special = { bold = true, italic = true, fg = "#FFD700" },
        Identifier = { italic = true },
        PreProc = { italic = true, fg = "#6B5B95" },
        Statement = { bold = true, italic = true },
    }
    
    for group, opts in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, opts)
    end
end

-- Apply cursive highlights
setup_cursive_highlights()

-- Treesitter configuration for better syntax highlighting
local ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if ok then
    treesitter.setup {
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = {
            enable = true
        }
    }
end

-- LSP configuration with cursive-friendly signs
local signs = {
    Error = "✗",
    Warn = "⚠",
    Hint = "💡",
    Info = "ℹ"
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

print("Cursive Neovim configuration loaded! ✒️")