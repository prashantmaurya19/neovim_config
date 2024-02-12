function load_servers(servers, config)
	for _, server_name in pairs(servers) do
		config[server_name].setup({capabilities = require('cmp_nvim_lsp').default_capabilities()})
	end
end

return {
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
				ensure_installed = vim.g.pm_lsp_servers_list,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lsp_config = require("lspconfig")
			load_servers(vim.g.pm_lsp_servers_list, lsp_config)
			lsp_config["dartls"].setup({
				capabilities = require('cmp_nvim_lsp').default_capabilities(),
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
}
