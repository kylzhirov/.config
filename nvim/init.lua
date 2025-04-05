vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)
vim.opt.colorcolumn = "79"

local lazy_config = require "configs.lazy"

vim.api.nvim_create_user_command("ReloadConfig", "source $HOME/.config/nvim/init.lua", {})
-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

require'lspconfig'.pyright.setup{}
require'lspconfig'.clangd.setup{}
require'lspconfig'.qmlls.setup{
    filetypes = { "qml" },
}
-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"
vim.cmd('colorscheme customcurrent')

vim.schedule(function()
  require "mappings"
end)

vim.keymap.set("n", "<Leader>r", ":%s/\\<<C-r><C-w>\\>//g<Left><Left>", { noremap = true , silent = true})

vim.keymap.set("n", "n", "<NOP>", { noremap = true, silent = true })

vim.o.relativenumber = true

vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4

