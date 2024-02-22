return {
	{
		"feline-nvim/feline.nvim",
		branch = "0.5-compat",
		config = function()
			local line_ok, feline = pcall(require, "feline")
			if not line_ok then
				vim.inspect("feline")
				return
			end
			feline.setup(require("pm_user.feline"))
		end,
	},
}
