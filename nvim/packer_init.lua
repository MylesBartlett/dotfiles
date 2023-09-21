-------------------------
--      shorthands       --
---------------------------
local cmd = vim.cmd -- to execute Vim commands i.e., like :Format
local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
local opt = vim.opt -- a table to set options
local g = vim.g -- a table to access global variables
local env = vim.env -- environment variables

local execute = vim.api.nvim_command
local map = vim.api.nvim_set_keymap
local noremap = { noremap = true }

---------------------------
--      leader key       --
---------------------------
-- this should be done as early as possible
map("n", "<SPACE>", "<Nop>", noremap)
g.mapleader = " "

---------------------------
--       completion      --
---------------------------
opt.completeopt = { "menuone", "noinsert", "noselect" }

---------------------------
--        packer         --
---------------------------
-- Auto-install packer.nvim if directory does not exist
local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
	execute("pakadd packer.nvim")
end

-- Only required if you have packer configured as `opt`
cmd([[packadd packer.nvim]])

-- Initialize plugins
require("packer").startup(function(use)
	-- Packer can manage itself
	use({ "wbthomason/packer.nvim", opt = true })
	use( { 'nvim-tree/nvim-web-devicons' } )

	-- Path navigator designed to work with Vim's built-in mechanisms and complementary plugins
	use({ "justinmk/vim-dirvish" })

	-- completion
	use( { "hrsh7th/cmp-nvim-lsp" } )
	use( { "hrsh7th/cmp-buffer" } )
	use( { "hrsh7th/cmp-path" } )
	use( { "hrsh7th/cmp-cmdline" } )
	use( { "hrsh7th/nvim-cmp" } )
	-- snippets
	use( { "hrsh7th/cmp-vsnip" } )
	use( { "hrsh7th/vim-vsnip" } )
	use( {"honza/vim-snippets" } )

	-- LSP
	use({ "neovim/nvim-lspconfig" })
	-- highlight other occurances of variable under cursor
	use({ "RRethy/vim-illuminate" })

	-- Fuzzy finder
	use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.2',
	-- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
	}

	-- Treesitter - syntax lighting
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	-- objects for moving
	use("nvim-treesitter/nvim-treesitter-textobjects")
	--  shows the context of the currently visible buffer content
	use("romgrk/nvim-treesitter-context")

	-- colorscheme
	use({ "ellisonleao/gruvbox.nvim" })
	use({ 'rose-pine/neovim', as = 'rose-pine' })

	-- show content of registers
	use("tversteeg/registers.nvim")

	-- comments
	use("b3nj5m1n/kommentary")

	-- status line
	use("itchyny/lightline.vim")
	use("mengelbrecht/lightline-bufferline")

	-- useful bindings
	use("tpope/vim-unimpaired")

	-- surround text objects
	use("tpope/vim-surround")

	-- indenting
	use("tpope/vim-sleuth")

	-- Vim sugar for the UNIX shell commands that need it the most
	use("tpope/vim-eunuch")

	-- make more commands repeatable with .
	use("tpope/vim-repeat")

	-- git integration (execute git commands)
	use("lambdalisue/gina.vim")

	-- auto close parens
	use("Raimondi/delimitMate")

	-- visual hints for f and t movements
	use("unblevable/quick-scope")

	-- latex support
	use("lervag/vimtex")

	-- web-based markdown preview
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

	-- digram-based
	use("ggandor/leap.nvim")
	-- leap=enhanced f/t movement
	use("ggandor/flit.nvim")
	use("ggandor/leap-spooky.nvim")
	-- higkight the first occurrence of every char within the current line
	-- use("jinh0/eyeliner.nvim")

	-- easy window resizing
	use({ "simeji/winresizer" })

	-- remember cursor position
	use("ethanholz/nvim-lastplace")

	-- makes built-in LSP actions more use-friendly
	use({ "RishabhRD/popfix" })
	use({ "RishabhRD/nvim-lsputils" })

	-- Text objects
	use("wellle/targets.vim")

	-- defines new text objects based on indentation levels
	use("michaeljsmith/vim-indent-object")
	-- adds indentation guides to all lines (including empty lines).
	use({ "lukas-reineke/indent-blankline.nvim" })

	-- better quickfix windows (including fzf-support and floating previews)
	use({ "kevinhwang91/nvim-bqf" })
	use({
		"junegunn/fzf",
		run = function()
			vim.fn["fzf#install"]()
		end,
	})

	--  persist and toggle multiple terminals during an editing session
	use({ "akinsho/toggleterm.nvim" })

	-- Provides a pretty list for showing diagnostics, references, telescope results, quickfix
	-- and location lists to help you solve all the trouble your code is causing.
	-- use({ "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons" })

	use({ "stevearc/aerial.nvim" })

	use({ "norcalli/nvim-colorizer.lua" })
