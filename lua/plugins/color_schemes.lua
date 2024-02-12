return {
	"https://github.com/folke/tokyonight.nvim",
	"kepano/flexoki-neovim",
	"Mofiqul/dracula.nvim",
	{ "pineapplegiant/spaceduck", branch = "main" },
	{ "bluz71/vim-moonfly-colors", name = "moonfly" },
	{"zootedb0t/citruszest.nvim",priority=1000,config=function() vim.cmd("colorscheme citruszest")
	end},
	-- {"pm_user.colorscheme",priority=999}
}
