return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true , auto_update=true})()
		end,
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				ensure_installed = { "lua", "javascript", "python", "rust" },
				sync_install = true,
				auto_install=true,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
}