end)

---------------------------
--      keymappings      --
---------------------------
-- (keymaps are not very lua-y right now
map("n", "<leader>w", "<cmd>cclose<cr>", noremap)
map("n", "<leader>qq", "<C-w>q", noremap)
map("n", "<leader>qw", "<cmd>qa<cr>", noremap)
map("n", "<leader>;", "q:", noremap)
map("n", "<leader><space>", "<cmd>nohlsearch<cr>", noremap)
map("n", "<leader>s", "<cmd>update<cr>", noremap)
map("n", "<leader><leader>", "zz", noremap)
map("n", "<leader>:", "q:", noremap)
map("v", "<leader>:", "q:", {})

-- Make < > shifts keep selection
map("v", "<", "<gv", noremap)
map("v", ">", ">gv", noremap)

-- copy/paste shortcuts
map("n", "Y", "y$", noremap)
map("n", "cy", '"+y', { noremap = true })
map("n", "cp", '"+p', { noremap = true, silent = true })
map("n", "cP", '"+P', { noremap = true, silent = true })

map("n", "c*", '/\\<<C-R>=expand("<cword>")<CR>\\>\\C<CR>``cgn', noremap)
map("n", "c#", '?\\<<C-R>=expand("<cword>")<CR>\\>\\C<CR>``cgn', noremap)

-- global selection
map("x", "ie", "gg0gG$", { noremap = true, silent = true })
map("o", "ie", 'cmd<C-U>execute "normal! m`"<Bar>keepjumps normal! ggVG<CR> ', { noremap = true, silent = true })

-- window movement
-- In normal mode
map("n", "<C-h>", "<C-\\><C-n><C-w>h", noremap)
map("n", "<C-j>", "<C-\\><C-n><C-w>j", noremap)
map("n", "<C-k>", "<C-\\><C-n><C-w>k", noremap)
map("n", "<C-l>", "<C-\\><C-n><C-w>l", noremap)
-- In terminal mode
map("t", "<C-w>", "<C-\\><C-n>", noremap)

-- leap
require("leap").add_default_mappings()
require('leap-spooky').setup {}
-- flit
require("flit").setup({
	keys = { f = "f", F = "F", t = "t", T = "T" },
	-- A string like "nv", "nvo", "o", etc.
	labeled_modes = "nv",
	multiline = true,
})

-- buffer change
map("n", "<leader>1", "<Plug>lightline#bufferline#go(1)", {})
map("n", "<leader>2", "<Plug>lightline#bufferline#go(2)", {})
map("n", "<leader>3", "<Plug>lightline#bufferline#go(3)", {})
map("n", "<leader>4", "<Plug>lightline#bufferline#go(4)", {})
map("n", "<leader>5", "<Plug>lightline#bufferline#go(5)", {})
map("n", "<leader>6", "<Plug>lightline#bufferline#go(6)", {})
map("n", "<leader>7", "<Plug>lightline#bufferline#go(7)", {})
map("n", "<leader>8", "<Plug>lightline#bufferline#go(8)", {})
map("n", "<leader>9", "<Plug>lightline#bufferline#go(9)", {})
map("n", "<leader>0", "<Plug>lightline#bufferline#go(10)", {})
map("n", "<leader>=", "<cmd>bnext<cr>", {})
map("n", "<leader>-", "<cmd>bprevious<cr>", {})

-- buffer deletion

map("n", "<leader>c1", "<Plug>lightline#bufferline#delete(1)", {})
map("n", "<leader>c2", "<Plug>lightline#bufferline#delete(2)", {})
map("n", "<leader>c3", "<Plug>lightline#bufferline#delete(3)", {})
map("n", "<leader>c4", "<Plug>lightline#bufferline#delete(4)", {})
map("n", "<leader>c5", "<Plug>lightline#bufferline#delete(5)", {})
map("n", "<leader>c6", "<Plug>lightline#bufferline#delete(6)", {})
map("n", "<leader>c7", "<Plug>lightline#bufferline#delete(7)", {})
map("n", "<leader>c8", "<Plug>lightline#bufferline#delete(8)", {})
map("n", "<leader>c9", "<Plug>lightline#bufferline#delete(9)", {})
map("n", "<leader>c10", "<Plug>lightline#bufferline#delete(10)", {})

-- gina keymaps
map("n", "<leader>gs", "<cmd>Gina status<cr>", noremap)
map("n", "<leader>gc", "<cmd>Gina commit<cr>", noremap)
map("n", "<leader>gp", "<cmd>Gina push<cr>", noremap)

---------------------------
--    global settings    --
---------------------------
opt.syntax = "enable"
-- TODO: convert the following line to proper lua
cmd([[filetype plugin indent on]])
opt.hidden = true
opt.ignorecase = true
opt.smartcase = true
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cmdheight = 2
opt.incsearch = true
opt.hlsearch = false
opt.smartindent = true -- Insert indents automatically
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.inccommand = "nosplit"
opt.exrc = true
opt.secure = true
opt.termguicolors = true
g.tex_flavor = "latex"

opt.history = 1000
opt.undolevels = 10000
opt.undoreload = 100000

-- maintain undo history between session
opt.undofile = true
opt.undodir = "./.undodir"

-- Highlight on yank
cmd([[au TextYankPost * lua vim.highlight.on_yank {on_visual = false}]])

---------------------------
--      status line      --
---------------------------
opt.showmode = false
g.lightline = {
	colorscheme = "one",
	active = {
		left = { { "mode", "paste" }, { "readonly", "relativepath", "modified" } },
	},
	tabline = {
		left = { { "buffers" } },
	},
	component_expand = {
		buffers = "lightline#bufferline#buffers",
	},
	component_type = {
		buffers = "tabsel",
	},
}
g.lightline.component = { lineinfo = "%3l/%L  col %-2v", percent = "" }
opt.showtabline = 2
g["lightline#bufferline#show_number"] = 2

---------------------------
--    various plugins    --
---------------------------
-- indent_blacnkline
require("indent_blankline").setup({
	show_end_of_line = true,
	space_char_blankline = " ",
	-- show_current_context = true,
	use_treesitter = true,
	-- use_treesitter_scope = true,
	-- show_current_context_start = true,
})

-- quick scope
g.qs_highlight_on_keys = { "f", "F", "t", "T" }

-- vimtex
g.vimtex_quickfix_ignore_filters = { 'Missing "pages" in' }
g.vimtex_view_method = "skim"
g.vimtex_view_skim_sync = 1 -- Value 1 allows forward search after every successful compilation
g.vimtex_view_skim_activate = 1 -- Value 1 allows change focus to skim after command `:VimtexView` is given
g.vimtex_quickfix_ignore_filters = { 'Missing "pages" in', "Underfull", "Overfull" }
--[[ g.vimtex_compiler_latexmk = {
	build_dir = ".",
	options = {
		"-shell-escape",
		"-verbose",
		"-interaction=nonstopmode",
		"-synctex=1",
	},
} ]]

-- lastplace
require("nvim-lastplace").setup({
	lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
	lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
	lastplace_open_folds = true,
})

-- bqf [ https://github.com/kevinhwang91/nvim-bqf ]
require("bqf").setup({
	auto_enable = true,
	auto_resize_height = true, -- highly recommended enable
	preview = {
		win_height = 12,
		win_vheight = 12,
	},
})

-- toggleterm [ https://github.com/akinsho/toggleterm.nvim ]
require("toggleterm").setup({
	-- size can be a number or function which is passed the current terminal
	size = function(term)
		if term.direction == "horizontal" then
			return 12
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.35
		end
	end,
	open_mapping = [[<c-\>]],
	shade_terminals = false,
	start_in_insert = false,
	insert_mappings = true, -- whether or not the open mapping applies in insert mode
	terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
	persist_size = true,
	close_on_exit = true, -- close the terminal window when the process exits
	shell = vim.o.shell, -- change the default shell
})

--- trouble [ https://github.com/folke/trouble.nvim ]
--[[ require("trouble").setup({
	position = "right", -- position of the list can be: bottom, top, left, right
	height = 10, -- height of the trouble list when position is top or bottom
	width = 30, -- width of the list when position is left or right
	icons = true, -- use devicons for filenames
	mode = "document_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
	fold_open = "", -- icon used for open folds
	fold_closed = "", -- icon used for closed folds
	group = true, -- group results by file
	padding = true, -- add an extra new line on top of the list
	action_keys = { -- key mappings for actions in the trouble list
		-- map to {} to remove a mapping, for example:
		-- close = {},
		close = "q", -- close the list
		cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
		refresh = "r", -- manually refresh
		jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
		open_split = { "<c-x>" }, -- open buffer in new split
		open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
		open_tab = { "<c-t>" }, -- open buffer in new tab
		jump_close = { "o" }, -- jump to the diagnostic and close the list
		toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
		toggle_preview = "P", -- toggle auto_preview
		hover = "K", -- opens a small popup with the full multiline message
		preview = "p", -- preview the diagnostic location
		close_folds = { "zM", "zm" }, -- close all folds
		open_folds = { "zR", "zr" }, -- open all folds
		toggle_fold = { "zA", "za" }, -- toggle fold of current file
		previous = "k", -- preview item
		next = "j", -- next item
	},
	indent_lines = true, -- add an indent guide below the fold icons
	auto_open = false, -- automatically open the list when you have diagnostics
	auto_close = false, -- automatically close the list when you have no diagnostics
	auto_preview = false, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
	auto_fold = false, -- automatically fold a file trouble list at creation
	-- auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
	signs = {
		-- icons / text used for a diagnostic
		error = "",
		warning = "",
		hint = "",
		information = "",
		other = "﫠",
	},
	use_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
}) ]]

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Trouble
--[[ vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>Trouble<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tw", "<cmd>Trouble workspace_diagnostics<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>to", "<cmd>Trouble document_diagnostics<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tl", "<cmd>Trouble loclist<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tq", "<cmd>Trouble quickfix<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>", { silent = true, noremap = true }) ]]

--- aerial.nvim [ https://github.com/stevearc/aerial.nvim ]
require("aerial").setup({
	-- Highlight the closest symbol if the cursor is not exactly on one.
	highlight_closest = true,
	-- Highlight the symbol in the source buffer when cursor is in the aerial win
	highlight_on_hover = true,
	show_guides = false,
	-- Automatically open aerial when entering supported buffers.
	-- This can be a function (see :help aerial-open-automatic)
	open_automatic = false,
	layout = {
		-- These control the width of the aerial window.
		-- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
		-- min_width and max_width can be a list of mixed types.
		-- max_width = {40, 0.2} means "the lesser of 40 columns or 20% of total"
		max_width = { 40, 0.2 },
		width = nil,
		min_width = 10,

		-- key-value pairs of window-local options for aerial window (e.g. winhl)
		win_opts = {},

		-- Determines the default direction to open the aerial window. The 'prefer'
		-- options will open the window in the other direction *if* there is a
		-- different buffer in the way of the preferred direction
		-- Enum: prefer_right, prefer_left, right, left, float
		default_direction = "prefer_left",

		-- Determines where the aerial window will be opened
		--   edge   - open aerial at the far right/left of the editor
		--   window - open aerial to the right/left of the current window
		placement = "window",

		-- Preserve window size equality with (:help CTRL-W_=)
		preserve_equality = false,
	},

	backends = { "treesitter", "lsp", "markdown", "man" },
	lsp = {
		-- Fetch document symbols when LSP diagnostics update.
		-- If false, will update on buffer changes.
		diagnostics_trigger_update = true,

		-- Set to false to not update the symbols when there are LSP errors
		update_when_errors = true,

		-- How long to wait (in ms) after a buffer change before updating
		-- Only used when diagnostics_trigger_update = false
		update_delay = 300,
	},

	treesitter = {
		-- How long to wait (in ms) after a buffer change before updating
		update_delay = 300,
	},

	markdown = {
		-- How long to wait (in ms) after a buffer change before updating
		update_delay = 300,
	},

	man = {
		-- How long to wait (in ms) after a buffer change before updating
		update_delay = 300,
	},

	-- Keymaps in aerial window. Can be any value that `vim.keymap.set` accepts OR a table of keymap
	-- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
	-- Additionally, if it is a string that matches "aerial.<name>",
	-- it will use the mapping at require("aerial.action").<name>
	-- Set to `false` to remove a keymap
	keymaps = {
		["?"] = "actions.show_help",
		["g?"] = "actions.show_help",
		["<CR>"] = "actions.jump",
		["<2-LeftMouse>"] = "actions.jump",
		["<C-v>"] = "actions.jump_vsplit",
		["<C-s>"] = "actions.jump_split",
		["p"] = "actions.scroll",
		["<C-j>"] = "actions.down_and_scroll",
		["<C-k>"] = "actions.up_and_scroll",
		["{"] = "actions.prev",
		["}"] = "actions.next",
		["[["] = "actions.prev_up",
		["]]"] = "actions.next_up",
		["q"] = "actions.close",
		["o"] = "actions.tree_toggle",
		["za"] = "actions.tree_toggle",
		["O"] = "actions.tree_toggle_recursive",
		["zA"] = "actions.tree_toggle_recursive",
		["l"] = "actions.tree_open",
		["zo"] = "actions.tree_open",
		["L"] = "actions.tree_open_recursive",
		["zO"] = "actions.tree_open_recursive",
		["h"] = "actions.tree_close",
		["zc"] = "actions.tree_close",
		["H"] = "actions.tree_close_recursive",
		["zC"] = "actions.tree_close_recursive",
		["zr"] = "actions.tree_increase_fold_level",
		["zR"] = "actions.tree_open_all",
		["zm"] = "actions.tree_decrease_fold_level",
		["zM"] = "actions.tree_close_all",
		["zx"] = "actions.tree_sync_folds",
		["zX"] = "actions.tree_sync_folds",
	},

	-- Call this function when aerial attaches to a buffer.
	on_attach = function(bufnr)
		-- fzf integration
		map("n", "<C-f>", "<cmd>call aerial#fzf()<cr>", { silent = true, noremap = true })
	end,
})
vim.keymap.set("n", "<leader>l", "<cmd>AerialToggle!<CR>")

---------------------------
--     Treesitter        --
---------------------------
local ts = require("nvim-treesitter.configs")
ts.setup({
	-- A list of parser names, or "all"
	ensure_installed = { "python", "rust", "lua", "yaml" },

	-- Install languages synchronously (only applied to `ensure_installed`)
	sync_install = true,

	-- List of parsers to ignore installing
	ignore_install = {},

	highlight = {
		-- `false` will disable the whole extension
		enable = true,

		-- list of language that will be disabled
		disable = {},

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
})

---------------------------
--     colorscheme       --
---------------------------
vim.o.background = "dark"
vim.opt.termguicolors = true
-- vim.cmd("colorscheme gruvbox")
vim.cmd("colorscheme rose-pine")
-- execute([[hi TreesitterContext ctermbg=gray guibg=Gray]])
-- colorscheme noctis

---------------------------
--      Completion       --
---------------------------
-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
		vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
		-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
		-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
		-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	window = {
	-- completion = cmp.config.window.bordered(),
	-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

	    ["<Tab>"] = cmp.mapping(function(fallback)
		      if cmp.visible() then
			cmp.select_next_item()
		      -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
		      -- they way you will only jump inside the snippet region
		      --[[ elseif luasnip.expand_or_jumpable() then
			luasnip.expand_or_jump() ]]
		      --[[ elseif has_words_before() then
			cmp.complete() ]]
		      else
			fallback()
		      end
		    end, { "i", "s" }),

	    ["<S-Tab>"] = cmp.mapping(function(fallback)
		      if cmp.visible() then
			cmp.select_prev_item()
		      elseif luasnip.jumpable(-1) then
			luasnip.jump(-1)
		      else
			fallback()
		      end
		    end, { "i", "s" }),
	}),

	sources = cmp.config.sources({ 
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' }, -- For vsnip users.
		{ name = 'luasnip' }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
		}, {
		{ name = 'buffer' },
		})
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
	{ name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
	}, {
	{ name = 'buffer' },
	})
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
	{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
	{ name = 'path' }
	}, {
	{ name = 'cmdline' }
	})
})

---------------------------
--         LSP           --
---------------------------
-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    --[[ vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts) ]]
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.api.nvim_command([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]])
    vim.keymap.set('n', '\\f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

local lspconfig = require("lspconfig")
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.pyright.setup({
	-- on_attach = on_attach,
	exclude = { "**/undodir", "**/~" },
	capabilities = capabilities,
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "basic",
				autoImportCompletions = true,
			},
		},
	},
})
lspconfig.rust_analyzer.setup({
	-- on_attach = on_attach,
	settings = {
		["rust-analyzer"] = {
			assist = {
				importGranularity = "module",
				importPrefix = "by_self",
			},
			cargo = {
				loadOutDirsFromCheck = true,
			},
			procMacro = {
				enable = true,
			},
		},
	},
})

