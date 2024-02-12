function scandir(directory)
	local i, t, popen = 0, {}, io.popen
	local pfile = popen('dir /b "' .. directory .. '"')
	for filename in pfile:lines() do
		i = i + 1
		t[i] = filename
	end
	pfile:close()
	return t
end

function load_setup_files(path)
	local files = scandir(path)
	for k,filename in pairs(files) do
		vim.cmd("runtime! plugins\\"..filename)
	end
end

--some config
vim.wo.number = true
vim.opt.mouse = "a"
vim.opt.encoding = "UTF-8"
vim.opt.cursorline = true

vim.opt.termguicolors = true

--globals
vim.g.pm_lsp_servers_list = { "lua_ls", "rust_analyzer", "eslint"}

-- vim.opt.runtimepath:append("C:\\Users\\prash\\AppData\\Local\\nvim\\plugins")
load_setup_files("C:\\Users\\prash\\AppData\\Local\\nvim\\plugins")
