---------------------------
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
g.coq_settings = {
	["auto_start"] = true,
	["keymap.recommended"] = true,
	["keymap.jump_to_mark"] = "<c-y>",
}

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

	-- Path navigator designed to work with Vim's built-in mechanisms and complementary plugins
	use({ "justinmk/vim-dirvish" })

	-- completion
	use({ "ms-jpq/coq_nvim", branch = "coq" }) -- main one
	use({ "ms-jpq/coq.artifacts", branch = "artifacts" }) -- 9000+ Snippets
	use({ "nvim-lua/completion-nvim" })

	-- LSP
	use({ "neovim/nvim-lspconfig" })
	-- highlight other occurances of variable under cursor
	use({ "RRethy/vim-illuminate" })

	-- Fuzzy finder (i.e., replacement for FZF)
	use({
		"ibhagwan/fzf-lua",
		requires = {
			"vijaymarupudi/nvim-fzf",
			"kyazdani42/nvim-web-devicons",
		}, -- optional for icons
	})

	-- Treesitter - syntax lighting
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	-- objects for moving
	use("nvim-treesitter/nvim-treesitter-textobjects")
	--  shows the context of the currently visible buffer content
	use("romgrk/nvim-treesitter-context")

	-- colorscheme
	use({ "ellisonleao/gruvbox.nvim" })

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

	-- snippets
	use("hrsh7th/vim-vsnip") -- VSCode(LSP)'s snippet feature in vim
	use("honza/vim-snippets") -- snippet collection

	-- git integration (execute git commands)
	use("lambdalisue/gina.vim")

	-- auto close parens
	use("Raimondi/delimitMate")

	-- visual hints for f and t movements
	use("unblevable/quick-scope")

	-- latex support
	use("lervag/vimtex")

	-- digram-based/cross-line f/t movement
	use("ggandor/lightspeed.nvim")

	-- easy window resizing
	use({ "simeji/winresizer" })

	-- remember cursor position
	use("ethanholz/nvim-lastplace")

	-- makes built-in LSP actions more use-friendly
	use({ "RishabhRD/popfix" })
	use({ "RishabhRD/nvim-lsputils" })

	-- Text objects
	use("wellle/targets.vim")

	-- defines a new text object, based on indentation levels
	use("michaeljsmith/vim-indent-object")

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
	use({ "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons" })

	use({ "stevearc/aerial.nvim" })
end)

