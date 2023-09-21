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
	-- git integration (execute git commands)
	"lambdalisue/gina.vim",
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
	"akinsho/toggleterm.nvim",
	-- Provides a pretty list for showing diagnostics, references, telescope results, quickfix
	-- and location lists to help you solve all the trouble your code is causing.
	-- use({ "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons" })
	-- "stevearc/aerial.nvim",
	"norcalli/nvim-colorizer.lua",
	{ "Bekaboo/deadcolumn.nvim" },
}
