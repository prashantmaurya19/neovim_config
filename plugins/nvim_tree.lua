local function my_on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	vim.keymap.set("n", "<C-t>", api.tree.toggle, opts("toggle"))
	vim.keymap.set("n", "t", api.node.open.tab, opts("new tab"))
	vim.keymap.set("n", "r", api.fs.rename_full, opts("rename full path"))
	vim.keymap.set("n", "u", api.fs.rename, opts("rename file"))
	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- OR setup with some options
local g = vim.g
vim.o.termguicolors = true

require("nvim-tree").setup({
	diagnostics = {
		enable = false,
		icons = { hint = "", info = "", warning = "", error = "" },
	},
	filters = { dotfiles = false },
	disable_netrw = true,
	hijack_netrw = true,
	on_attach = my_on_attach,
	-- auto_close = true,
	open_on_tab = false,
	hijack_cursor = true,
	update_cwd = true,
	update_focused_file = { enable = true, update_cwd = false },
	view = {
		-- allow_resize = true,
		side = "left",
		width = 25,
	},
	renderer = {
		indent_markers = { enable = true },
		root_folder_modifier = table.concat({ ":t:gs?$?/..", string.rep(" ", 1003), "?:gs?^??" }),
		highlight_git = true,
		highlight_opened_files = "none",
		add_trailing = false,
		icons = {
			webdev_colors = true,
			git_placement = "before",
			padding = " ",
			symlink_arrow = " ➛ ",
			show = { file = true, folder = true, folder_arrow = true, git = true },
			glyphs = {
				default = "",
				symlink = "",
				folder = {
					arrow_closed = "",
					arrow_open = "",
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
				git = {
					unstaged = "✗",
					staged = "✓",
					unmerged = "",
					renamed = "➜",
					untracked = "★",
					deleted = "",
					ignored = "◌",
				},
			},
		},
	},

	git = { enable = true, ignore = true, timeout = 500 },
})
vim.g.nvim_tree_icons = {
	default = "",
	symlink = "",
	git = {
		deleted = "",
		ignored = "◌",
		renamed = "➜",
		staged = "✓",
		unmerged = "",
		unstaged = "✗",
		untracked = "★",
	},
	folder = {
		-- disable indent_markers option to get arrows working or if you want both arrows and indent then just add the arrow icons in front            ofthe default and opened folders below!
		-- arrow_open = "",
		-- arrow_closed = "",
		default = "",
		empty = "", -- 
		empty_open = "",
		open = "",
		symlink = "",
		symlink_open = "",
	},
}

