--[[
Atharva Patil's Neovim Configuration
Email: atharvap4til@gmail.com
Github: https://github.com/patilatharva
--]]

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
vim.opt.rtp:prepend(lazypath)

local langs = {
    'python',
    'go',
    'gomod',
    'java',
    'html',
    'javascript',
    'lua'
}

require('lazy').setup({
    {
        'folke/tokyonight.nvim',
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require('tokyonight').setup({
                style = "storm",
                styles = {
                    comments = { italic = true },
                }
            })

            vim.cmd[[colorscheme tokyonight]]
        end
    },
    'lewis6991/impatient.nvim',
    {
        'lf-lang/lingua-franca.vim',
    },
    {
        'dstein64/vim-startuptime',
        cmd = "StartupTime",
    },
    'nvim-lua/plenary.nvim',
    {
        'kyazdani42/nvim-web-devicons',
        dependencies = {
            'nvim-telescope/telescope.nvim',
            'utilyre/barbecue.nvim'
        },
        config = true,
    },
    {
        'marko-cerovac/material.nvim',
        config = true,
        event = 'VeryLazy'
    },
    {
        'nvim-telescope/telescope.nvim',
        cmd = "Telescope",
        dependencies = {
            'nvim-telescope/telescope-file-browser.nvim'
        },
        config = function()
            require('telescope').setup {
                extensions = {
                    file_browser = {
                        -- theme = 'ivy',
                        -- disables netrw and use telescope-file-browser in its place
                        hijack_netrw = true,
                        mappings = {
                            ['i'] = {
                                -- your custom insert mode mappings
                            },
                            ['n'] = {
                                -- your custom normal mode mappings
                            },
                        },
                    },
                },
            }
            require('telescope').load_extension 'file_browser'
        end,
    },
    {
        'nvim-telescope/telescope-file-browser.nvim',
        cmd="Telescope",
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require'nvim-treesitter.configs'.setup {
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = langs,
                },
                ensure_installed = langs,
            }
        end,
    },
    {
        'kyazdani42/nvim-tree.lua',
        -- event = "VeryLazy",
        config = function()
            local M = {}
            local api = require("nvim-tree.api")
            function M.on_attach()
                vim.keymap.set('n', '<Tab>',
                function(node)
                    api.node.open.edit(node)
                    api.tree.focus()
                end
                )
            end

            require('nvim-tree').setup({
                update_focused_file = {enable = true, update_cwd = false},
                on_attach = M.on_attach,
                git = {ignore = false},
                renderer = { indent_markers = { enable = true } },
                filters = {
                    custom = {
                        '*.pyc', '.DS_Store', 'node_modules', '__pycache__', 'venv', '.git',
                        '*.dSYM'
                    },
                    dotfiles = true
                },
                view = {
                    mappings = {
                        list = {
                            {key = "<CR>",          action = "tabnew"}
                        }
                    },
                },
                actions = {
                    file_popup = {
                        open_win_config = {
                            border = "rounded"
                        }
                    }
                }
            })
        end,
    },
    -- {
    --     'startup-nvim/startup.nvim',
    --     config=true
    -- },
    -- {
    --     'startup-nvim/startup.nvim',
    --     -- dependencies = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
    --     config = true,
    --     commit = 'e46ff423a40753980788c106162eb91f7ada2364',
        -- config = function()
            -- require"startup".setup({theme = "evil_custom"})
            -- require'startup'.setup({
            --     header = {
            --         type = "text",
            --         align = "center",
            --         fold_section = false,
            --         title = "Header",
            --         margin = 5,
            --         content = require("startup.headers").hydra_header,
            --         highlight = "@variable.builtin",
            --         default_color = "",
            --         oldfiles_amount = 0,
            --     },
            --
            --     neovim = {
            --         type = "text",
            --         oldfiles_directory = false,
            --         align = "center",
            --         fold_section = false,
            --         title = "Footer",
            --         margin = 5,
            --         content = { "neovim" },
            --         highlight = "BufferLineWarningSelected",
            --         default_color = "",
            --         oldfiles_amount = 0,
            --     },
            --     dashboard = {
            --         type = "mapping",
            --         oldfiles_directory = false,
            --         align = "center",
            --         fold_section = false,
            --         title = "Basic Commands",
            --         margin = 5,
            --         content = {
            --             { " find file", "Telescope find_files", "<leader>ff" },
            --             { " find word", "Telescope live_grep", "<leader>fg" },
            --             { " recent files", "Telescope oldfiles", "<leader>fr" },
            --             { " file browser", "Telescope file_browser", "<leader>fb" },
            --             { " colorschemes", "Telescope colorscheme", "<leader>cs" },
            --             { " new file", "lua require'startup'.new_file()", "<leader>nf" },
            --         },
            --         highlight = "@TSString",
            --         default_color = "",
            --         oldfiles_amount = 0,
            --     },
            --     clock = {
            --         type = "text",
            --         content = function()
            --             local clock = " " .. os.date("%H:%M")
            --             local date = " " .. os.date("%d-%m-%y")
            --             return { clock, date }
            --         end,
            --         oldfiles_directory = false,
            --         align = "center",
            --         fold_section = false,
            --         title = "",
            --         margin = 5,
            --         highlight = "@variable.builtin",
            --         --default_color = "#FFFFFF",
            --         default_color = "#56b6c2",
            --         oldfiles_amount = 10,
            --     },
            --
            --     footer_2 = {
            --         type = "text",
            --         content = require("startup.functions").packer_plugins(),
            --         oldfiles_directory = false,
            --         align = "center",
            --         fold_section = false,
            --         title = "",
            --         margin = 5,
            --         highlight = "@tag",
            --         default_color = "#FFFFFF",
            --         oldfiles_amount = 10,
            --     },
            --
            --     options = {
            --         after = function()
            --             require("startup.utils").oldfiles_mappings()
            --         end,
            --         mapping_keys = true,
            --         cursor_column = 0.5,
            --         empty_lines_between_mappings = true,
            --         disable_statuslines = true,
            --         paddings = { 2, 2, 2, 2, 2, 2, 2 },
            --     },
            --     colors = {
            --         background = "#1f2227",
            --         folded_section = "#56b6c2",
            --     },
            --     parts = {
            --         "header",
            --         "neovim",
            --         --    "header_2",
            --         --    "body",
            --         --    "body_2",
            --         --    "footer",
            --         "dashboard",
            --         "clock",
            --         "footer_2",
            --     },
            --
            -- })
        -- end,
    -- },
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'horizon'
                },
                sections = {
                    lualine_c = {
                        {
                            'filename',
                            file_status = true,
                            path = 2,
                        }
                    }
                },
            })
        end,
    },
    {
        'akinsho/bufferline.nvim',
        tag = 'v2.*',
        config = function()
            require('bufferline').setup{
                options = {
                    offsets = {
                        {
                            filetype = 'NvimTree',
                            text = function()
                                return vim.fn.getcwd()
                            end,
                            highlight = 'Directory',
                            text_align = 'left'
                        }
                    },
                    show_buffer_close_icons = false,
                    show_close_icon = false,
                    -- chrome style separators
                    separator_style = 'slant'
                }
            }
        end,
    },
    'SmiteshP/nvim-navic',
    {
        'neovim/nvim-lspconfig',
        config = function()
            require('lspconfig.ui.windows').default_options.border = 'single'
        end,
    },
    {
        'lewis6991/gitsigns.nvim',
        config = true
    },
    {
        'petertriho/nvim-scrollbar',
        config = true
    },
    {
        'simrat39/symbols-outline.nvim',
        config = function()
            require('symbols-outline').setup({
                symbols = {
                    File = {hl = '@text.uri' },
                    Module = {hl = '@namespace' },
                    Namespace = {hl = '@namespace' },
                    Package = {hl = '@namespace' },
                    Class = {hl = '@type' },
                    Method = {hl = '@method' },
                    Property = {hl = '@method' },
                    Field = {hl = '@field' },
                    Constructor = {hl = '@constructor' },
                    Enum = {hl = '@type' },
                    Interface = {hl = '@type' },
                    Function = {hl = '@function' },
                    Variable = {hl = '@constant' },
                    Constant = {hl = '@constant' },
                    String = {hl = '@string' },
                    Number = {hl = '@number' },
                    Boolean = {hl = '@boolean' },
                    Array = {hl = '@constant' },
                    Object = {hl = '@type' },
                    Key = {hl = '@type' },
                    Null = {hl = '@type' },
                    EnumMember = {hl = '@field' },
                    Struct = {hl = '@type' },
                    Event = {hl = '@type' },
                    Operator = {hl = '@operator' },
                    TypeParameter = {hl = '@parameter' },
                },
            })
        end,
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        config = true,
    },
    {
        'numToStr/Comment.nvim',
        config = true,
    },
    -- 'eandrju/cellular-automaton.nvim',
    {
        'ray-x/lsp_signature.nvim',
        config = function()
            require 'lsp_signature'.setup({hint_prefix=''})
        end,
    },
    {
        'utilyre/barbecue.nvim',
        config = function()
            require('barbecue').setup({
                -- attach_navic = false, -- prevent barbecue from automatically attaching nvim-navic
                options = {
                    theme = 'tokyonight',
                }
            })
        end,
    },
    {
        'hrsh7th/nvim-cmp',
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
        },
    },
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'saadparwaiz1/cmp_luasnip',
    'sindrets/diffview.nvim',
    'L3MON4D3/LuaSnip',
    {
        'm4xshen/autoclose.nvim',
        config = true
    },
    {
        'folke/twilight.nvim',
        config = function()
            require('twilight').setup({
                context = 20
            })
        end,
    },
    {
        'akinsho/toggleterm.nvim',
        config = function()
            require('toggleterm').setup{
                size = function(term)
                    if term.direction == 'horizontal' then
                        return 15
                    elseif term.direction == 'vertical' then
                        return vim.o.columns * 0.3
                    end
                end,
                open_mapping = [[<c-\>]],
                direction = 'vertical',
            }

            function _G.set_terminal_keymaps()
                local opts = {buffer = 0}
                vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
                vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
                vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
                vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
                vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
                -- vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
            end

            -- if you only want these mappings for toggle term use term://*toggleterm#* instead
            vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
        end,
    },
    {
        'rmagatti/goto-preview',
        config = true
    },
    {
        'stevearc/dressing.nvim',
        config = true
    }
})

require('impatient')
require('settings')
-- require('plugins')
require('completion')
require('lsp')
require('keymaps')
