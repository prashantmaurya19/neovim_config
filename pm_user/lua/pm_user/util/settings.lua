
local M = {}

M.luatab = {
	TelescopePrompt="Telescope",
	git= "Git",
	fugitive="Fugitive",
	netrw="netrw",
	["checkhealth"] = "checkhealth"
}

M.path_sep = package.config:sub(1, 1)

M.shiftwidth = {
	lisp = 4,
	dart = 2,
	css = 2,
	javascript = 2,
	java=2
}
M.forward_slash_comment_filext = {
	dart = true,
	lisp = true,
}
M.hash_comment_filext = {
	text = true,
}

M.cmp_menu_icon = {
	-- nvim_lsp = "NLSP",
	nvim_lua = "NLUA",
	luasnip = "LSNP",
	buffer = "BUFF",
	path = "PATH",
}
return M

