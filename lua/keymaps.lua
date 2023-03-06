local utils = require("utils")

-- telescope
local builtin = require('telescope.builtin')
utils.map("n", "<leader>t", function()
    builtin.builtin { include_extensions = true }
end)
utils.map("n", "<leader>ff", builtin.find_files)
utils.map("n", "<leader>fg", builtin.live_grep)
utils.map("n", "<leader>fb", builtin.current_buffer_fuzzy_find)
utils.map("n", "<leader>fh", builtin.help_tags)
utils.map("n", "<leader>fr", builtin.oldfiles)
utils.map("n", "<leader>cs", builtin.colorscheme)
utils.map("n", "<leader>sf", builtin.lsp_document_symbols)
utils.map("n", "<leader>sw", builtin.lsp_dynamic_workspace_symbols)
utils.map("n", "<leader>gc", builtin.git_commits)
utils.map("n", "<leader>gs", builtin.git_status)
utils.map("n", "<leader>gb", builtin.git_branches)
utils.map("n", "<leader>gf", builtin.git_files)
utils.map("n", "gr", builtin.lsp_references)
utils.map("n", "gd", builtin.lsp_definitions)

-- material theme
utils.map("n", "<leader>m", require('material.functions').toggle_style)

-- symbols outline
utils.map("n", "<c-s>", ":SymbolsOutline<cr>")

-- nvim-tree
utils.map("n", "<c-n>", ":NvimTreeToggle<cr>")
utils.map("n", "<leader>n", ":NvimTreeFocus<cr>")

-- buffers
utils.map("n", "<c-j>", ":bp<cr>")
utils.map("n", "<c-k>", ":bn<cr>")
utils.map("n", "<c-l>", ":bd<cr>")

-- toggleterm
utils.map("n", "<leader>bv", ":ToggleTerm direction=vertical<cr>")
utils.map("n", "<leader>bf", ":ToggleTerm direction=float<cr>")
utils.map("n", "<leader>bh", ":ToggleTerm direction=horizontal<cr>")

-- goto-preview
utils.map("n", "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", {noremap=true})
utils.map("n", "gpt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", {noremap=true})
utils.map("n", "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", {noremap=true})
utils.map("n", "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>", {noremap=true})
utils.map("n", "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", {noremap=true})
