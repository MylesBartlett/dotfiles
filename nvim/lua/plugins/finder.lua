return {
	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.x",
		dependencies = "nvim-lua/plenary.nvim",
		keys = {
			{ "<C-p>", "<CMD>Telescope find_files<CR>", mode = { "n", "i", "v" } },
			-- requires ripgrep to be installed
			{ "<C-f>", "<CMD>Telescope live_grep<CR>", mode = { "n", "i", "v" } },
			{ "<C-b>", "<CMD>Telescope buffers<CR>", mode = { "n", "i", "v" } },
			{ "<leader>h", "<CMD>Telescope help_tags<CR>", mode = { "n", "i", "v" } },
		},
		config = function()
			local actions = require("telescope.actions")
			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							["<C-k>"] = actions.toggle_selection + actions.move_selection_worse,
							["<C-j>"] = actions.toggle_selection + actions.move_selection_better,
						},
					},
				},
			})
		end,
	},
}
