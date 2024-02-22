vim.wo.number = true
vim.opt.mouse = "a"
vim.opt.encoding = "UTF-8"
vim.opt.cursorline = true

vim.opt.termguicolors = true
--globals
vim.g.pm_lsp_servers_list = { "lua_ls","pylyzer", "rust_analyzer", "eslint"}
vim.g.pm_shiftwidth= {
	lisp = 4,
	dart = 2
}
vim.g.pm_forward_slash_comment_filext = {
	dart = true,
	lisp = true,
}
vim.g.pm_hash_comment_filext = {
	text = true,
}

vim.g.pm_cmp_menu_icon = {
	-- nvim_lsp = "NLSP",
	nvim_lua = "NLUA",
	luasnip = "LSNP",
	buffer = "BUFF",
	path = "PATH",
}

vim.diagnostic.config({
	virtual_text = false,
	underline = true,
	signs = true,
})

--nvim_tree config
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
-- vim.g.netrw_keepdir = 0

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

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("command Z w | qa")
vim.cmd("cabbrev wqa Z")


--lsp_global_conf
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { focusable = false }
)
