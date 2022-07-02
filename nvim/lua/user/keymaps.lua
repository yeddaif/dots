local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --
-- Shotcut
keymap("n", "<C-q>", ":q!<CR>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- NvimTree
keymap("n", "<C-B>", ":Telescope file_browser<CR>", opts)

-- Neoformat
keymap("n", "<S-f>", ":Neoformat<CR>", opts)

--Float Term
keymap("n", "<C-t>", ":FloatermNew<CR>", opts)
keymap("n", "<C-g>", ':FloatermNew  mycli -u sqluser -p sql1234 -t <CR>', opts)
keymap("n", "<tab>", ":FloatermNext<CR>", opts)

-- Navigate buffers
keymap("n", "<S-m>", ":bdelete<CR>", opts)
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Telescope
keymap("n", "m", ":Telescope oldfiles<CR>", opts)
keymap("n", "z", ":Telescope diagnostics<CR>", opts)
keymap("n", "<C-s>", ":Telescope lsp_definitions<CR>", opts)
keymap("n", "<C-z>", ":Telescope lsp_references<CR>", opts)

--Lsp
keymap("n", "<C-a>", ":lua vim.lsp.buf.code_action()<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

