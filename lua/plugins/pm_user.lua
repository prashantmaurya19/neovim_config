return {
	name="pm_user",
	dir=vim.fn.expand("~\\AppData\\Local\\nvim\\pm_user\\"),
	priority=10000,
	config=function()
		require("pm_user.user_init")
		require("pm_user.remaps")
		require("pm_user.colorscheme")
	end
}
