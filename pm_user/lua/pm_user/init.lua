return {
	setup = function()
		require("pm_user.util")
		require("pm_user.user_init")
		require("pm_user.remaps")
		require("pm_user.colorscheme")
		require("pm_user.auto_cmd")
		vim.PM = {}
		vim.PM.text = require("pm_user.util.texts")
		vim.PM.file = require("pm_user.util.file")
		vim.PM.lsp = require("pm_user.util.lsp")
	end,
}
