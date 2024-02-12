
return {
	"neovim/nvim-lspconfig",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			vim.opt.pumblend = 0
			cmp.setup({
				formatting = {
					ields = { "abbr", "menu", "kind" },
					format = function(entry, item)
						-- Define menu shorthand for different completion sources.
						local menu_icon = {
							-- nvim_lsp = "NLSP",
							nvim_lua = "NLUA",
							luasnip = "LSNP",
							buffer = "BUFF",
							path = "PATH",
						}
						-- Set the menu "icon" to the shorthand for each completion source.

						-- Set the fixed width of the completion menu to 60 characters.
						local fixed_width = 30

						-- Set 'fixed_width' to false if not provided.
						fixed_width = fixed_width or false

						-- Get the completion entry text shown in the completion window.
						local content = item.abbr

						-- Set the fixed completion window width.
						if fixed_width then
							vim.o.pumwidth = fixed_width
						end

						-- Get the width of the current window.
						local win_width = vim.api.nvim_win_get_width(0)

						-- Set the max content width based on either: 'fixed_width'
						-- or a percentage of the window width, in this case 20%.
						-- We subtract 10 from 'fixed_width' to leave room for 'kind' fields.
						local max_content_width = fixed_width and fixed_width - 10 or math.floor(win_width * 0.2)

						-- Truncate the completion entry text if it's longer than the
						-- max content width. We subtract 3 from the max content width
						-- to account for the "..." that will be appended to it.
						item.abbr = require("pm_user.util.file").truncate(content,max_content_width)
						if item.menu~= nil then
							item.menu = require("pm_user.util.file").truncate(item.menu,max_content_width)
						end
						return item
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				window = {
					-- completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" }, -- For luasnip users.
				}, {
					{ name = "buffer" },
				}),
			})

			-- Set configuration for specific filetype.
			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
				}, {
					{ name = "buffer" },
				}),
			})

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})

			-- Set up lspconfig.
			-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
			-- function load_servers(servers)
			-- 	for _, server_name in pairs(servers) do
			-- 		require("lspconfig")[server_name].setup({
			-- 			capabilities = capabilities,
			-- 		})
			-- 	end
			-- end

			-- load_servers(vim.g.pm_lsp_servers_list)
		end,
	},
}
