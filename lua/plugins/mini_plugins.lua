return {
	"nvim-tree/nvim-web-devicons",
	"https://github.com/tpope/vim-commentary",
	"ryanoasis/vim-devicons",
	{
		"j-hui/fidget.nvim",
		config=function ()
			require("fidget").setup()
		end
	},
	{
		"folke/lsp-colors.nvim",
		config = function()
			require("lsp-colors").setup({
				Error = "#db4b4b",
				Warning = "#e0af68",
				Information = "#0db9d7",
				Hint = "#10B981",
			})
		end,
	},
	{
		"m4xshen/autoclose.nvim",
		config = function()
			require("autoclose").setup()
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"alvarosevilla95/luatab.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("luatab").setup({})
		end,
	},

	{
		"https://github.com/NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				user_default_options = {
					tailwind = true, -- Enable tailwind colors
					css_fn = true,
					names = false,
				},
			})
		end,
	},
}
