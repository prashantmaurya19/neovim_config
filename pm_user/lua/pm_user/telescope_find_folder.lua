local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local actions_state = require("telescope.actions.state")


local M = {}

M.find_folders = function(opts)
	opts = opts or {}
	pickers
		.new(opts, {
			finder = finders.new_table({
				results = vim.PM.file.scandir(vim.fn.getcwd())
			}),
			sorter = conf.generic_sorter(opts),
			attach_mappings = function(bufnr, _)
				actions.select_default:replace(function()
					actions.close(bufnr)
					local selection = actions_state.get_selected_entry()
					-- vim.print(selection)
					vim.cmd("tabnew")
					vim.cmd("Ex "..selection[1])
					-- vim.cmd('colorscheme '..selection[1])
				end)
				return true
			end,
		})
		:find()
end

return M
