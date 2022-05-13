" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

set nocompatible
filetype off
"set termguicolors

call plug#begin('~/.config/nvim/plugged')
Plug 'marko-cerovac/material.nvim'
Plug 'bluz71/vim-moonfly-colors'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
call plug#end()

colorscheme gruvbox
