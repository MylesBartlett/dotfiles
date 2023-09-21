return {
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
						formatters.remove_trailing_whitespace,
						formatters.black,
						formatters.ruff,
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

		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			--[[ require("lspconfig").pylsp.setup({
				capabilities = capabilities,
				settings = {
					pylsp = {
						exclude = { "**/undodir", "**/~" },
						plugins = {
							pydocstyle = {
								enabled = true,
							},
							ruff = {
                                    enabled = true,
                                    extend = { "I" },
                                    format = { "I" },
                                },
                                rope_autoimport = {
                                    enabled = true,
                                },
                            },
                        },
                    },
                })  ]]
			lspconfig.pyright.setup({
				capabilities = capabilities,
				exclude = { ".undodir/*", "**/~" },
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
				capabilities = capabilities,
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

			-- local on_attach = function(client)
			-- 	if client.server_capabilities.document_formatting then
			-- 		vim.api.nvim_command([[augroup Format]])
			-- 		vim.api.nvim_command([[autocmd! * <buffer>]])
			-- 		vim.api.nvim_command([[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()]])
			-- 		vim.api.nvim_command([[augroup END]])
			-- 	end
			-- end

			-- lspconfig.efm.setup({
			-- 	init_options = { documentFormatting = true },
			-- 	on_attach = on_attach,
			-- 	filetypes = { "python", "yaml", "toml" },
			-- })
		end,
	},

	-- Treesitter - syntax-highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = "neovim/nvim-lspconfig",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "python", "lua", "toml", "yaml", "rust" },
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
	"romgrk/nvim-treesitter-context",
}
