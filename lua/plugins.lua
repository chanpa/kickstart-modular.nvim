local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local output = vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  }
  if vim.v.shell_error ~= 0 then error('Failed to install lazy.nvim:\n' .. output) end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  spec = {
    {
      'NMAC427/guess-indent.nvim',
      config = function() require 'kickstart.plugins.guess-indent' end,
    },
    {
      'lewis6991/gitsigns.nvim',
      config = function() require 'kickstart.plugins.gitsigns' end,
    },
    {
      'folke/which-key.nvim',
      config = function() require 'kickstart.plugins.which-key' end,
    },
    {
      'folke/tokyonight.nvim',
      priority = 1000,
      config = function() require 'kickstart.plugins.tokyonight' end,
    },
    {
      'folke/todo-comments.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function() require 'kickstart.plugins.todo-comments' end,
    },
    {
      'nvim-mini/mini.nvim',
      config = function() require 'kickstart.plugins.mini' end,
    },
    {
      'nvim-telescope/telescope.nvim',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-ui-select.nvim',
        {
          'nvim-telescope/telescope-fzf-native.nvim',
          build = 'make',
          cond = function() return vim.fn.executable 'make' == 1 end,
        },
      },
      config = function() require 'kickstart.plugins.telescope' end,
    },
    {
      'neovim/nvim-lspconfig',
      dependencies = {
        'j-hui/fidget.nvim',
        'mason-org/mason.nvim',
        'mason-org/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
      },
      config = function() require 'kickstart.plugins.lspconfig' end,
    },
    {
      'stevearc/conform.nvim',
      config = function() require 'kickstart.plugins.conform' end,
    },
    {
      'saghen/blink.cmp',
      version = '1.*',
      dependencies = {
        { 'L3MON4D3/LuaSnip', version = '2.*' },
      },
      config = function() require 'kickstart.plugins.blink-cmp' end,
    },
    {
      'nvim-treesitter/nvim-treesitter',
      branch = 'main',
      build = ':TSUpdate',
      dependencies = {
        'neovim-treesitter/treesitter-parser-registry',
        'nvim-treesitter/nvim-treesitter-context',
      },
      config = function() require 'kickstart.plugins.treesitter' end,
    },

    -- Optional plugins: add a spec here and uncomment the matching module.
    -- {
    --   'mfussenegger/nvim-dap',
    --   dependencies = {
    --     'rcarriga/nvim-dap-ui',
    --     'nvim-neotest/nvim-nio',
    --     'mason-org/mason.nvim',
    --     'jay-babu/mason-nvim-dap.nvim',
    --     'leoluz/nvim-dap-go',
    --   },
    --   config = function() require 'kickstart.plugins.debug' end,
    -- },
    -- {
    --   'lukas-reineke/indent-blankline.nvim',
    --   config = function() require 'kickstart.plugins.indent_line' end,
    -- },
    -- {
    --   'mfussenegger/nvim-lint',
    --   config = function() require 'kickstart.plugins.lint' end,
    -- },
    -- {
    --   'windwp/nvim-autopairs',
    --   config = function() require 'kickstart.plugins.autopairs' end,
    -- },
    -- {
    --   'nvim-neo-tree/neo-tree.nvim',
    --   version = '*',
    --   dependencies = { 'nvim-lua/plenary.nvim', 'MunifTanjim/nui.nvim' },
    --   config = function() require 'kickstart.plugins.neo-tree' end,
    -- },

    { import = 'custom.plugins' },
  },
  defaults = { lazy = false },
}

-- vim: ts=2 sts=2 sw=2 et