---------------------------
--      keymappings      --
---------------------------
-- (keymaps are not very lua-y right now,
--  but there is a PR to change this:
--- https://github.com/neovim/neovim/pull/13823)
-- general mappings
map("n", "<leader>w", "<cmd>cclose<cr>", noremap)
map("n", "<C-q>", "<C-w>q", noremap)
map("n", "<leader>q", "<cmd>qa<cr>", noremap)
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

-- lightspeed settings
require("lightspeed").setup({
	ignore_case = true,
	repeat_ft_with_target_char = true,
})

-- fzf-lua
map("n", "<C-p>", "<cmd>lua require('fzf-lua').files()<CR>", { noremap = true, silent = true })
map("n", "<leader>f", "<cmd>lua require('fzf-lua').live_grep()<CR>", { noremap = true, silent = true })
map("n", "<leader><C-f>", "<cmd>lua require('fzf-lua').live_grep_resume()<CR>", { noremap = true, silent = true })
map("n", "<leader>\\", "<cmd>lua require('fzf-lua').quickfix()<CR>", { noremap = true, silent = true })
map("n", "<leader>a", "<cmd>lua require('fzf-lua').code_actions()<CR>", { noremap = true, silent = true })
map("n", "<leader>/", "<cmd>lua require('fzf-lua').lines()<CR>", { noremap = true, silent = true })
-- LSP integration
map("n", "<leader>o", "<cmd>lua require('fzf-lua').lsp_document_symbols()<CR>", { noremap = true, silent = true })
map("n", "<leader>w", "<cmd>lua require('fzf-lua').lsp_live_workspace_symbols()<CR>", {
	noremap = true,
	silent = true,
})
map("n", "<leader>[", "<cmd>lua require('fzf-lua').lsp_document_diagnostics()<CR>", { noremap = true, silent = true })
map("n", "<leader>]", "<cmd>lua require('fzf-lua').lsp_workspace_diagnostics()<CR>", { noremap = true, silent = true })

local actions = require("fzf-lua.actions")
require("fzf-lua").setup({
	winopts = {
		-- split         = "belowright new",-- open in a split instead?
		-- "belowright new"  : split below
		-- "aboveleft new"   : split above
		-- "belowright vnew" : split right
		-- "aboveleft vnew   : split left
		win_height = 0.85, -- window height
		win_width = 0.80, -- window width
		win_row = 0.30, -- window row position (0=top, 1=bottom)
		win_col = 0.50, -- window col position (0=left, 1=right)
		-- win_border    = false,           -- window border? or borderchars?
		win_border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		hl_normal = "Normal", -- window normal color
		hl_border = "FloatBorder", -- window border color
	},
	keymap = { -- fzf '--bind=' options
		builtin = {
			-- neovim `:tmap` mappings for the fzf win
			["<F2>"] = "toggle-fullscreen",
			-- Only valid with the 'builtin' previewer
			["<F3>"] = "toggle-preview-wrap",
			["<F4>"] = "toggle-preview",
			-- Rotate preview clockwise/counter-clockwise
			["<F5>"] = "toggle-preview-ccw",
			["<F6>"] = "toggle-preview-cw",
			["<S-down>"] = "preview-page-down",
			["<S-up>"] = "preview-page-up",
			["<S-left>"] = "preview-page-reset",
		},
	},
	-- use skim instead of fzf?
	-- https://github.com/lotabout/skim
	-- fzf_bin          = 'sk',
	fzf_opts = {
		-- options are sent as `<left>=<right>`
		-- set to `false` to remove a flag
		-- set to '' for a non-value flag
		-- for raw args use `fzf_args` instead
		["--ansi"] = "",
		["--prompt"] = " >",
		["--info"] = "inline",
		["--height"] = "100%",
		["--layout"] = "reverse",
	},
	preview_border = "border", -- border|noborder
	preview_wrap = "nowrap", -- wrap|nowrap
	preview_opts = "nohidden", -- hidden|nohidden
	preview_vertical = "down:45%", -- up|down:size
	preview_horizontal = "right:60%", -- right|left:size
	preview_layout = "flex", -- horizontal|vertical|flex
	flip_columns = 120, -- #cols to switch to horizontal on flex
	-- default_previewer   = "bat",       -- override the default previewer?
	-- by default uses the builtin previewer
	previewers = {
		cat = {
			cmd = "cat",
			args = "--number",
		},
		bat = {
			cmd = "bat",
			args = "--style=numbers,changes --color always",
			theme = "Coldark-Dark", -- bat preview theme (bat --list-themes)
			config = nil, -- nil uses $BAT_CONFIG_PATH
		},
		head = {
			cmd = "head",
			args = nil,
		},
		git_diff = {
			cmd = "git diff",
			args = "--color",
		},
	},
	-- provider setup
	files = {
		-- previewer         = "cat",       -- uncomment to override previewer
		prompt = "Files❯ ",
		cmd = "", -- "find . -type f -printf '%P\n'",
		git_icons = true, -- show git icons?
		file_icons = true, -- show file icons?
		color_icons = true, -- colorize file|git icons
		actions = {
			-- set bind to 'false' to disable
			["default"] = actions.file_edit,
			["ctrl-s"] = actions.file_split,
			["ctrl-v"] = actions.file_vsplit,
			["ctrl-t"] = actions.file_tabedit,
			["ctrl-q"] = actions.file_sel_to_qf,
			-- custom actions are available too
			["ctrl-y"] = function(selected)
				print(selected[2])
			end,
		},
	},
	git = {
		files = {
			prompt = "GitFiles❯ ",
			cmd = "git ls-files --exclude-standard",
			git_icons = true, -- show git icons?
			file_icons = true, -- show file icons?
			color_icons = true, -- colorize file|git icons
		},
		status = {
			prompt = "GitStatus❯ ",
			cmd = "git status -s",
			previewer = "git_diff",
			file_icons = true,
			git_icons = true,
			color_icons = true,
		},
		commits = {
			prompt = "Commits❯ ",
			cmd = "git log --pretty=oneline --abbrev-commit --color --reflog",
			preview = "git show --pretty='%Cred%H%n%Cblue%an%n%Cgreen%s' --color {1}",
			actions = {
				["default"] = actions.git_checkout,
			},
		},
		bcommits = {
			prompt = "BCommits❯ ",
			cmd = "git log --pretty=oneline --abbrev-commit --color --reflog",
			preview = "git show --pretty='%Cred%H%n%Cblue%an%n%Cgreen%s' --color {1}",
			actions = {
				["default"] = actions.git_buf_edit,
				["ctrl-s"] = actions.git_buf_split,
				["ctrl-v"] = actions.git_buf_vsplit,
				["ctrl-t"] = actions.git_buf_tabedit,
			},
		},
		branches = {
			prompt = "Branches❯ ",
			cmd = "git branch --all --color",
			preview = "git log --graph --pretty=oneline --abbrev-commit --color {1}",
			actions = {
				["default"] = actions.git_switch,
			},
		},
		icons = {
			["M"] = { icon = "M", color = "yellow" },
			["D"] = { icon = "D", color = "red" },
			["A"] = { icon = "A", color = "green" },
			["?"] = { icon = "?", color = "magenta" },
			-- ["M"]          = { icon = "★", color = "red" },
			-- ["D"]          = { icon = "✗", color = "red" },
			-- ["A"]          = { icon = "+", color = "green" },
		},
	},
	grep = {
		prompt = "Rg❯ ",
		input_prompt = "Grep For❯ ",
		-- cmd               = "rg --vimgrep",
		rg_opts = "--hidden --column --line-number --no-heading "
			.. "--color=always --smart-case -g '!{.git,node_modules}/*'",
		git_icons = true, -- show git icons?
		file_icons = true, -- show file icons?
		color_icons = true, -- colorize file|git icons
	},
	oldfiles = {
		prompt = "History❯ ",
		cwd_only = false,
	},
	buffers = {
		-- previewer      = false,        -- disable the builtin previewer?
		prompt = "Buffers❯ ",
		file_icons = true, -- show file icons?
		color_icons = true, -- colorize file|git icons
		sort_lastused = true, -- sort buffers() by last used
		actions = {
			["default"] = actions.buf_edit,
			["ctrl-s"] = actions.buf_split,
			["ctrl-v"] = actions.buf_vsplit,
			["ctrl-t"] = actions.buf_tabedit,
			["ctrl-x"] = actions.buf_del,
		},
	},
	blines = {
		previewer = "builtin", -- set to 'false' to disable
		prompt = "BLines❯ ",
		actions = {
			["default"] = actions.buf_edit,
			["ctrl-s"] = actions.buf_split,
			["ctrl-v"] = actions.buf_vsplit,
			["ctrl-t"] = actions.buf_tabedit,
		},
	},
	colorschemes = {
		prompt = "Colorschemes❯ ",
		live_preview = true, -- apply the colorscheme on preview?
		actions = {
			["default"] = actions.colorscheme,
			["ctrl-y"] = function(selected)
				print(selected[2])
			end,
		},
		winopts = {
			win_height = 0.55,
			win_width = 0.30,
		},
		post_reset_cb = function()
			-- reset statusline highlights after
			-- a live_preview of the colorscheme
			-- require('feline').reset_highlights()
		end,
	},
	quickfix = {
		-- cwd               = vim.loop.cwd(),
		file_icons = true,
		git_icons = true,
	},
	lsp = {
		prompt = "❯ ",
		-- cwd               = vim.loop.cwd(),
		cwd_only = false, -- LSP/diagnostics for cwd only?
		async_or_timeout = true, -- timeout(ms) or false for blocking calls
		file_icons = true,
		git_icons = false,
		lsp_icons = true,
		severity = "hint",
		icons = {
			["Error"] = { icon = "", color = "red" }, -- error
			["Warning"] = { icon = "", color = "yellow" }, -- warning
			["Information"] = { icon = "", color = "blue" }, -- info
			["Hint"] = { icon = "", color = "magenta" }, -- hint
		},
	},
	file_icon_padding = "",
	file_icon_colors = {
		["lua"] = "blue",
	},
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
opt.undodir = "~/.config/nvim/undodir"

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
-- quick scope
g.qs_highlight_on_keys = { "f", "F", "t", "T" }

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
require("trouble").setup({
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
})

vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>Trouble<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tw", "<cmd>Trouble workspace_diagnostics<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>td", "<cmd>Trouble document_diagnostics<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tl", "<cmd>Trouble loclist<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tq", "<cmd>Trouble quickfix<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>", { silent = true, noremap = true })

--- aerial.nvim [ https://github.com/stevearc/aerial.nvim ]
require("aerial").setup({
	-- Highlight the closest symbol if the cursor is not exactly on one.
	highlight_closest = true,
	-- Highlight the symbol in the source buffer when cursor is in the aerial win
	highlight_on_hover = true,
	-- These control the width of the aerial window.
	-- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
	-- min_width and max_width can be a list of mixed types.
	-- max_width = {40, 0.2} means "the lesser of 40 columns or 20% of total"
	max_width = { 40, 0.2 },
	width = nil,
	min_width = 20,
	-- Show box drawing characters for the tree hierarchy
	show_guides = false,
	-- Automatically open aerial when entering supported buffers.
	-- This can be a function (see :help aerial-open-automatic)
	open_automatic = false,
	-- Enum: prefer_right, prefer_left, right, left, float
	-- Determines the default direction to open the aerial window. The 'prefer'
	-- options will open the window in the other direction *if* there is a
	-- different buffer in the way of the preferred direction
	default_direction = "prefer_left",

	on_attach = function(bufnr)
		-- Toggle the aerial window with <leader>a
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ll", "<cmd>AerialToggle!<CR>", {})
		-- Jump forwards/backwards with '{' and '}'
		vim.api.nvim_buf_set_keymap(bufnr, "n", "{", "<cmd>AerialPrev<CR>", {})
		vim.api.nvim_buf_set_keymap(bufnr, "n", "}", "<cmd>AerialNext<CR>", {})
		-- Jump up the tree with '[[' or ']]'
		vim.api.nvim_buf_set_keymap(bufnr, "n", "[[", "<cmd>AerialPrevUp<CR>", {})
		vim.api.nvim_buf_set_keymap(bufnr, "n", "]]", "<cmd>AerialNextUp<CR>", {})
		vim.api.nvim_buf_set_keymap(bufnr, "n", "]]", "<cmd>AerialNextUp<CR>", {})
	end,
})
-- fzf integration
map("n", "<leader>lf", "<cmd>call aerial#fzf()<cr>", { silent = true, noremap = false })

---------------------------
--     Treesitter        --
---------------------------
local ts = require("nvim-treesitter.configs")
ts.setup({
	-- One of "all", "maintained" (parsers with maintainers), or a list of languages
	ensure_installed = "maintained",

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
vim.cmd("colorscheme gruvbox")
execute([[hi TreesitterContext ctermbg=gray guibg=Gray]])

---------------------------
--        icons          --
---------------------------
require("nvim-web-devicons").setup({
	-- your personnal icons can go here (to override)
	-- you can specify color or cterm_color instead of specifying both of them
	-- DevIcon will be appended to `name`
	override = {
		zsh = {
			icon = "",
			color = "#428850",
			cterm_color = "65",
			name = "Zsh",
		},
	},
	-- globally enable default icons (default to false)
	-- will get overriden by `get_icons` option
	default = true,
})

---------------------------
--         LSP           --
---------------------------
local on_attach = function(client, bufnr)
	require("completion").on_attach()

	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	---------------------------
	--   LSP key mappings    --
	---------------------------
	local opts = { noremap = true, silent = true }
	buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<leader>k", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	-- diagnostics-related bindings
	buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)

	vim.api.nvim_command([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]])
	-- nvim-lsputils-
	vim.lsp.handlers["textDocument/codeAction"] = require("lsputil.codeAction").code_action_handler
	vim.lsp.handlers["textDocument/references"] = require("lsputil.locations").references_handler
	vim.lsp.handlers["textDocument/definition"] = require("lsputil.locations").definition_handler
	vim.lsp.handlers["textDocument/declaration"] = require("lsputil.locations").declaration_handler
	vim.lsp.handlers["textDocument/typeDefinition"] = require("lsputil.locations").typeDefinition_handler
	vim.lsp.handlers["textDocument/implementation"] = require("lsputil.locations").implementation_handler
	vim.lsp.handlers["textDocument/documentSymbol"] = require("lsputil.symbols").document_handler
	vim.lsp.handlers["workspace/symbol"] = require("lsputil.symbols").workspace_handler

	-- hook in plugins depending on LSP
	require("illuminate").on_attach(client)
	-- require("aerial").on_attach(client)
end

local lspconfig = require("lspconfig")
local coq = require("coq")

lspconfig.pyright.setup({
	on_attach = on_attach,
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
	on_attach = on_attach,
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

-- when highlighting other occurances of a variable
-- don't highlight the variable itself
g.Illuminate_highlightUnderCursor = 0

---------------------------
--    LSP Diagnostics    --
---------------------------
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization
---- Customize how to show diagnostics:
-- No virtual text (distracting!), show popup window on hover.
-- @see https://github.com/neovim/neovim/pull/16057 for new APIs
vim.diagnostic.config({
	virtual_text = false,
	underline = {
		-- Do not underline text when severity is low (INFO or HINT).
		severity = { min = vim.diagnostic.severity.WARN },
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
			local code = (
										-- TODO: symbol is specific to pylint (will be removed)
diagnostic.symbol
					or diagnostic.code
					or user_data.symbol
					or user_data.code
				)
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
vim.cmd([[
augroup LSPDiagnosticsOnHover
  autocmd!
  autocmd CursorHold * lua _G.LspDiagnosticsPopupHandler()
augroup END
]])

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
	if client.resolved_capabilities.document_formatting then
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
