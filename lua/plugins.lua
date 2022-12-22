return require('packer').startup(function()
        use 'wbthomason/packer.nvim'

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
            sections = {
                lualine_c = {
                    {
                        'filename',
                        file_status = true,
                        path = 2,
                    }
                }
            }
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
            
            -- Attach navic to active buffer.
            if client.server_capabilities.documentSymbolProvider then
                local navic = require("nvim-navic")
                navic.setup({
                    highlight = true,
                    separator = '  ',
                })
                navic.attach(client, bufnr)
            end
        end

        local lsp_flags = {
          -- This is the default in Nvim 0.7+
          debounce_text_changes = 150,
        }
        require'lspconfig'.clangd.setup{}
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
        require'lspconfig'.gopls.setup{
            on_attach = on_attach,
            flags = lsp_flags,
        }
        require'lspconfig'.jdtls.setup{
           cmd = { 'jdtls' },
           root_dir = function(fname)
                    return require'lspconfig'.util.root_pattern('pom.xml', 'gradle.build', '.git')(fname) or vim.fn.getcwd()
                end,
           on_attach = on_attach,
           flags = lsp_flags,
        }
        require'lspconfig'.html.setup{
            on_attach = on_attach,
            flags = lsp_flags,
        }

        local location = require("nvim-navic").get_location()
        vim.o.winbar = "%{%' ' . v:lua.require'nvim-navic'.get_location()%}"

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
end)

