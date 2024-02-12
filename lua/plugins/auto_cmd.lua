vim.api.nvim_create_autocmd("FileType", {
	desc = "set indent for dart files",
	callback = function(opts)
		local shiftwidth= {
			lisp = 4,
			dart = 2
		}
		local forward_slash_comment_filext = {
			dart = true,
			lisp = true,
		}
		local hash_comment_filext = {
			text = true,
		}
		if forward_slash_comment_filext[vim.bo[opts.buf].filetype] then
			vim.opt_local.commentstring = "//%s"
		elseif hash_comment_filext[vim.bo[opts.buf].filetype] then
			vim.opt_local.commentstring = "#%s"
		end
		if shiftwidth[vim.bo[opts.buf].filetype] ~= nil then
			vim.opt.shiftwidth = shiftwidth[vim.bo[opts.buf].filetype]
		end
	end,
})
