---------------------------
--      shorthands       --
---------------------------
local cmd = vim.cmd  -- to execute Vim commands i.e., like :Format
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local opt = vim.opt  -- a table to set options
local g = vim.g      -- a table to access global variables
local env = vim.env  -- environment variables

local execute = vim.api.nvim_command
local map = vim.api.nvim_set_keymap
local noremap = {noremap = true}


---------------------------
--      leader key       --
---------------------------
-- this should be done as early as possible
map('n', '<SPACE>', '<Nop>', noremap)
g.mapleader = ' '


---------------------------
--        packer         --
---------------------------
-- Auto-install packer.nvim if directory does not exist
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute('pakadd packer.nvim')
end

-- Only required if you have packer configured as `opt`
cmd [[packadd packer.nvim]]

-- Initialize plugins
require('packer').startup(function(use)
  -- Packer can manage itself
  use {'wbthomason/packer.nvim', opt = true}

  -- Path navigator designed to work with Vim's built-in mechanisms and complementary plugins
  use {'justinmk/vim-dirvish'}

  -- completion
  use { 'hrsh7th/nvim-compe' }
  use { 'nvim-lua/completion-nvim' }
  use { 'steelsojka/completion-buffers' }  -- word completion from current buffer

  -- LSP
  use { 'neovim/nvim-lspconfig' }
  use { 'RRethy/vim-illuminate' }  -- highlight other occurances of variable under cursor

  -- Fuzzy finder (i.e., replacement for FZF)
  use {
      'nvim-telescope/telescope.nvim',
      requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }

  -- Treesitter - syntax lighting
  use 'nvim-treesitter/nvim-treesitter'
  -- objects for moving
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  -- show context in code
  use 'romgrk/nvim-treesitter-context'

  -- colorscheme
  use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}

  -- display a counter for search matches
  use { 'thomkeh/vim-matchcounter', branch = 'main' }

  -- show content of registers
  use "tversteeg/registers.nvim"

  -- comments
  use 'b3nj5m1n/kommentary'

  -- status line
  use 'itchyny/lightline.vim'
  use 'mengelbrecht/lightline-bufferline'

  -- useful bindings
  use 'tpope/vim-unimpaired'

  -- surround text objects
  use "tpope/vim-surround"

  -- indenting
  use 'tpope/vim-sleuth'

  -- Vim sugar for the UNIX shell commands that need it the most
  use 'tpope/vim-eunuch'

  -- make more commands repeatable with .
  use 'tpope/vim-repeat'

  -- snippets
  use 'hrsh7th/vim-vsnip' -- VSCode(LSP)'s snippet feature in vim
  use 'honza/vim-snippets'  -- snippet collection

  -- git integration (execute git commands)
  use 'lambdalisue/gina.vim'

  -- git integration (mark added/modified/deleted lines)
  use {
    'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    config = function()
      require('gitsigns').setup()
    end
  }

  -- auto close parens
  use 'Raimondi/delimitMate'

  -- visual hints for f and t movements
  use 'unblevable/quick-scope'

  -- latex support
  use 'lervag/vimtex'

  -- digram-based/cross-line f/t movement
  use {'chaoren/vim-wordmotion', {'justinmk/vim-sneak', config = [[require('config.sneak')]]}}

  -- code formatting for python
  use {'psf/black', branch = 'stable'}

  -- easy window resizing
  use {'simeji/winresizer'}

  -- remember cursor position
  use {'farmergreg/vim-lastplace'}

  -- makes built-in LSP actions more use-friendly 
  use {'RishabhRD/popfix'}
  use {'RishabhRD/nvim-lsputils'}

end)


