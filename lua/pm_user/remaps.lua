local keyset = vim.keymap.set

keyset({"n","i"},"<leader>l",function() require("conform").format() end,{noremap = true, silent = true,})
keyset('n',"<C-t>",":NvimTreeToggle<CR>",{noremap = true, silent = true,})

keyset('n',"<C-k>",":tabnext<CR>",{noremap = true, silent = true,})
keyset('n',"<C-h>",":tabprevious<CR>",{noremap = true, silent = true,})
keyset('n',"<C-x>",":tabclose<CR>",{noremap = true, silent = true,})
keyset('n',"<C-d>","<C-d>zz")
keyset('n',"<C-u>","<C-u>zz")

keyset('n',"<A-h>",":tabmove-1<CR>",{noremap = true, silent = true,})
keyset('n',"<A-k>",":tabmove+1<CR>",{noremap = true, silent = true,})


--lsp-keybinding
keyset("n", "<S-k>", vim.lsp.buf.hover, {})
keyset("n", "<leader>a", vim.lsp.buf.code_action, {})
keyset("n", "<S-l>", function()
	vim.diagnostic.open_float(nil, { focus = false })
end, {})
keyset({"n","i"}, "<C-p>",vim.lsp.buf.signature_help, {})

