-- Ensure packer.nvim is installed
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd 'packadd packer.nvim'
    end
end
ensure_packer()

-- Plugins setup
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'nvim-treesitter/nvim-treesitter'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'L3MON4D3/LuaSnip'
    use 'nvim-tree/nvim-tree.lua'
    use 'nvim-tree/nvim-web-devicons'
    use 'nvim-telescope/telescope.nvim'
    use 'windwp/nvim-autopairs'
    use 'Pocco81/auto-save.nvim'
    use { "catppuccin/nvim", as = "catppuccin" }
    use 'feline-nvim/feline.nvim'
end)

-- UI settings
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"

-- Theme setup
require("catppuccin").setup({
    flavour = "macchiato",
    integrations = {
        nvimtree = true,
        treesitter = true,
        telescope = true,
        cmp = true,
        gitsigns = true,
        lsp_saga = true,
        lsp_trouble = true,
    },
})
vim.cmd.colorscheme "catppuccin"

-- Indentation settings
vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.smarttab = true

-- File explorer setup
require('nvim-tree').setup({
    git = { ignore = false, }
})

-- Auto-save setup
require('auto-save').setup {}

-- Treesitter setup
require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    highlight = { 
		enable = true, 
		additional_vim_regex_highlighting = false,
	},
    indent = { enable = true },
}

-- LSP configuration
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- PHP (Intelephense)
lspconfig.intelephense.setup {
    capabilities = capabilities,
    settings = { intelephense = { files = { maxSize = 5000000 }, }, },
}

-- Go (gopls)
lspconfig.gopls.setup {
    capabilities = capabilities,
    cmd = {"gopls"},
    settings = { gopls = { gofumpt = true, staticcheck = true, usePlaceholders = true,
        analyses = { unusedparams = true, shadow = true, unusedwrite = true, },
        completeUnimported = true,
    }},
}

-- Python (pylsp)
lspconfig.pylsp.setup {
    capabilities = capabilities,
    settings = { pylsp = { plugins = {
        flake8 = { enabled = true }, black = { enabled = true }, isort = { enabled = true },
        pycodestyle = { enabled = false }, mccabe = { enabled = false }, pyflakes = { enabled = false },
    }}},
}

-- Auto-format on save
vim.cmd [[
  autocmd BufWritePre *.php lua vim.lsp.buf.format({ async = false })
  autocmd BufWritePre *.go lua vim.lsp.buf.format({ async = false })
  autocmd BufWritePre *.py lua vim.lsp.buf.format({ async = false })
]]

-- Autocompletion setup
local cmp = require'cmp'
cmp.setup({
    snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
    mapping = {
        -- ['<M-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    })
})

vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>b', '<cmd>vsplit<CR><cmd>lua vim.lsp.buf.definition()<CR><cmd>wincmd p<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>k', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', 'j', 'jzz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'k', 'kzz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'h', 'hzz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'l', 'lzz', { noremap = true, silent = true })

-- Enable devicons
require('nvim-web-devicons').setup({ default = true, override = { zsh = { icon = "", color = "#428850", name = "Zsh" }, } })

-- Feline status line setup
local ctp_feline = require('catppuccin.groups.integrations.feline')
ctp_feline.setup()
require("feline").setup({ components = ctp_feline.get(), })

