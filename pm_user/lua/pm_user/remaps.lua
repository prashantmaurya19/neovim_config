local builtin = require("telescope.builtin")
local telescope_opt = function()
	return {
		previewer = false,
		layout_strategies = "vertical",
		line_width = 0.25,
		path_display = function(_, path)
			local dirs = vim.PM.file.parse(path)
			dirs.directories = table.slice(dirs.directories, #dirs.directories - 3, #dirs.directories)
			table.insert(dirs.directories, dirs.filename)
			return vim.PM.text.join(vim.PM.g.path_sep, dirs.directories)
		end,
	}
end
local function keyargs(...)
	local keyarg = {}
	for k, value in ipairs(...) do
		if k ~= "desc" then
			keyarg[value] = true
		else
			keyarg[k] = value
		end
	end
	return keyarg
end

local keyset = vim.keymap.set
keyset("n", "<C-k>", ":tabnext<CR>", keyargs({ "noremap", "silent" }))
keyset("n", "<C-h>", ":tabprevious<CR>", keyargs({ "noremap", "silent" }))
keyset("n", "<C-x>", ":bd<CR>", keyargs({ "noremap", "silent" }))
keyset("n", "<C-d>", "<C-d>zz")
keyset("n", "<C-u>", "<C-u>zz")

keyset("x", "<leader>p", [["_dP]])
keyset("v", "J", ":m '>+1<CR>gv=gv")
keyset("v", "K", ":m '<-2<CR>gv=gv")

keyset("n", "<A-h>", ":tabmove-1<CR>", keyargs({ "noremap", "silent" }))
keyset("n", "<A-k>", ":tabmove+1<CR>", keyargs({ "noremap", "silent" }))

--netrw
keyset("n", "<leader>ex", ":Ex<CR>", keyargs({ "noremap", "silent" }))
keyset("n", "<leader>ntt",function ()
	vim.cmd( "tabnew")
	vim.cmd( "terminal")
end, keyargs({ "noremap", "silent" }))
keyset("n", "<leader>nff",function ()
	vim.cmd( "tabnew")
	builtin.find_files(telescope_opt())
end, keyargs({ "noremap", "silent" }))
keyset("n", "<leader>nfd",function ()
	vim.cmd("tabnew")
	require("pm_user.telescope_find_folder").find_folders(telescope_opt())
end, keyargs({ "noremap", "silent" }))
keyset("n", "<leader>nes", function()
	vim.cmd("tabnew")
	vim.cmd("Ex")
end, keyargs({ "noremap", "silent" }))

keyset("n", "<leader>nee", function()
	local filename = vim.api.nvim_buf_get_name(0)
	vim.cmd("tabnew")
	vim.cmd("Ex " .. filename:gsub(vim.PM.file.parse(filename).filename, ""))
end, keyargs({ "noremap", "silent" }))

keyset("n", "<leader>fo", function()
	require("conform").format({
		async = true,
	})
end, keyargs({ "noremap", "silent", desc = "conform format" }))

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
		keyset("n", "<leader>u", vim.lsp.buf.signature_help, opts)
	end,
})

--telescope
keyset("n", "<leader>ff", function()
	builtin.find_files(telescope_opt())
end, keyargs({ "noremap", "silent" }))

keyset("n", "<leader>fd", function()
	require("pm_user.telescope_find_folder").find_folders(telescope_opt())
end, keyargs({ "noremap", "silent" }))

keyset("n", "<leader>fg", function()
	builtin.live_grep(telescope_opt())
end, keyargs({ "noremap", "silent" }))

keyset("n", "<leader>fh", function()
	builtin.help_tags(telescope_opt())
end, keyargs({ "noremap", "silent" }))

keyset("n", "<leader>fs", function()
	builtin.lsp_document_symbols(telescope_opt())
end, keyargs({ "noremap", "silent" }))
keyset("n", "<leader>fb", function()
	builtin.buffers(telescope_opt())
end, keyargs({ "noremap", "silent" }))
keyset("n", "<leader>fr", function()
	builtin.lsp_references(telescope_opt())
end, keyargs({ "noremap", "silent" }))

keyset("n", "<leader>dd", function()
	builtin.diagnostics(telescope_opt())
end, keyargs({ "noremap", "silent" }))
