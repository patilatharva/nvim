return require('packer').startup(function()
        -- themes
        use 'folke/tokyonight.nvim'
        use 'tiagovla/tokyodark.nvim'

        vim.cmd[[colorscheme tokyodark]]

        -- telescope
        use {
          'nvim-telescope/telescope.nvim',
          requires = { {'nvim-lua/plenary.nvim'} }
        }
        require("telescope").load_extension("emoji")
        
        use {
          'xiyaowong/telescope-emoji.nvim',
          requires = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
        }
        -- require('telescope.builtin').builtin({include_extensions = true})
        vim.keymap.set('n', '<leader>t', function()
          require('telescope.builtin').builtin { include_extensions = true }
        end)

        -- treesitter

        use {
          'nvim-treesitter/nvim-treesitter',
          run = ':TSUpdate'
        }        

        -- devicons
        require'nvim-web-devicons'.setup {
                default = true;
        }

        -- nvim-tree
        use {
            'kyazdani42/nvim-tree.lua',
            requires = {
              'kyazdani42/nvim-web-devicons', -- optional, for file icon
            },
            tag = 'nightly' -- optional, updated every week. (see issue #1193)
        }
        require('nvim-tree').setup({
            update_focused_file = {enable = true, update_cwd = false}, 
            hijack_cursor = true,
            open_on_tab = true,
            git = {ignore = false},
            renderer = { indent_markers = { enable = true } },
            filters = {
                custom = {
                    '*.pyc', '.DS_Store', 'node_modules', '__pycache__', 'venv', '.git',
                    '*.dSYM'
                }
            },
            view = {
                mappings = {
                    list = {
                        {key = "<CR>",          action = "tabnew"}
                    }
                }
            }
        })
        -- startup.nvim
        use {
            "startup-nvim/startup.nvim",
            requires = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
        }
        require"startup".setup({theme = "evil_custom"})

        -- lualine
        use {
            'nvim-lualine/lualine.nvim',
            requires = { 'kyazdani42/nvim-web-devicons', opt = true }
        }
        require('lualine').setup({
            options = {
                theme = 'horizon'
            },
            sections = {
                lualine_x = { 
                    require('weather.lualine').default_c({}) 
                }
            }
        })

        -- weather.nvim
        use {
            'wyattjsmith1/weather.nvim',
            requires = {
                "nvim-lua/plenary.nvim",
            }
        }

        require'weather'.setup {
            openweathermap = {
            app_id = {
                value = "b06e759f9769b38583ee0a79998b3ca9"
            }
            },
            weather_icons = require('weather.other_icons').nerd_font,
        }

        -- bufferline
        use {
            'akinsho/bufferline.nvim', tag = "v2.*", 
            requires = 'kyazdani42/nvim-web-devicons'
        }
        require("bufferline").setup{
            options = {
                offsets = {
                  {
                    filetype = "NvimTree",
                    text = function()
                      return vim.fn.getcwd()
                    end,
                    highlight = "Directory",
                    text_align = "left"
                  }
                },
                show_buffer_close_icons = false,
                show_close_icon = false,
                -- chrome style separators
                -- separator_style = "slant"
            }
        }
end)
