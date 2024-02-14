-- vim_commantary
vim.cmd("autocmd FileType lisp setlocal commentstring=//\\ %s")
vim.cmd("autocmd FileType dart setlocal commentstring=//\\ %s")

--setting indent
vim.api.nvim_create_autocmd("FileType", {
	desc = "set indent for dart files",
	group = vim.api.nvim_create_augroup('black_on_save', { clear = true }),
	callback = function(opts)
		if vim.bo[opts.buf].filetype == "dart" then
			vim.cmd("set shiftwidth=2")
		end
	end,
})
