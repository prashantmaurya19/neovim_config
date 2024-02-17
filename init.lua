local lazypath = vim.fn.stdpath("data").."\\lazy\\lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)
require("pm_user.user_init")
require("lazy").setup({{import = "plugins"}}, {change_detection = { enabled = false, notify = false, },})
require("pm_user.remaps")

