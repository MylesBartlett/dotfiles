return {
	-- colorscheme
	{
		"sainnhe/everforest",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("everforest")
		end,
	},

	"nvim-tree/nvim-web-devicons",
	"justinmk/vim-dirvish",
	-- show content of registers
	"tversteeg/registers.nvim",
	-- comments
	"b3nj5m1n/kommentary",
	-- status line
	"itchyny/lightline.vim",
	{
		"mengelbrecht/lightline-bufferline",
		dependencies = "itchyny/lightline.vim",
	},
	-- useful bindings
	"tpope/vim-unimpaired",
	-- surround text objects
	"tpope/vim-surround",
	-- indenting
	-- "tpope/vim-sleuth",
	-- Vim sugar for the UNIX shell commands that need it the most
	"tpope/vim-eunuch",
	-- make more commands repeatable with .
	"tpope/vim-repeat",
	-- auto close parens
	"Raimondi/delimitMate",
	-- digram-based movement
	"ggandor/leap.nvim",
	-- enhanced f/t movement
	"ggandor/flit.nvim",
	"ggandor/leap-spooky.nvim",
	-- easy window resizing
	"simeji/winresizer",
	-- remember cursor position
	"ethanholz/nvim-lastplace",
	-- makes built-in LSP actions more use-friendly
	"RishabhRD/popfix",
	"RishabhRD/nvim-lsputils",
	-- Text objects
	"wellle/targets.vim",
	-- defines new text objects based on indentation levels
	"michaeljsmith/vim-indent-object",
	-- adds indentation guides to all lines (including empty lines).
	{
		"lukas-reineke/indent-blankline.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
	},
	-- better quickfix windows (including fzf-support and floating previews)
	"kevinhwang91/nvim-bqf",
	{
		"junegunn/fzf",
		build = function()
			vim.fn["fzf#install"]()
		end,
	},
	--  persist and toggle multiple terminals during an editing session
	{ "akinsho/toggleterm.nvim" },
	{
		"stevearc/aerial.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("telescope").load_extension("aerial")
			require("aerial").setup({
				-- Highlight the closest symbol if the cursor is not exactly on one.
				highlight_closest = true,
				-- Highlight the symbol in the source buffer when cursor is in the aerial win
				highlight_on_hover = true,
				show_guides = false,
				-- Automatically open aerial when entering supported buffers.
				-- This can be a function (see :help aerial-open-automatic)
				open_automatic = false,
				backends = { "treesitter", "lsp", "markdown", "man" },
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
					vim.keymap.set("n", "<leader>l", "<cmd>AerialToggle!<CR>")
					-- fzf integration
					vim.keymap.set(
						"n",
						"<C-f>",
						"<cmd>call aerial#fzf()<cr>",
						{ silent = true, remap = false }
					)
				end,
			})
		end,
	},
	"norcalli/nvim-colorizer.lua",
	{ "Bekaboo/deadcolumn.nvim" },
}
