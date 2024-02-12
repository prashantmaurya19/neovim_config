--toggleterm
require("toggleterm").setup({
	size = function(term)
		if term.direction == "horizontal" then
			return 15
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.4
		end
	end,
	open_mapping = [[<c-\>]],
	autochdir = true,
	direction = "float",
	close_on_exit = true,
	shell = vim.o.shell,
	auto_scroll = true,
	persist_mode = false,
	on_exit = function(t)
		vim.api.nvim_delete_buf(0, { force = false })
	end,
})

-- when you use ":wqa" then below error occur
-- E948: Job still running
-- E676: No matching autocommands for acwrite buffer
-- below line is to solve that
-- function vim.g.set_terminal_keymaps()
--   local opts = {buffer = 0}
--   -- vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
--   -- vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
--   -- vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
--   -- vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
--   -- vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
--   vim.keymap.set('t', '<C-l>', [[<Cmd>cls<CR>]], opts)
--   -- vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
-- end

-- -- if you only want these mappings for toggle term use term://*toggleterm#* instead
-- vim.cmd('autocmd! TermOpen term://* lua vim.g.set_terminal_keymaps()')
vim.cmd("command Z w | qa")
vim.cmd("cabbrev wqa Z")
