" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

set nocompatible
filetype off
set termguicolors

let g:tokyonight_style = "night"

call plug#begin('~/.config/nvim/plugged')
Plug 'marko-cerovac/material.nvim'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-lua/plenary.nvim'
" lingua-franca
Plug 'lf-lang/lingua-franca.vim'
" devicons
Plug 'kyazdani42/nvim-web-devicons'

call plug#end()

" KEYBINDINGS
" remap space key to leader
map <Space> <Leader>

" ====================== NvimTree ======================
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>n :NvimTreeFocus<CR>

" ====================== buffers ======================
map <C-j> :bp<CR>
map <C-K> :bn<CR>
map <C-L> :bd<CR>
"map <C-l> :bd \| :bp<CR>

" ====================== telescope ======================
" nnoremap <leader>t :Telescope<CR>
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>fr <cmd>lua require('telescope.builtin').oldfiles()<cr>
nnoremap <leader>cs <cmd>lua require('telescope.builtin').colorscheme()<cr>
nnoremap <leader>fs <cmd>lua require('telescope.builtin').treesitter()<cr>
nnoremap gr <cmd>lua require('telescope.builtin').lsp_references()<cr>
nnoremap gd <cmd>lua require('telescope.builtin').lsp_definitions()<cr>

" ====================== material ======================
nnoremap <leader>m :lua require('material.functions').toggle_style()<CR>

" ====================== symbols-outline ======================
map <C-s> :SymbolsOutline<CR>


filetype plugin indent on
syntax on
set background=dark
set number
set cursorline
set nowrap
set smartcase
set hlsearch
set noerrorbells
set mouse=
"set tabstop=4 softtabstop=4
"set expandtab
"set smartindent

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

let mapleader = "\<Space>"

lua require('plugins')
augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
