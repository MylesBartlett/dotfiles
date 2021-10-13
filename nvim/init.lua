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
	use("nvim-treesitter/nvim-treesitter")
	-- objects for moving
	use("nvim-treesitter/nvim-treesitter-textobjects")
	--  shows the context of the currently visible buffer content
	use("romgrk/nvim-treesitter-context")

	-- colorscheme
	use({ "npxbr/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } })

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

	-- git integration (mark added/modified/deleted lines)
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitsigns").setup()
		end,
	})

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
	use({ "farmergreg/vim-lastplace" })

	-- makes built-in LSP actions more use-friendly
	use({ "RishabhRD/popfix" })
	use({ "RishabhRD/nvim-lsputils" })

	-- Text objects
	use("wellle/targets.vim")
end)

---------------------------
--      keymappings      --
---------------------------
-- (keymaps are not very lua-y right now,
--  but there is a PR to change this:
--- https://github.com/neovim/neovim/pull/13823)
-- general mappings
map("n", "<leader>w", "<cmd>cclose<cr>", noremap)
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

-- lightspeed settings
require("lightspeed").setup({
	jump_to_first_match = true,
	jump_on_partial_input_safety_timeout = 400,
	-- This can get _really_ slow if the window has a lot of content,
	-- turn it on only if your machine can always cope with it.
	highlight_unique_chars = false,
	grey_out_search_area = true,
	match_only_the_start_of_same_char_seqs = true,
	limit_ft_matches = 5,
	x_mode_prefix_key = "<c-x>",
	substitute_chars = { ["\r"] = "¬" },
	instant_repeat_fwd_key = nil,
	instant_repeat_bwd_key = nil,
	-- If no values are given, these will be set at runtime,
	-- based on `jump_to_first_match`.
	labels = nil,
	cycle_group_fwd_key = nil,
	cycle_group_bwd_key = nil,
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
	      ["<F2>"]        = "toggle-fullscreen",
	      -- Only valid with the 'builtin' previewer
	      ["<F3>"]        = "toggle-preview-wrap",
	      ["<F4>"]        = "toggle-preview",
	      -- Rotate preview clockwise/counter-clockwise
	      ["<F5>"]        = "toggle-preview-ccw",
	      ["<F6>"]        = "toggle-preview-cw",
	      ["<S-down>"]    = "preview-page-down",
	      ["<S-up>"]      = "preview-page-up",
	      ["<S-left>"]    = "preview-page-reset",
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
	  ['--ansi']        = '',
	  ['--prompt']      = ' >',
	  ['--info']        = 'inline',
	  ['--height']      = '100%',
	  ['--layout']      = 'reverse',
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
-- python-related mappings
map("n", "<leader>i", "<cmd>PyrightOrganizeImports<cr>", noremap)
map("n", "<leader>e", "ofrom IPython import embed; embed()<esc>", noremap)
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
	colorscheme = "wombat",
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

---------------------------
--     Treesitter        --
---------------------------
local ts = require("nvim-treesitter.configs")
ts.setup({
	ensure_installed = "maintained",
	highlight = { enable = true },
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
        }, ]]
			},
		},
	},
})

---------------------------
--     colorscheme       --
---------------------------
vim.o.background = "dark"
cmd([[colorscheme gruvbox]])

execute([[hi TreesitterContext ctermbg=gray guibg=Gray]])

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
	buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)

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
end

local lspconfig = require("lspconfig")
local coq = require("coq")

lspconfig.html.setup(coq.lsp_ensure_capabilities({ on_attach = on_attach }))
lspconfig.pyright.setup({
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

--- EFM LSP for formatting ---

local on_attach = function(client)
	if client.resolved_capabilities.document_formatting then
		vim.api.nvim_command([[augroup Format]])
		vim.api.nvim_command([[autocmd! * <buffer>]])
		vim.api.nvim_command([[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()]])
		vim.api.nvim_command([[augroup END]])
	end
end

lspconfig.efm.setup({
	init_options = { documentFormatting = true, codeAction = true },
	on_attach = on_attach,
	filetypes = { "python", "lua", "yaml" },
	settings = {
		rootMarkers = { ".git/" },
		languages = {
			python = {
				{ formatCommand = "black -", formatStdin = true },
				{ formatCommand = "isort --stdout --profile black -", formatStdin = true },
				{ lintCommand = "darglint --docstring-style sphinx -v 2 -z long -" },
			},
			lua = { formatCommand = "stylua -", formatStdin = true },
		},
	},
})
