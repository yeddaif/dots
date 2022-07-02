vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function()
  -- Essential
  use "nvim-lua/plenary.nvim"
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-lualine/lualine.nvim'
  use "akinsho/bufferline.nvim"
  -- nvim-cmp
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  -- luasnip
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  -- Utils
  use "windwp/nvim-autopairs"
  use 'windwp/nvim-ts-autotag'
  use 'voldikss/vim-floaterm'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'sbdchd/neoformat'
  -- Colorscheme
  use 'ellisonleao/gruvbox.nvim'
  use 'navarasu/onedark.nvim'
  -- treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  -- Some icons
  use 'kyazdani42/nvim-web-devicons'
end)
