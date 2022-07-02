local options = {
  backup = false,
  clipboard = "unnamedplus",
  cmdheight = 1,
  completeopt = { "menuone", "noselect" },
  conceallevel = 0,
  fileencoding = "utf-8",
  hlsearch = true,
  ignorecase = true,
  mouse = "a",
  pumheight = 10,
  showmode = false,
  showtabline = 2,
  smartcase = true,
  smartindent = false,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  termguicolors = true,
  timeoutlen = 100,
  undofile = false,
  updatetime = 80,
  writebackup = false,
  expandtab = true,
  shiftwidth = 2,
  cursorline = true,
  cursorcolumn = true,
  relativenumber = true,
  hidden =  true,
  errorbells = false,
  tabstop = 4,
  softtabstop = 4,
  nu = false,
  incsearch = true,
  numberwidth = 4,
  signcolumn = "yes",
  wrap = true,
  scrolloff = 8,
  sidescrolloff = 8,
  guifont = "FantasqueSansMono Nerd Font:h15",
  guicursor = "",
  colorcolumn = "80",
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
vim.g.mapleader = " "
vim.cmd [[set number]]