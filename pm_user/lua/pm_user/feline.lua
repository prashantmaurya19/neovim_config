local line_ok, feline = pcall(require, "feline")
if not line_ok then
	vim.inspect("feline")
	return
end
local function extract_bg(component)
	if component == nil then
		return nil
	elseif type(component.hl) == "function" then
		return "black"
	elseif type(component.hl) == "table" then
		return component.hl.bg
	else
		return nil
	end
end

local function create_color_maping(palate, direction)
	local new_colors = {}
	for i, v in pairs(palate) do
		table.insert(new_colors, i, {
			front = extract_bg(palate[i + direction]),
			back = extract_bg(v),
		})
	end
	return new_colors
end

local function right2leftsepalign(component, color, sty)
	component.right_sep = "block"
	component.hl.bg = color.back
	component.left_sep = {
		str = sty,
		hl = {
			fg = color.back,
			bg = color.front,
		},
		always_visible = true,
	}
end
local function left2rightsepalign(component, color, sty)
	component.left_sep = "block"
	component.hl.bg = color.back
	component.right_sep = {
		str = sty,
		hl = {
			fg = color.back,
			bg = color.front,
		},
		always_visible = true,
	}
end

local function sepAlignHelper(aligner_fun, color, component, style)
	if type(component.hl) ~= "table" then
		return
	end
	local sty = "block"
	if style then
		sty = style
	end
	aligner_fun(component, color, sty)
end

local function sepAlign(aligner, colors, row, style)
	local new_colors = colors
	for i, v in pairs(row) do
		sepAlignHelper(aligner, new_colors[i], v, style)
	end
end

local punk_dark = {
	fg = "#BFBFBF",
	bg = "#020101",
	black = "#232323",
	red = "#FF5454",
	green = "#00CC7A",
	yellow = "#FFD700",
	orange = "#FF7431",
	blue = "#00BFFF",
	aqua = "#00FFFF",
	dark_blue = "#131A24",
	dark_cyan = "#010d0c",
	red_bright = "#FF1A75",
	green_bright = "#1AFFA3",
	yellow_bright = "#FFFF00",
	orange_bright = "#FFAA54",
	blue_bright = "#28C9FF",
	aqua_bright = "#33FFFF",
	black_bright = "#767C77",
}
local vi_mode_colors = {
	NORMAL = "green",
	OP = "green",
	INSERT = "yellow",
	VISUAL = "purple",
	LINES = "orange",
	BLOCK = "red_bright",
	REPLACE = "red",
	COMMAND = "aqua",
}

local c = {
	vim_mode = {
		provider = "vim_mode_provide",
		hl = function()
			return {
				bg = require("feline.providers.vi_mode").get_mode_color(),
				fg = "black",
				style = "bold",
				name = "NeovimModeHLColor",
			}
		end,
		right_sep = function()
			return {
				str = "right_filled",
				hl = {
					bg = "dark_blue",
					fg = require("feline.providers.vi_mode").get_mode_color(),
				},
			}
		end,
	},
	fileinfo = {
		provider = "get_filename",
		hl = {
			bg = "dark_blue",
			fg = "white",
			style = "bold",
		},
		left_sep = "block",
		right_sep = " ",
	},
	diagnostic_errors = {
		provider = "diagnostic_errors",
		hl = {
			fg = "red",
		},
	},
	diagnostic_warnings = {
		provider = "diagnostic_warnings",
		hl = {
			fg = "yellow",
		},
	},
	lsp_client_names = {
		provider = "lsp_client_names",
		hl = {
			fg = "cyan",
			bg = "dark_cyan",
			style = "bold",
		},
		left_sep = "left_filled",
		right_sep = "block",
	},
	error_lnum = {
		provider = "diagnostic_error_lnum",
		hl = {
			fg = "dark_cyan",
			bg = "red",
			style = "bold",
		},
		left_sep = "block",
		right_sep = "block",
	},
	lsp_process = {
		provider = "lsp_progress",
		hl = {
			fg = "red_bright",
		},
	},
}


local left = {
	c.vim_mode,
	c.fileinfo,
}
sepAlign(left2rightsepalign, create_color_maping(left, 1), left, "right_filled")

local middle = {
	c.lsp_process,
	c.diagnostic_errors,
	c.diagnostic_warnings,
}

local right = {
	c.lsp_client_names,
	c.error_lnum,
}
sepAlign(right2leftsepalign, create_color_maping(right, -1), right, "left_filled")

local components = {
	active = {
		left,
		middle,
		right,
	},
	inactive = {
		left,
		middle,
		right,
	},
}
feline.setup({
	components = components,
	theme = punk_dark,
	vi_mode_colors = vi_mode_colors,
	custom_providers = {

		lsp_progress = function(components, opts)
			local lsp_message = require("pm_user.util.lsp").lsp_process()
			if lsp_message ~= "" then
				return lsp_message
			end
			return "lsp ok!"
		end,

		diagnostic_error_lnum = function()
			for i, v in pairs(vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })) do
				return "E:" .. (v.end_lnum + 1)
			end
			return ""
		end,
		get_filename = function()
			local filename = vim.api.nvim_buf_get_name(0)
			if filename == "" then
				filename = "[no name]"
			else
				filename = vim.fn.fnamemodify(filename, ":~:.")
			end
			if require("pm_user.util.file").is_current_buf_modified() then
				filename = vim.fn.fnamemodify(filename, ":~:.") .. " ●"
			end
			return filename
		end,
		vim_mode_provide = function()
			-- return "  "
			return " "
		end,
	},
})
