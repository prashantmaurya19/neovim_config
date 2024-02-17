local M = {}


function M.is_current_buf_modified()
	return vim.bo[vim.api.nvim_get_current_buf()].modified
end


return M

