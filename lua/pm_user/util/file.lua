local M = {}


function M.is_current_buf_modified()
	return vim.bo[vim.api.nvim_get_current_buf()].modified
end

function M.truncate(content,max_content_width)
	if #content > max_content_width then
		return vim.fn.strcharpart(content, 0, max_content_width - 3) .. "..."
	else
		return content .. (" "):rep(max_content_width - #content)
	end
end

return M

