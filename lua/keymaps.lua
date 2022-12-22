local utils = require("utils")

-- TELESCOPE
local builtin = require('telescope.builtin')

utils.map("n", "<leader>t", function()
    builtin.builtin { include_extensions = true }
end)
utils.map("n", "<leader>ff", builtin.find_files)
utils.map("n", "<leader>fg", builtin.live_grep)
utils.map("n", "<leader>fb", builtin.buffers)
utils.map("n", "<leader>fh", builtin.help_tags)
utils.map("n", "<leader>fr", builtin.oldfiles)
utils.map("n", "<leader>cs", builtin.colorscheme)
utils.map("n", "<leader>fs", builtin.lsp_document_symbols)
utils.map("n", "gr", builtin.lsp_references)
utils.map("n", "gd", builtin.lsp_definitions)

-- material theme
utils.map("n", "<leader>m", require('material.functions').toggle_style)
utils.map("n", "<c-s>", ":SymbolsOutline<cr>")
utils.map("n", "<c-n>", ":NvimTreeToggle<cr>")
utils.map("n", "<leader>n", ":NvimTreeFocus<cr>")

-- buffers
utils.map("n", "<c-j>", ":bp<cr>")
utils.map("n", "<c-k>", ":bn<cr>")
utils.map("n", "<c-l>", ":bd<cr>")
