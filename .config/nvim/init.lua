-- Config vim options
local g, o = vim.g, vim.opt
g.mapleader = " "
g.maplocalleader = " "

o.relativenumber = true
o.scrolloff = 30
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.splitbelow = true
o.splitright = true
o.termguicolors = true
o.timeoutlen = 100
o.updatetime = 250
o.swapfile = false
o.autoread = true
o.nu = true
o.signcolumn = 'yes'

-- Fish shell config
o.shell = "fish"
o.shellpipe = "|"
o.shellcmdflag = ""
o.shellxquote = ""


-- Install mini.nvim
local path_package = vim.fn.stdpath('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    -- Uncomment next line to use 'stable' branch
    -- '--branch', 'stable',
    'https://github.com/echasnovski/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
end


-- Set up mini.deps
vim.loader.enable()
require("mini.deps").setup({path={package=path_package}})
local add = MiniDeps.add
local now, later = MiniDeps.now, MiniDeps.later


-- Packages
add("nvim-treesitter/nvim-treesitter")
add("nvim-lua/plenary.nvim")
add("nvim-telescope/telescope.nvim")
add("folke/which-key.nvim")
add("lewis6991/gitsigns.nvim")
-- add("rebelot/kanagawa.nvim")
add("kvrohit/rasmus.nvim")

-- Theme
now(function()
	vim.cmd.colorscheme("rasmus")
	require("mini.tabline").setup()
	-- require("mini.statusline").setup()
end)


later(function ()
	-- Telescope
	require("telescope").setup()
    -- Treesitter
    require("nvim-treesitter").setup({
        ensure_installed = {"help", "lua", "rust", "go"},
        sync_install = false,
        highlight = {
            enable = true
        }
    })
	-- WhichKey
	require("which-key").setup()
	-- Gitsigns
	require("gitsigns").setup()
end)


-- Keymaps
local map = vim.keymap.set
local builtin = require('telescope.builtin')
map('n', '<leader>f', builtin.find_files, {desc="Find files"})
map('n', '<leader>g', builtin.live_grep, {desc="Live grep"})
map('n', '<leader>b', builtin.buffers, {desc="Buffers"})
map('n', '<leader>h', builtin.help_tags, {desc="Help tags"})
map('n', 'gn', ':bnext<CR>', { desc="Buffer next", noremap = true, silent = true })
map('n', 'gp', ':bprev<CR>', { desc="Buffer previous", noremap = true, silent = true })



-- Show highlight under yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight yanked text",
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
})

