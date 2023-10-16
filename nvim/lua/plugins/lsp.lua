return {

    {
        "mfussenegger/nvim-lint",
        config = function()
            require("lint").linters_by_ft = {
                markdown = { "vale" },
                python = {}, -- { "ruff", "pydocstyle" },
            }
            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function()
                    require("lint").try_lint()
                end,
            })
        end,
    },
    { "simrat39/rust-tools.nvim" },
    {
        "elentok/format-on-save.nvim",
        config = function()
            local format_on_save = require("format-on-save")
            local formatters = require("format-on-save.formatters")
            format_on_save.setup({
                run_with_sh = false,
                experiments = {
                    partial_update = "diff", -- or 'line-by-line'
                },
                formatter_by_ft = {
                    python = {
                        -- formatters.remove_trailing_whitespace,
                        -- formatters.lsp,
                        formatters.ruff,
                        formatters.black,
                    },
                    lua = formatters.stylua,
                    yaml = formatters.lsp,
                    toml = formatters.lsp,
                    rust = formatters.lsp,
                },
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({})
        end,
        lazy = false,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "simrat39/rust-tools.nvim",
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local mason_lsp = require("mason-lspconfig")
            mason_lsp.setup({
                ensure_installed = {
                    "denols",
                    "lua_ls",
                    "pyright",
                    "ruff_lsp",
                    "rust_analyzer",
                    "taplo",
                    "typst_lsp",
                    "yamlls",
                },
                automatic_installation = true,
            })
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            -- Disable dynamic registration due to known neovim issue:
            -- https://github.com/neovim/neovim/issues/23291
            capabilities.workspace = {
                didChangeWatchedFiles = {
                    dynamicRegistration = false,
                },
            }
            mason_lsp.setup_handlers({
                --
                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup({
                        settings = {},
                    })
                end,
                ["yamlls"] = function()
                    lspconfig.yamlls.setup({
                        settings = {},
                    })
                end,
                --
                ["pyright"] = function()
                    lspconfig.pyright.setup({
                        capabilities = capabilities,
                        exclude = { ".undodir/", "**/~", "__pycache__/" },
                        settings = {
                            python = {
                                analysis = {
                                    autoImportCompletions = true,
                                    autoSearchPaths = true,
                                    -- diagnosticMode = "workspace",
                                    typeCheckingMode = "basic",
                                    useLibraryCodeForTypes = true,
                                },
                            },
                        },
                    })
                end,
                --
                ["rust_analyzer"] = function()
                    require("rust-tools").setup({})
                    lspconfig.rust_analyzer.setup({
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
                    })
                end,
                ["taplo"] = function()
                    lspconfig.taplo.setup({})
                end,
                ["denols"] = function()
                    lspconfig.denols.setup({})
                end,
                --
                ["typst_lsp"] = function()
                    lspconfig.typst_lsp.setup({
                        settings = {
                            exportPdf = "onType",
                        },
                    })
                end,
            })
        end,
        --
        lazy = false,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {},
    },

    -- Treesitter - syntax-highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = "neovim/nvim-lspconfig",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "python", "lua", "toml", "yaml", "rust", "bash" },
                sync_install = true,
                highlight = { enable = true },
            })
            -- require("nvim-treesitter.install").compilers = { "clang" }
            require("nvim-treesitter.install").prefer_git = false
        end,
    },
    -- objects for moving
    "nvim-treesitter/nvim-treesitter-textobjects",
    --  shows the context of the currently visible buffer content
    { "romgrk/nvim-treesitter-context" },
    { "kaarmu/typst.vim",              ft = "typst", lazy = false },
}
