local settings = {
    -- every line should be same width without escaped \
    header = {
        type = "text",
        align = "center",
        fold_section = false,
        title = "Header",
        margin = 5,
        content = require("startup.headers").hydra_header,
        highlight = "@variable.builtin",
        default_color = "",
        oldfiles_amount = 0,
    },
    
    neovim = {
        type = "text",
        oldfiles_directory = false,
        align = "center",
        fold_section = false,
        title = "Footer",
        margin = 5,
        content = { "neovim" },
        highlight = "BufferLineWarningSelected",
        default_color = "",
        oldfiles_amount = 0,
    },
   dashboard = {
        type = "mapping",
        oldfiles_directory = false,
        align = "center",
        fold_section = false,
        title = "Basic Commands",
        margin = 5,
        content = {
            { " find file", "Telescope find_files", "<leader>ff" },
            { " find word", "Telescope live_grep", "<leader>fg" },
            { " recent files", "Telescope oldfiles", "<leader>fr" },
            { " file browser", "Telescope file_browser", "<leader>fb" },
            { " colorschemes", "Telescope colorscheme", "<leader>cs" },
            { " new file", "lua require'startup'.new_file()", "<leader>nf" },
        },
        highlight = "@TSString",
        default_color = "",
        oldfiles_amount = 0,
    },
    clock = {
        type = "text",
        content = function()
            local clock = " " .. os.date("%H:%M")
            local date = " " .. os.date("%d-%m-%y")
            return { clock, date }
        end,
        oldfiles_directory = false,
        align = "center",
        fold_section = false,
        title = "",
        margin = 5,
        highlight = "@variable.builtin",
        --default_color = "#FFFFFF",
        default_color = "#56b6c2",
        oldfiles_amount = 10,
    },

    footer_2 = {
        type = "text",
        content = require("startup.functions").packer_plugins(),
        oldfiles_directory = false,
        align = "center",
        fold_section = false,
        title = "",
        margin = 5,
        highlight = "@tag",
        default_color = "#FFFFFF",
        oldfiles_amount = 10,
    },

    options = {
        after = function()
            require("startup.utils").oldfiles_mappings()
        end,
        mapping_keys = true,
        cursor_column = 0.5,
        empty_lines_between_mappings = true,
        disable_statuslines = true,
        paddings = { 2, 2, 2, 2, 2, 2, 2 },
    },
    colors = {
        background = "#1f2227",
        folded_section = "#56b6c2",
    },
    parts = {
        "header",
        "neovim",
    --    "header_2",
    --    "body",
    --    "body_2",
    --    "footer",
        "dashboard",
        "clock",
        "footer_2",
    },
}
return settings
