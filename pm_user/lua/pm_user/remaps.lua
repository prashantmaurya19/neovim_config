local function keyargs(...)
	local keyarg = {}
	for _, value in ipairs(...) do
		keyarg[value] = true
	end
	return keyarg
end

local keyset = vim.keymap.set

keyset("n", "<leader>l", function()
	require("conform").format{
		async=true
	}
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
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
		local opts = { buffer = ev.buf }
		keyset("n", "<S-k>", vim.lsp.buf.hover, opts)
		keyset("n", "<leader>a", vim.lsp.buf.code_action, opts)
		keyset("n", "<S-l>", function()
			vim.diagnostic.open_float(nil, { focus = false })
		end, opts)
		keyset("n", "]d", function()
			vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
		end, opts)
		keyset("n", "[d", function()
			vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
		end, opts)
		keyset({ "n", "i" }, "<C-p>", vim.lsp.buf.signature_help, opts)
	end,
})

--telescope
local builtin = require("telescope.builtin")
local telescope_opt = function()
	return {
		previewer = false,
		cwd = require("lspconfig.util").root_pattern(".git")(vim.fn.expand("%:p")),
		layout_strategies = "vertical",
		line_width = 0.25,
		path_display = function(opts, path)
			local dirs = vim.PM.file.parse(path)
			dirs.directories = table.slice(dirs.directories, #dirs.directories - 3, #dirs.directories)
			table.insert(dirs.directories, dirs.filename)
			return vim.PM.text.join(vim.g.pm_path_sep, dirs.directories)
		end,
	}
end
keyset("n", "<leader>ff", function()
	builtin.find_files(telescope_opt())
end)
keyset("n", "<leader>fg", function()
	builtin.live_grep(telescope_opt())
end)
keyset("n", "<leader>fh", function()
	builtin.help_tags(telescope_opt())
end)
keyset("n", "<leader>fs", function()
	builtin.lsp_document_symbols(telescope_opt())
end)
keyset("n", "<leader>dd", function()
	builtin.diagnostics(telescope_opt())
end)
