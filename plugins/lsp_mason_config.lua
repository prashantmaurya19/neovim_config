local lsp_config = require('lspconfig')
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = vim.g.pm_lsp_servers_list,
})

function load_servers(servers, config)
	for _, server_name in pairs(servers) do
		config[server_name].setup({})
	end
end

load_servers(vim.g.pm_lsp_servers_list, lsp_config)
--other then ensure_installed servers
--configure below
lsp_config["dartls"].setup({
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

vim.diagnostic.config({
	virtual_text = false,
	underline = true,
	signs = true,
})