--- vim-illuminate [https://github.com/RRethy/vim-illuminate]
require("illuminate").configure({
	-- providers: provider used to get references in the buffer, ordered by priority
	providers = {
		"lsp",
		"treesitter",
		"regex",
	},
	-- delay: delay in milliseconds
	delay = 100,
	-- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
	filetypes_denylist = {
		"dirvish",
		"fugitive",
	},
	under_cursor = true,
})

---------------------------
--    LSP Diagnostics    --
---------------------------
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization
---- Customize how to show diagnostics:
-- No virtual text (distracting!), show popup window on hover.
-- @see https://github.com/neovim/neovim/pull/16057 for new APIs
vim.diagnostic.config({
	virtual_text = true,
	underline = {
		-- Do not underline text when severity is low (INFO or HINT).
		-- severity = { min = vim.diagnostic.severity.WARN },
	},
	float = {
		source = "always",
		focusable = false, -- See neovim#16425
		border = "single",

		-- Customize how diagnostic message will be shown: show error code.
		format = function(diagnostic)
			-- See null-ls.nvim#632, neovim#17222 for how to pick up `code`
			local user_data
			user_data = diagnostic.user_data or {}
			user_data = user_data.lsp or user_data.null_ls or user_data
			local code = (diagnostic.symbol or diagnostic.code or user_data.symbol or user_data.code)
			if code then
				return string.format("%s (%s)", diagnostic.message, code)
			else
				return diagnostic.message
			end
		end,
	},
})

_G.LspDiagnosticsShowPopup = function()
	return vim.diagnostic.open_float(0, { focus = false, scope = "cursor" })
end

_G.LspDiagnosticsPopupHandler = function()
	local current_cursor = vim.api.nvim_win_get_cursor(0)
	local last_popup_cursor = vim.w.lsp_diagnostics_last_cursor or { nil, nil }

	-- Show the popup diagnostics window,
	-- but only once for the current cursor location (unless moved afterwards).
	if not (current_cursor[1] == last_popup_cursor[1] and current_cursor[2] == last_popup_cursor[2]) then
		vim.w.lsp_diagnostics_last_cursor = current_cursor
		local _, winnr = _G.LspDiagnosticsShowPopup()
		if winnr ~= nil then
			vim.api.nvim_win_set_option(winnr, "winblend", 20) -- opacity for diagnostics
		end
	end
end

vim.o.updatetime = 100
vim.fn.sign_define("DiagnosticSignError", { text = "✘", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "i", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
vim.cmd([[
hi DiagnosticSignError    guifg=#e6645f ctermfg=167
hi DiagnosticSignWarn     guifg=#b1b14d ctermfg=143
hi DiagnosticSignHint     guifg=#3e6e9e ctermfg=75
]])

--- EFM LSP for async formatting/linting ---
local on_attach = function(client)
	if client.server_capabilities.document_formatting then
		vim.api.nvim_command([[augroup Format]])
		vim.api.nvim_command([[autocmd! * <buffer>]])
		vim.api.nvim_command([[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()]])
		vim.api.nvim_command([[augroup END]])
	end
end

lspconfig.efm.setup({
	init_options = { documentFormatting = true },
	on_attach = on_attach,
	filetypes = { "python", "yaml" },
})

local set_query = vim.treesitter.query.set or vim.treesitter.set_query -- renamed in nvim 0.9
-- inject reST syntax highlighting into python docstrings
set_query(
	"python",
	"injections",
	[[
((call
  function: (attribute
	  object: (identifier) @_re)
  arguments: (argument_list (string) @regex))
 (#eq? @_re "re")
 (#lua-match? @regex "^r.*"))

; Module docstring
((module . (expression_statement (string) @rst))
 (#offset! @rst 0 3 0 -3))

; Class docstring
((class_definition
  body: (block . (expression_statement (string) @rst)))
 (#offset! @rst 0 3 0 -3))

; Function/method docstring
((function_definition
  body: (block . (expression_statement (string) @rst)))
 (#offset! @rst 0 3 0 -3))

; Attribute docstring
(((expression_statement (assignment)) . (expression_statement (string) @rst))
 (#offset! @rst 0 3 0 -3))

(comment) @comment
]]
)
