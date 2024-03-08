return {
	{ priority = 20000, "https://github.com/folke/tokyonight.nvim" },
	{ priority = 20000, "kepano/flexoki-neovim" },
	{ priority = 20000, "Mofiqul/dracula.nvim" },
	{ priority = 20000, "pineapplegiant/spaceduck", branch = "main" },
	{ priority = 20000, "bluz71/vim-moonfly-colors", name = "moonfly" ,config=function ()
		vim.g.moonflyItalics = false
		vim.g.moonflyTransparent = true
		-- local theme = require("moonfly")
		-- theme.palette.emerald = "#24feaf"
		-- theme.palette.blue = "#4268ff"
		-- theme.palette.sky = "#4de7ff"
		-- theme.palette.turquoise = "#2bc5a8"
		-- theme.palette.purple = "#9539ff"
		-- theme.palette.violet = "#d96aff"
		-- vim.g.moonflyOverrideColor = theme.palette
	end},
	{
		priority = 20000,
		"zootedb0t/citruszest.nvim",
		config = function()
			require("citruszest").setup({
				option = {
					transparent = true, -- Enable/Disable transparency
					bold = true,
					italic = false,
				},
			})
		end,
	},
}
