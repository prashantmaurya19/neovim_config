vim.wo.number = true
vim.opt.mouse = "a"
vim.opt.encoding = "UTF-8"
vim.opt.cursorline = true

vim.opt.termguicolors = true
--globals
vim.g.pm_inspect_table = {}
vim.g.pm_path_sep = package.config:sub(1, 1)
vim.g.pm_shiftwidth = {
	lisp = 4,
	dart = 2,
	css = 2,
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

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("command Z w | qa")
vim.cmd("cabbrev wqa Z")

--lsp_global_conf
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { focusable = false })
