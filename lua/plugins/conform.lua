return {
	{
		'stevearc/conform.nvim',
		opts = {},
		config=function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "black" },
					rust = {"rustfmt"},
					html = {"prettier"},
					css = {"prettier"},
					javascript = {"prettier"},
					xml = {"xmlformatter"},
					java={"google-java-format"}
				},
			})
		end
	}
}
