return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig["dartls"].setup({
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				dart = {
					analysisExcludedFolders = {
						vim.fn.expand("$HOME/AppData/Local/Pub/Cache"),
						vim.fn.expand("$HOME/.pub-cache"),
						vim.fn.expand("/opt/homebrew/"),
						vim.fn.expand("$HOME/flutter_home/flutter/"),
					},
					updateImportsOnRename = true,
					completeFunctionCalls = true,
					showTodos = true,
				},
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {"cssls", "tailwindcss", "lua_ls", "pylyzer",  "rust_analyzer", "tsserver" },
				handlers = {
					function(server_name) -- default handler (optional)
						require("lspconfig")[server_name].setup({
							capabilities = require("cmp_nvim_lsp").default_capabilities(),
						})
					end,
					["lua_ls"] = function()
						require("lspconfig").lua_ls.setup({
							capabilities = require("cmp_nvim_lsp").default_capabilities(),
							settings = {
								Lua = {
									diagnostics = {
										globals = { "vim" },
									},
								},
							},
						})
					end,
				},
			})
		end,
	},
}
