vim.wo.number = true
vim.opt.mouse = "a"
vim.opt.encoding = "UTF-8"
vim.opt.cursorline = true

vim.opt.termguicolors = true

--globals
vim.g.pm_lsp_servers_list = { "lua_ls","pyright", "rust_analyzer", "eslint"}


vim.diagnostic.config({
	virtual_text = false,
	underline = true,
	signs = true,
})

--nvim_tree config
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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