---------------------------
--      keymappings      --
---------------------------
-- (keymaps are not very lua-y right now,
--  but there is a PR to change this:
--- https://github.com/neovim/neovim/pull/13823)
-- general mappings
map('n', '<leader>w', '<cmd>cclose<cr>', noremap)
map('n', '<leader>q', '<cmd>qa<cr>', noremap)
map('n', '<leader><space>', '<cmd>nohlsearch<cr>', noremap)
map('n', '<leader>s', '<cmd>update<cr>', noremap)
map('n', '<leader><leader>', 'zz', noremap)
map('n', '<leader>:', 'q:', noremap)
map('v', '<leader>:', 'q:', {})

-- Make < > shifts keep selection
map('v', '<', '<gv', noremap)
map('v', '>', '>gv', noremap)

-- copy/paste shortcuts
map('n', 'Y', 'y$', noremap)
map('n', 'cy', '"+y', {noremap=true})
map('n', 'cp', '"+p', {noremap=true, silent=true})
map('n', 'cP', '"+P', {noremap=true, silent=true})

-- global selection
map('x', 'ie', 'gg0gG$', {noremap=true, silent=true})
map('o', 'ie', 'cmd<C-U>execute "normal! m`"<Bar>keepjumps normal! ggVG<CR> ', {noremap=true, silent=true})

-- window movement
-- In normal mode
map('n', '<C-h>', '<C-\\><C-n><C-w>h', noremap)
map('n', '<C-j>', '<C-\\><C-n><C-w>j', noremap)
map('n', '<C-k>', '<C-\\><C-n><C-w>k', noremap)
map('n', '<C-l>', '<C-\\><C-n><C-w>l', noremap)
-- In terminal mode
map('t', '<C-h>', '<C-\\><C-n><C-w>h', noremap)
map('t', '<C-j>', '<C-\\><C-n><C-w>j', noremap)
map('t', '<C-k>', '<C-\\><C-n><C-w>k', noremap)
map('t', '<C-l>', '<C-\\><C-n><C-w>l', noremap)
map('t', '<C-w>', '<C-\\><C-n>', noremap)

-- sneak settings
map('', 'f', '<Plug>Sneak_f', {})
map('', 'F', '<Plug>Sneak_F', {})
map('', 't', '<Plug>Sneak_t', {})
map('', 'T', '<Plug>Sneak_T', {})

-- telescope mappings
map('n', '<C-p>', '<cmd>Telescope find_files find_command=fd,--type,f,--hidden,--follow,--exclude,.git<cr>', noremap)
map('n', '<leader>o', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', noremap)
map('n', '<leader>f', '<cmd>Telescope live_grep<cr>', noremap)
-- python-related mappings
map('n', '<leader>i', '<cmd>PyrightOrganizeImports<cr>', noremap)
map('n', '<leader>b', '<cmd>Black<cr>', noremap)
map('n', '<leader>e', 'ofrom IPython import embed; embed()<esc>', noremap)
-- buffer change
map('n', '<leader>1', '<Plug>lightline#bufferline#go(1)', {})
map('n', '<leader>2', '<Plug>lightline#bufferline#go(2)', {})
map('n', '<leader>3', '<Plug>lightline#bufferline#go(3)', {})
map('n', '<leader>4', '<Plug>lightline#bufferline#go(4)', {})
map('n', '<leader>5', '<Plug>lightline#bufferline#go(5)', {})
map('n', '<leader>6', '<Plug>lightline#bufferline#go(6)', {})
map('n', '<leader>7', '<Plug>lightline#bufferline#go(7)', {})
map('n', '<leader>8', '<Plug>lightline#bufferline#go(8)', {})
map('n', '<leader>9', '<Plug>lightline#bufferline#go(9)', {})
map('n', '<leader>0', '<Plug>lightline#bufferline#go(10)', {})
-- gina keymaps
map('n', '<leader>gs', '<cmd>Gina status<cr>', noremap)
map('n', '<leader>gc', '<cmd>Gina commit<cr>', noremap)
map('n', '<leader>gp', '<cmd>Gina push<cr>', noremap)


---------------------------
--    global settings    --
---------------------------
opt.syntax = 'enable'
-- TODO: convert the following line to proper lua
cmd [[filetype plugin indent on]]
opt.hidden = true
opt.ignorecase = true
opt.smartcase = true
opt.number = true
opt.relativenumber = true
opt.signcolumn = 'yes'
opt.cmdheight = 2
opt.incsearch = true
opt.hlsearch = false
opt.inccommand = 'nosplit'
opt.exrc = true
opt.secure = true
opt.termguicolors = true
g.tex_flavor = 'latex'

opt.history = 1000 
opt.undolevels = 10000 
opt.undoreload = 100000

 -- maintain undo history between session
opt.undofile = true
opt.undodir = '~/.config/nvim/undodir'


-- Highlight on yank
cmd [[au TextYankPost * lua vim.highlight.on_yank {on_visual = false}]]


---------------------------
--      status line      --
---------------------------
opt.showmode = false
g.lightline = {
  colorscheme = 'one',
  active = {
    left = {{'mode', 'paste'}, {'readonly', 'relativepath', 'modified'}},
  },
  tabline = {
    left = {{'buffers'}}
  },
  component_expand = {
    buffers = 'lightline#bufferline#buffers'
  },
  component_type = {
    buffers = 'tabsel',
  }
}
g.lightline.component = {lineinfo = '%3l/%L  col %-2v', percent = ''}
opt.showtabline = 2
g['lightline#bufferline#show_number'] = 2


---------------------------
--    various plugins    --
---------------------------
-- quick scope
g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}

-- vimtex
-- g.vimtex_view_method = 'skim'
-- Disable overfull/underfull \hbox and all package warnings
g.vimtex_quickfix_ignore_filters = { 'Missing "pages" in' }
g.vimtex_quickfix_latexlog = {
  overfull = 0,
  underfull = 0,
  pages = 0,
  packages = {
    default = 0,
  },
}


---------------------------
--     Treesitter        --
---------------------------
local ts = require('nvim-treesitter.configs')
ts.setup {
  ensure_installed = 'maintained',
  highlight = {enable = true},
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",

        -- Or you can define your own textobjects like this
        --[[ ["iF"] = {
          python = "(function_definition) @function",
          cpp = "(function_definition) @function",
          c = "(function_definition) @function",
          java = "(method_declaration) @function",
        }, ]]
      },
    },
  },
}


