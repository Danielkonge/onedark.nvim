local M = {}

---Change onedark option (vim.g.onedark_config.option)
---It can't be changed directly by modifying that field due to a Neovim lua bug with
---global variables (onedark_config is a global variable)
---@param opt string: option name
---@param value any: new value
function M.set_options(opt, value)
    local cfg = vim.g.onedark_config
    cfg[opt] = value
    vim.g.onedark_config = cfg
end

---Apply the colorscheme (same as ':colorscheme onedark')
function M.colorscheme()
    vim.cmd("hi clear")
    if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end
    vim.o.termguicolors = true
    vim.g.colors_name = "onedark"
    require('onedark.highlights').setup()
    require('onedark.terminal').setup()
end

local default_config = {
    -- Main options --
    transparent = true,   -- don't set background
    term_colors = true,   -- if true enable the terminal
    ending_tildes = true, -- show the end-of-buffer tildes

    -- Changing Formats --
    code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none',
        documentation = 'italic,bold',
    },

    -- Lualine options --
    lualine = {
        transparent = true, -- center bar (c) transparency
    },

    -- Custom Highlights --
    colors = {},     -- Override default colors
    highlights = {}, -- Override highlight groups

    -- Plugins Related --
    diagnostics = {
        darker = true,      -- darker colors for diagnostic
        undercurl = true,   -- use undercurl for diagnostics
        background = false, -- use background color for virtual text
    },
}

---Setup onedark.nvim options, without applying colorscheme
---@param opts? table: a table containing options
function M.setup(opts)
    if not vim.g.onedark_config or not vim.g.onedark_config.loaded then
        -- if it's the first time setup() is called
        vim.g.onedark_config = vim.tbl_deep_extend('keep', vim.g.onedark_config or {}, default_config)
        M.set_options('loaded', true)
    end
    if opts then
        vim.g.onedark_config = vim.tbl_deep_extend('force', vim.g.onedark_config, opts)
    end
end

function M.load()
    vim.api.nvim_command('colorscheme onedark')
end

return M
