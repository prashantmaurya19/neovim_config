local keyset = vim.keymap.set
-- conform
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "isort", "black" },
		-- Use a sub-list to run only the first available formatter
		-- javascript = { { "prettierd", "prettier" } },
		javascript = { { "prettier" } },
		rust = { "rustfmt" },
	},
})

keyset({ "n", "v" }, "<leader>l", function()
	require("conform").format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 5000,
	})
end, { desc = "Format file or range (in visual mode)" })

