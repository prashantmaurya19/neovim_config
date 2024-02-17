-- local commantary_group = vim.api.nvim_create_
vim.api.nvim_create_autocmd("FileType", {
	desc = "set indent for dart files",
	callback = function(opts)
		if vim.g.pm_forward_slash_comment_filext[vim.bo[opts.buf].filetype] then
			vim.opt_local.commentstring = "//%s"
		elseif vim.g.pm_hash_comment_filext[vim.bo[opts.buf].filetype] then
			vim.opt_local.commentstring = "#%s"
		end
		if vim.g.pm_shiftwidth[vim.bo[opts.buf].filetype] ~= nil then
			vim.opt.shiftwidth = vim.g.pm_shiftwidth[vim.bo[opts.buf].filetype]
		end
	end,
})

return {

}
