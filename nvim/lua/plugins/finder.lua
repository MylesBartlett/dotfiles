return {
    {
        "nvim-telescope/telescope.nvim",
        version = "0.1.x",
        dependencies = "nvim-lua/plenary.nvim",
        keys = {
            { "<C-p>",     "<CMD>Telescope find_files<CR>", mode = { "n" } },
            -- requires ripgrep to be installed
            { "<leader>f", "<CMD>Telescope live_grep<CR>",  mode = { "n" } },
            { "<C-b>",     "<CMD>Telescope buffers<CR>",    mode = { "n" } },
            { "<leader>h", "<CMD>Telescope help_tags<CR>",  mode = { "n" } },
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
                    file_ignore_patterns = {
                        "%.a",
                        "%.bak",
                        "%.class",
                        "%.csv",
                        "%.egg",
                        "%.egg.info",
                        "%.mkv",
                        "%.mp3",
                        "%.mp4",
                        "%.o",
                        "%.out",
                        "%.parq",
                        "%.parquet",
                        "%.pdf",
                        "%.pyc",
                        "%.typed/",
                        "%.zip",
                        ".cache",
                        ".git/",
                        ".undodir/",
                        "__pycache__",
                    },
                },
            })
        end,
    },
}
