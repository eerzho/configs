local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd 'packadd packer.nvim'
    end
end
ensure_packer()

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use { "catppuccin/nvim", as = "catppuccin" }
    use 'nvim-tree/nvim-tree.lua'
    use 'nvim-tree/nvim-web-devicons'
    use 'feline-nvim/feline.nvim'        
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-treesitter/nvim-treesitter'
    use 'lewis6991/gitsigns.nvim'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'L3MON4D3/LuaSnip'
    use 'rafamadriz/friendly-snippets'       
    use {
      "zbirenbaum/copilot.lua",
      event = "VimEnter",
      config = function()
        require("copilot").setup({
          suggestion = { enabled = true }, 
          panel = { enabled = true },      
        })
      end,
    }
    use {
      "zbirenbaum/copilot-cmp",
      after = { "copilot.lua" },
      config = function ()
        require("copilot_cmp").setup()
      end
    }
    use 'windwp/nvim-autopairs'
    use 'numToStr/Comment.nvim'
    use 'Pocco81/auto-save.nvim'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'jose-elias-alvarez/null-ls.nvim'
	use 'nvim-lua/plenary.nvim'
end)

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"

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

vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.smarttab = true

require('nvim-tree').setup({
    git = { ignore = false, }
})

vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

require('auto-save').setup {}

require('nvim-treesitter.configs').setup {
    ensure_installed = { "php", "go", "python", "lua", "javascript", "json", "yaml", "html", "css" },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
}

require('gitsigns').setup {
    signcolumn = true,
    numhl      = false,
    linehl     = false,
    current_line_blame = true,  
}

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "intelephense", 
    "gopls",        
    "pylsp",        
  },
})

local null_ls = require("null-ls")

null_ls.setup({
    sources = {
      null_ls.builtins.diagnostics.eslint.with({
        condition = function(utils)
          return utils.root_has_file({".eslintrc", ".eslintrc.js", ".eslintrc.json"})
        end,
      }),
      null_ls.builtins.formatting.prettier.with({
        condition = function(utils)
          return utils.root_has_file({".prettierrc", ".prettierrc.js", ".prettierrc.json"})
        end,
      }),
      null_ls.builtins.code_actions.refactoring,

      null_ls.builtins.formatting.gofumpt,
      null_ls.builtins.diagnostics.golangci_lint,

      null_ls.builtins.formatting.black,
      null_ls.builtins.diagnostics.flake8,

      null_ls.builtins.formatting.phpcsfixer,
    }
})

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("mason-lspconfig").setup_handlers({
  function(server_name)
    lspconfig[server_name].setup {
      capabilities = capabilities,
    }
  end,
  
  ["intelephense"] = function()
    lspconfig.intelephense.setup {
      capabilities = capabilities,
      settings = {
        intelephense = {
          files = { maxSize = 5000000 },
          format = { enable = true },
          completion = { fullyQualifyGlobalConstants = true },
          diagnostics = { enable = true },
          environment = { phpVersion = "8.1" } 
        }
      }
    }
  end,

  ["phpactor"] = function()
    lspconfig.phpactor.setup {
      capabilities = capabilities
    }
  end,

  ["gopls"] = function()
    lspconfig.gopls.setup {
      capabilities = capabilities,
      cmd = { "gopls" },
      settings = {
        gopls = {
          gofumpt = true,
          staticcheck = true,
          usePlaceholders = true,
          analyses = {
            unusedparams = true,
            shadow = true,
            unusedwrite = true,
          },
          completeUnimported = true,
        }
      },
    }
  end,

  ["pylsp"] = function()
    lspconfig.pylsp.setup {
      capabilities = capabilities,
      settings = {
        pylsp = {
          plugins = {
            flake8 = { enabled = true },
            black  = { enabled = true },
            isort  = { enabled = true },
            pycodestyle = { enabled = false },
            mccabe     = { enabled = false },
            pyflakes   = { enabled = false },
          },
        },
      },
    }
  end,
})

vim.cmd [[
  autocmd BufWritePre *.php lua vim.lsp.buf.format({ async = false })
  autocmd BufWritePre *.go lua vim.lsp.buf.format({ async = false })
  autocmd BufWritePre *.py lua vim.lsp.buf.format({ async = false })
  autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx lua vim.lsp.buf.format({ async = false })
]]

local cmp = require'cmp'
local luasnip = require'luasnip'

require("luasnip.loaders.from_vscode").lazy_load()  

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<CR>']   = cmp.mapping.confirm({ select = true }),
    ['<Tab>']  = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
  },
  sources = cmp.config.sources({
    { name = 'copilot' },   
    { name = 'nvim_lsp' },  
    { name = 'luasnip' },   
    { name = 'buffer' },    
    { name = 'path' },      
  })
})

require('nvim-autopairs').setup({})

require('Comment').setup()

vim.api.nvim_set_keymap('n', '<leader>b', '<cmd>vsplit<CR><cmd>lua vim.lsp.buf.definition()<CR><cmd>wincmd p<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>k', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files,  { desc = "Поиск файлов" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep,   { desc = "Поиск по содержимому" })
vim.keymap.set('n', '<leader>fb', builtin.buffers,     { desc = "Список буферов" })
vim.keymap.set('n', '<leader>fh', builtin.help_tags,   { desc = "Поиск по помощи" })

vim.api.nvim_set_keymap('n', 'j', 'jzz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'k', 'kzz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'h', 'hzz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'l', 'lzz', { noremap = true, silent = true })

require('nvim-web-devicons').setup({
  default = true,
  override = {
    zsh = {
      icon = "",
      color = "#428850",
      name = "Zsh"
    },
  }
})

local ctp_feline = require('catppuccin.groups.integrations.feline')
ctp_feline.setup()
require("feline").setup({ components = ctp_feline.get() })


