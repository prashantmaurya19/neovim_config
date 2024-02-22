local function keyargs(...)
	local keyarg = {}
	for _, value in ipairs(...) do
		keyarg[value] = true
	end
	return keyarg
end

local keyset = vim.keymap.set

keyset("n", "<leader>l", function()
	require("conform").format()
end, keyargs({ "noremap", "silent" }))

keyset("n", "<A-n>", ":tabnew<CR>", keyargs({ "noremap", "silent" }))
keyset("n", "<C-k>", ":tabnext<CR>", keyargs({ "noremap", "silent" }))
keyset("n", "<C-h>", ":tabprevious<CR>", keyargs({ "noremap", "silent" }))
keyset("n", "<C-x>", ":tabclose<CR>", keyargs({ "noremap", "silent" }))
keyset("n", "<C-d>", "<C-d>zz")
keyset("n", "<C-u>", "<C-u>zz")

keyset("n", "<A-h>", ":tabmove-1<CR>", keyargs({ "noremap", "silent" }))
keyset("n", "<A-k>", ":tabmove+1<CR>", keyargs({ "noremap", "silent" }))

--netrw
keyset("n", "<C-t>", ":Ex<CR>", keyargs({ "noremap", "silent" }))

--lsp-keybinding
keyset("n", "<S-k>", vim.lsp.buf.hover, {})
keyset("n", "<leader>a", vim.lsp.buf.code_action, {})
keyset("n", "<S-l>", function()
	vim.diagnostic.open_float(nil, { focus = false })
end, {})
keyset("n", "]d", function()
	vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end, keyargs({ "noremap", "silent" }))
keyset("n", "[d", function()
	vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, keyargs({ "noremap", "silent" }))
keyset({ "n", "i" }, "<C-p>", vim.lsp.buf.signature_help, {})

--telescope
local builtin = require("telescope.builtin")
local telescope_opt = function()
	return {
		previewer = false,
		cwd = require("lspconfig.util").root_pattern(".git")(vim.fn.expand("%:p")),
		layout_strategy = "horizontal",
	}
end
vim.keymap.set("n", "<leader>ff", function()
	builtin.find_files(telescope_opt())
end)
vim.keymap.set("n", "<leader>fg", function()
	builtin.live_grep(telescope_opt())
end)
vim.keymap.set("n", "<leader>fh", function()
	builtin.help_tags(telescope_opt())
end)
vim.keymap.set("n", "<leader>fs", function()
	builtin.lsp_document_symbols(telescope_opt())
end)
vim.keymap.set("n", "<leader>fd", function()
	builtin.lsp_definitions(telescope_opt())
end)
vim.keymap.set("n", "<leader>dd", function()
	builtin.diagnostics(telescope_opt())
end)
-- vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = "Find Word under Cursor"})
-- vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = "Search Git Commits"})
-- vim.keymap.set('n', '<leader>gb', builtin.git_bcommits, { desc = "Search Git Commits for Buffer"})
