return require('packer').startup(function(use)
    -- packer
    use 'wbthomason/packer.nvim'

    -- impatient
    use 'lewis6991/impatient.nvim'

    -- fugitive
    use 'tpope/vim-fugitive'

    -- lingua-franca
    use 'lf-lang/lingua-franca.vim'

    -- startup-time
    use 'dstein64/vim-startuptime'

    -- themes
    use 'folke/tokyonight.nvim'
    require('tokyonight').setup({
        styles = {
            comments = { italic = true },
        }
    })

    use 'nvim-lua/plenary.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'marko-cerovac/material.nvim'
    vim.g.material_style = "deep ocean"
    require('material').setup({
        contrast = {
            floating_windows = true,
            -- non_current_windows = true
        },
        italics = {
            comments = true,
        },
        high_visibility = {
            darker = true
        }
    })

    -- telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter'

        }
    }

    -- treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    local langs = {
        'org',
        'python',
        'go',
        'gomod',
        'java',
        'html',
        'javascript',
    }

    require'nvim-treesitter.configs'.setup {
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = langs,
        },
        ensure_installed = langs,
    }

    -- devicons
    require'nvim-web-devicons'.setup {
        default = true
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
            },
            dotfiles = true
        },
        view = {
            mappings = {
                list = {
                    {key = "<CR>",          action = "tabnew"}
                }
            }
        },
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

    -- local navic = require("nvim-navic")

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
        -- winbar = {
        --     lualine_c = {
        --         -- { navic.get_location, navic.is_available},
        --         {"filesize"}
        --     }
        -- },
    })

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
            separator_style = "slant"
        }
    }

    -- nvim-navic
    use {
        "SmiteshP/nvim-navic",
        requires = {"neovim/nvim-lspconfig"}
    }

    -- LSP configs
    use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
    require('lspconfig.ui.windows').default_options.border = 'single'

    -- gitsigns
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    }
    -- TODO: keybindings

    -- nvim-scrollbar
    use("petertriho/nvim-scrollbar")
    require("scrollbar").setup()

    -- symbols-outline
    use 'simrat39/symbols-outline.nvim'

    require("symbols-outline").setup({
        symbols = {
            File = {hl = "@text.uri" },
            Module = {hl = "@namespace" },
            Namespace = {hl = "@namespace" },
            Package = {hl = "@namespace" },
            Class = {hl = "@type" },
            Method = {hl = "@method" },
            Property = {hl = "@method" },
            Field = {hl = "@field" },
            Constructor = {hl = "@constructor" },
            Enum = {hl = "@type" },
            Interface = {hl = "@type" },
            Function = {hl = "@function" },
            Variable = {hl = "@constant" },
            Constant = {hl = "@constant" },
            String = {hl = "@string" },
            Number = {hl = "@number" },
            Boolean = {hl = "@boolean" },
            Array = {hl = "@constant" },
            Object = {hl = "@type" },
            Key = {hl = "@type" },
            Null = {hl = "@type" },
            EnumMember = {hl = "@field" },
            Struct = {hl = "@type" },
            Event = {hl = "@type" },
            Operator = {hl = "@operator" },
            TypeParameter = {hl = "@parameter" },
        },
    })

    -- indent-blankline 
    use { 'lukas-reineke/indent-blankline.nvim' }
    require('indent_blankline').setup()

    -- comment.nvim
    use { 'numToStr/Comment.nvim' }
    require('Comment').setup()

    -- markdown-preview
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })

    -- cellular-automation.nvim
    use 'eandrju/cellular-automaton.nvim'
    vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")

    -- lsp_signature.nvim
    use "ray-x/lsp_signature.nvim"
    require "lsp_signature".setup({hint_prefix=""})

    -- barbecue
    use({
        "utilyre/barbecue.nvim",
        requires = {
            "neovim/nvim-lspconfig",
            "smiteshp/nvim-navic",
            "kyazdani42/nvim-web-devicons", -- optional dependency
        },
        after = "nvim-web-devicons", -- keep this if you're using NvChad
        config = function()
            require("barbecue").setup()
        end,
    })

    require("barbecue").setup({
        attach_navic = false, -- prevent barbecue from automatically attaching nvim-navic
    })

    -- LuaSnip
    use({"L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*"})

    -- nvim-cmp
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'saadparwaiz1/cmp_luasnip'

    -- diffview
    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

    -- autoclose
    use 'm4xshen/autoclose.nvim'
    require("autoclose").setup({})

    -- twilight
    use {
        "folke/twilight.nvim",
        config = function()
            require("twilight").setup({
                context = 20
            })
        end
    }

    -- toggleterm
    use {"akinsho/toggleterm.nvim", tag = '*', config = function()
        require("toggleterm").setup()
    end}
    require("toggleterm").setup{
        size = function(term)
            if term.direction == "horizontal" then
                return 15
            elseif term.direction == "vertical" then
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
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    end

    -- if you only want these mappings for toggle term use term://*toggleterm#* instead
    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

    -- goto-preview
    use {
        'rmagatti/goto-preview',
        config = function()
            require('goto-preview').setup {}
        end
    }

end)