---------------------------
--     colorscheme       --
---------------------------
cmd [[colorscheme gruvbox]]
execute [[hi TreesitterContext ctermbg=gray guibg=Gray]]

---------------------------
--      completion       --
---------------------------
opt.completeopt = {'menuone', 'noinsert', 'noselect'}
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

---------------------------
--         LSP           --
---------------------------
-- Your custom attach function for nvim-lspconfig goes here.
local on_attach = function(client, bufnr)
  require('completion').on_attach()

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  ---------------------------
  --   LSP key mappings    --
  ---------------------------
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>o', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
  buf_set_keymap('n', '<leader>w', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>d', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)

-- nvim-lsputils-
vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler

  --[[ if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<leader>b", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end ]]

  -- Set autocommands conditional on server_capabilities
  --[[ if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ] ], false)
  end ]]

  -- hook in plugins depending on LSP
  require('illuminate').on_attach(client)
end

local lspconfig = require('lspconfig')
lspconfig.pyright.setup{
  on_attach = on_attach,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoImportCompletions = true,
      },
      formatting = {
        provider = "black",
      },
    }
  }
}
lspconfig.html.setup{on_attach = on_attach}
-- when highlighting other occurances of a variable
-- don't highlight the variable itself
g.Illuminate_highlightUnderCursor = 0

---------------------------
--      telescope        --
---------------------------
local actions = require('telescope.actions')
require("telescope").setup {
  defaults = {
    mappings = {
      i = {
        ["<C-k>"] = actions.toggle_selection + actions.move_selection_previous,
        ["<C-j>"] = actions.toggle_selection + actions.move_selection_next,
        ["<C-w>"] = actions.send_selected_to_qflist + actions.open_qflist,
      },
      n = {
        ["<C-k>"] = actions.toggle_selection + actions.move_selection_previous,
        ["<C-j>"] = actions.toggle_selection + actions.move_selection_next,
        ["<C-w>"] = actions.send_selected_to_qflist + actions.open_qflist,
      }
   
  },
}
}
