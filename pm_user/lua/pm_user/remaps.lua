local function keyargs(...)
	local keyarg = {}
	for _,value in ipairs(...) do
		keyarg[value] = true
	end
	return keyarg
end

local keyset = vim.keymap.set

keyset("n","<leader>l",function() require("conform").format() end,keyargs{"noremap","silent"})
keyset('n',"<C-t>",":NvimTreeToggle<CR>",keyargs{"noremap","silent"})

keyset("n","<A-n>",":tabnew<CR>",keyargs{"noremap","silent"})
keyset('n',"<C-k>",":tabnext<CR>",keyargs{"noremap","silent"})
keyset('n',"<C-h>",":tabprevious<CR>",keyargs{"noremap","silent"})
keyset('n',"<C-x>",":tabclose<CR>",keyargs{"noremap","silent"})
keyset('n',"<C-d>","<C-d>zz")
keyset('n',"<C-u>","<C-u>zz")

keyset('n',"<A-h>",":tabmove-1<CR>",keyargs{"noremap","silent"})
keyset('n',"<A-k>",":tabmove+1<CR>",keyargs{"noremap","silent"})


--lsp-keybinding
keyset("n", "<S-k>", vim.lsp.buf.hover, {})
keyset("n", "<leader>a", vim.lsp.buf.code_action, {})
keyset("n", "<S-l>", function()
	vim.diagnostic.open_float(nil, { focus = false })
end, {})
keyset({"n","i"}, "<C-p>",vim.lsp.buf.signature_help, {})

