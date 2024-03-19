return {
	"nvim-tree/nvim-web-devicons",
	"https://github.com/tpope/vim-commentary",
	"ryanoasis/vim-devicons",
	{
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup()
		end,
	},
	{
		"folke/lsp-colors.nvim",
		config = function()
			require("lsp-colors").setup({
				Error = "#db4b4b",
				Warning = "#e0af68",
				Information = "#0db9d7",
				Hint = "#10B981",
			})
		end,
	},
	{
		"m4xshen/autoclose.nvim",
		config = function()
			require("autoclose").setup()
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"alvarosevilla95/luatab.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("luatab").setup({
				title = function(bufnr)
					local file = vim.fn.bufname(bufnr)
					local filetype = vim.fn.getbufvar(bufnr, "&filetype")
					local buftype = vim.fn.getbufvar(bufnr, "&buftype")

					if buftype == "help" then
						return "help:" .. vim.fn.fnamemodify(file, ":t:r")
					elseif buftype == "quickfix" then
						return "quickfix"
					elseif vim.PM.g.luatab[filetype] ~= nil then
						return vim.PM.g.luatab[filetype]
					elseif file:sub(file:len() - 2, file:len()) == "FZF" then
						return "FZF"
					elseif buftype == "terminal" then
						local _, mtch = string.match(file, "term:(.*):(%a+)")
						return mtch ~= nil and mtch or vim.fn.fnamemodify(vim.env.SHELL, ":t")
					elseif file == "" then
						return "[No Name]"
					else
						return vim.fn.pathshorten(vim.fn.fnamemodify(file, ":p:~:t"))
					end
				end,
				devicon = function(bufnr, isSelected)
					local icon, devhl
					local file = vim.fn.bufname(bufnr)
					local buftype = vim.fn.getbufvar(bufnr, "&buftype")
					local filetype = vim.fn.getbufvar(bufnr, "&filetype")
					local devicons = require("nvim-web-devicons")
					if filetype == "TelescopePrompt" then
						icon, devhl = devicons.get_icon("telescope")
					elseif filetype == "fugitive" then
						icon, devhl = devicons.get_icon("git")
					elseif filetype == "vimwiki" then
						icon, devhl = devicons.get_icon("markdown")
					elseif filetype == "netrw" then
						icon, devhl = devicons.get_icon("markdown")
						icon = "󰙅"
					elseif buftype == "terminal" then
						icon, devhl = devicons.get_icon("zsh")
					else
						icon, devhl = devicons.get_icon(file, vim.fn.expand("#" .. bufnr .. ":e"))
					end
					if icon then
						local h = require("luatab.highlight")
						local fg = h.extract_highlight_colors(devhl, "fg")
						local bg = h.extract_highlight_colors("TabLineSel", "bg")
						local hl = h.create_component_highlight_group({ bg = bg, fg = fg }, devhl)
						local selectedHlStart = (isSelected and hl) and "%#" .. hl .. "#" or ""
						local selectedHlEnd = isSelected and "%#TabLineSel#" or ""
						return selectedHlStart .. icon .. selectedHlEnd .. " "
					end
					return ""
				end,
			})
		end,
	},

	{
		"https://github.com/NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				user_default_options = {
					tailwind = true, -- Enable tailwind colors
					css_fn = true,
					names = false,
				},
			})
		end,
	},
	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
}
