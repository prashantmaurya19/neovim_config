local function my_on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	local keyset = vim.keymap.set
	keyset("n", "<C-t>", api.tree.toggle, opts("toggle"))
	keyset("n", "t", api.node.open.tab, opts("new tab"))
	keyset("n", "r", api.fs.rename_full, opts("rename full path"))
	keyset("n", "u", api.fs.rename, opts("rename file"))
	keyset("n", "?", api.tree.toggle_help, opts("Help"))
	keyset('n',"<C-k>",":tabnext<CR>",{noremap = true, silent = true,buffer=bufnr})
	keyset('n',"<C-h>",":tabprevious<CR>",{noremap = true, silent = true,buffer=bufnr})
	keyset('n',"<C-x>",":tabclose<CR>",{noremap = true, silent = true,buffer=bufnr})
	keyset('n',"<C-d>","<C-d>zz",{buffer=bufnr})
	keyset('n',"<C-u>","<C-u>zz",{buffer=bufnr})

	keyset('n',"<A-h>",":tabmove-1<CR>",{noremap = true, silent = true,buffer=bufnr})
	keyset('n',"<A-k>",":tabmove+1<CR>",{noremap = true, silent = true,buffer=bufnr})
end

return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			diagnostics = {
				enable = false,
				icons = { hint = "", info = "", warning = "", error = "" },
			},
			filters = { dotfiles = false },
			disable_netrw = true,
			hijack_netrw = true,
			on_attach = my_on_attach,
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
	end,
}
