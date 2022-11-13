return require('packer').startup(function()
        -- themes
        use 'folke/tokyonight.nvim'
        require('tokyonight').setup({
            styles = {
                comments = { italic = true },
            }
        })
        
        use 'tiagovla/tokyodark.nvim'
        use 'bluz71/vim-nightfly-guicolors'
        use({
            'rose-pine/neovim',
            as = 'rose-pine',
            tag = 'v1.*',
        })
        use "EdenEast/nightfox.nvim"

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

        vim.cmd[[colorscheme tokyonight-night]]

        -- telescope
        use {
          'nvim-telescope/telescope.nvim',
          requires = { 
                  'nvim-lua/plenary.nvim',
                  'nvim-treesitter/nvim-treesitter'
                        
          }
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

        require'nvim-treesitter.configs'.setup {
            highlight = {                                                                 
                 enable = true,                                                            
                 additional_vim_regex_highlighting = {'org', 'python'}, -- Required for spellcheck, s
             },                                                                            
             ensure_installed = {'org', 'python'}, -- Or run :TSUpdate org
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
                }
            },
            view = {
                mappings = {
                    list = {
                        {key = "<CR>",          action = "tabnew"}
                    }
                }
            },
            filters = {dotfiles = true}
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
            --[[
            sections = {
                lualine_x = { 
                    require('weather.lualine').default_c({}) 
                }
            }
            --]]
        })

        
        --[[ weather.nvim
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
        ]]--

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

        -- LSP configs
        use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
        require'lspconfig'.clangd.setup{}
        require'lspconfig'.pyright.setup{}
        require'lspconfig'.jdtls.setup{
           cmd = { 'jdtls' },
           root_dir = function(fname)
              return require'lspconfig'.util.root_pattern('pom.xml', 'gradle.build', '.git')(fname) or vim.fn.getcwd()
           end
        }

        -- Mappings.
        -- See `:help vim.diagnostic.*` for documentation on any of the below functions
        local opts = { noremap=true, silent=true }
        vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

        -- Use an on_attach function to only map the following keys
        -- after the language server attaches to the current buffer
        local on_attach = function(client, bufnr)
          -- Enable completion triggered by <c-x><c-o>
          vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

          -- Mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local bufopts = { noremap=true, silent=true, buffer=bufnr }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
          -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
          -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
          vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
          vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
          vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, bufopts)
          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
          vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
          -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
          -- vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
        end

        local lsp_flags = {
          -- This is the default in Nvim 0.7+
          debounce_text_changes = 150,
        }
        require('lspconfig')['pyright'].setup{
            on_attach = on_attach,
            flags = lsp_flags,
        }
        require('lspconfig')['tsserver'].setup{
            on_attach = on_attach,
            flags = lsp_flags,
        }
        require('lspconfig')['rust_analyzer'].setup{
            on_attach = on_attach,
            flags = lsp_flags,
            -- Server-specific settings...
            settings = {
              ["rust-analyzer"] = {}
            }
        }

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


        -- orgmode
        use {'nvim-orgmode/orgmode', config = function()
                require('orgmode').setup{}
            end
        }

        -- Load custom tree-sitter grammar for org filetype
        require('orgmode').setup_ts_grammar()

        require('orgmode').setup({
            org_agenda_files = {'~/orgmode/org/*'},
            org_default_notes_file = '~/orgmode/org/refile.org',
        })

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

        -- winbar.nvim
        -- use { 'fgheng/winbar.nvim' }
        -- require('winbar').setup({ 
        --     enabled = true,
        --     show_symbols = true,
        -- })

        -- indent-blankline 
        use { 'lukas-reineke/indent-blankline.nvim' }
        require('indent_blankline').setup()

        -- comment.nvim
        use { 'numToStr/Comment.nvim' }
        require('Comment').setup()

end)

