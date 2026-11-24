local function gh(repo) return 'https://github.com/' .. repo end

-- [[ Configure Treesitter ]]
-- vim.pack is the plugin manager used by this configuration.
vim.pack.add {
  { src = gh 'neovim-treesitter/treesitter-parser-registry' },
  { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' },
  { src = gh 'nvim-treesitter/nvim-treesitter-context' },
}

require('treesitter-context').setup {
  max_lines = 4,
  multiline_threshold = 2,
}

local ts = require 'nvim-treesitter'
local parsers = {
  'bash',
  'c',
  'diff',
  'html',
  'javascript',
  'json',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'python',
  'query',
  'rust',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
}

-- Install these common parsers in the background. Any supported filetype can
-- also trigger an on-demand install below.
ts.install(parsers)

local function enable_treesitter(buf, language)
  if not vim.api.nvim_buf_is_valid(buf) then return end

  local ok = pcall(vim.treesitter.start, buf, language)
  if not ok then return end

  if vim.treesitter.query.get(language, 'indents') then
    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end

local available_parsers = ts.get_available()
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('kickstart-treesitter', { clear = true }),
  callback = function(event)
    local language = vim.treesitter.language.get_lang(event.match)
    if not language then return end

    local installed_parsers = ts.get_installed 'parsers'
    if vim.tbl_contains(installed_parsers, language) then
      enable_treesitter(event.buf, language)
    elseif vim.tbl_contains(available_parsers, language) then
      ts.install(language):await(function() enable_treesitter(event.buf, language) end)
    else
      -- Use any parser already present on runtimepath, even if this plugin
      -- does not manage it.
      enable_treesitter(event.buf, language)
    end
  end,
})

-- vim: ts=2 sts=2 sw=2 et
