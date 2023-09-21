---------------------------
--      leader key       --
---------------------------
vim.keymap.set("n", "<SPACE>", "<Nop>")
vim.g.mapleader = " "

---------------------------
--       completion      --
---------------------------
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }

----------------------------
-- Lazy (package manager) --
----------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
-- Initialize plugins (specs are stored in the nvim/lua/plugins/ dir)
require("lazy").setup("plugins")

---------------------------
--      keymappings      --
---------------------------
vim.keymap.set("n", "<leader>w", "<cmd>cclose<cr>")
vim.keymap.set("n", "<C-q>", "<C-w>q")
vim.keymap.set("n", "<leader>q", "<cmd>qa<cr>")

vim.keymap.set("n", "<leader>;", "q:")
vim.keymap.set("n", "<leader><space>", "<cmd>nohlsearch<cr>")
vim.keymap.set("n", "<leader>s", "<cmd>update<cr>")
vim.keymap.set("n", "<leader><leader>", "zz")
vim.keymap.set("n", "<leader>:", "q:")
vim.keymap.set("v", "<leader>:", "q:")

-- Make < > shifts keep selection
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- copy/paste shortcuts

vim.keymap.set("n", "Y", "y$")
vim.keymap.set("n", "cy", '"+y', { remap = true })
vim.keymap.set("n", "cp", '"+p', { remap = true, silent = true })
vim.keymap.set("n", "cP", '"+P', { silent = true })
vim.keymap.set("n", "c*", '/\\<<C-R>=expand("<cword>")<CR>\\>\\C<CR>``cgn', noremap)
vim.keymap.set("n", "c#", '?\\<<C-R>=expand("<cword>")<CR>\\>\\C<CR>``cgn', noremap)

-- global selection
vim.keymap.set("x", "ie", "gg0gG$", { silent = true })
vim.keymap.set("o", "ie", 'cmd<C-U>execute "normal! m`"<Bar>keepjumps normal! ggVG<CR> ', { silent = true })

-- window movement
-- In normal mode
vim.keymap.set("n", "<C-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set("n", "<C-j>", "<C-\\><C-n><C-w>j")
vim.keymap.set("n", "<C-k>", "<C-\\><C-n><C-w>k")
vim.keymap.set("n", "<C-l>", "<C-\\><C-n><C-w>l")
-- In terminal mode
vim.keymap.set("t", "<C-w>", "<C-\\><C-n>")

-- leap
require("leap").add_default_mappings()
require("leap-spooky").setup({})
-- flit
require("flit").setup({
	keys = { f = "f", F = "F", t = "t", T = "T" },
	-- A string like "nv", "nvo", "o", etc.
	labeled_modes = "nv",
	multiline = true,
})

-- buffer change
vim.keymap.set("n", "<leader>1", "<Plug>lightline#bufferline#go(1)")
vim.keymap.set("n", "<leader>2", "<Plug>lightline#bufferline#go(2)")
vim.keymap.set("n", "<leader>3", "<Plug>lightline#bufferline#go(3)")
vim.keymap.set("n", "<leader>4", "<Plug>lightline#bufferline#go(4)")
vim.keymap.set("n", "<leader>5", "<Plug>lightline#bufferline#go(5)")
vim.keymap.set("n", "<leader>6", "<Plug>lightline#bufferline#go(6)")
vim.keymap.set("n", "<leader>7", "<Plug>lightline#bufferline#go(7)")
vim.keymap.set("n", "<leader>8", "<Plug>lightline#bufferline#go(8)")
vim.keymap.set("n", "<leader>9", "<Plug>lightline#bufferline#go(9)")
vim.keymap.set("n", "<leader>0", "<Plug>lightline#bufferline#go(10)")
vim.keymap.set("n", "<leader>=", "<cmd>bnext<cr>")
vim.keymap.set("n", "<leader>-", "<cmd>bprevious<cr>")
-- buffer deletion
vim.keymap.set("n", "<leader>c1", "<Plug>lightline#bufferline#delete(1)")
vim.keymap.set("n", "<leader>c2", "<Plug>lightline#bufferline#delete(2)")
vim.keymap.set("n", "<leader>c3", "<Plug>lightline#bufferline#delete(3)")
vim.keymap.set("n", "<leader>c4", "<Plug>lightline#bufferline#delete(4)")
vim.keymap.set("n", "<leader>c5", "<Plug>lightline#bufferline#delete(5)")
vim.keymap.set("n", "<leader>c6", "<Plug>lightline#bufferline#delete(6)")
vim.keymap.set("n", "<leader>c7", "<Plug>lightline#bufferline#delete(7)")
vim.keymap.set("n", "<leader>c8", "<Plug>lightline#bufferline#delete(8)")
vim.keymap.set("n", "<leader>c9", "<Plug>lightline#bufferline#delete(9)")
vim.keymap.set("n", "<leader>c10", "<Plug>lightline#bufferline#delete(10)")
-- Gina
vim.keymap.set("n", "<leader>gs", "<cmd>Gina status<cr>")
vim.keymap.set("n", "<leader>gc", "<cmd>Gina commit<cr>")
vim.keymap.set("n", "<leader>gp", "<cmd>Gina push<cr>")

---------------------------
--    global settings    --
---------------------------
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.g.tex_flavor = "latex"
vim.opt.syntax = "enable"
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "100"
vim.opt.cmdheight = 2
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.inccommand = "nosplit"
vim.opt.exrc = true
vim.opt.secure = true
vim.opt.termguicolors = true

-- undo setttings
vim.opt.history = 1000
vim.opt.undolevels = 10000
vim.opt.undoreload = 100000
-- maintain undo history between session
vim.opt.undofile = true
vim.opt.undodir = "./.undodir"

-- Highlight on yank
vim.cmd([[au TextYankPost * lua vim.highlight.on_yank {on_visual = false}]])

---------------------------
--      status line      --
---------------------------
vim.opt.showmode = false
vim.g.lightline = {
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
vim.g.lightline.component = { lineinfo = "%3l/%L  col %-2v", percent = "" }
vim.opt.showtabline = 2
vim.g["lightline#bufferline#show_number"] = 2

---------------------------
--    various plugins    --
---------------------------
-- indent_blankline
require("indent_blankline").setup({
	show_end_of_line = true,
	space_char_blankline = " ",
	-- show_current_context = true,
	use_treesitter = true,
	-- show_current_context_start = true,
})

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

---------------------------
--     colorscheme       --
---------------------------
vim.o.background = "dark"
vim.opt.termguicolors = true

---------------------------
--         LSP           --
---------------------------
-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		--[[ vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts) ]]
		vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.api.nvim_command([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]])
		vim.keymap.set("n", "\\f", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
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
