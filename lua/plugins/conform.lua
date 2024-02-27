return {
	{
		'stevearc/conform.nvim',
		opts = {},
		config=function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "isort" },
					rust = {"rustfmt"},
					html = {"prettier"},
					css = {"prettier"},
					javascript = {"prettier"},
				},
			})
		end
	}
}
