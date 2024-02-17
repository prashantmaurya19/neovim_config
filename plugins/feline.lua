local line_ok, feline = pcall(require, "feline")
if not line_ok then
	return
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
		provider = {
			name = "vi_mode",
			opts = {
				show_mode_name = true,
				-- padding = "center", -- Uncomment for extra padding.
			},
		},
		hl = function()
			return {
				fg = require("feline.providers.vi_mode").get_mode_color(),
				bg = "black",
				style = "bold",
				name = "NeovimModeHLColor",
			}
		end,
		left_sep = "block",
		right_sep = function()
			return {
				str = "right_filled",
				hl = {
					fg = require("feline.providers.vi_mode").get_mode_color(),
				},
			}
		end,
	},
	gitBranch = {
		provider = "git_branch",
		hl = {
			bg = "orange_bright",
			fg = "black",
			style = "bold",
		},
		left_sep = "block",
		right_sep = "block",
	},
	separator = {
		provider = "",
		hl = {
			bg = "white",
			fg = "black",
			style = "bold",
		},
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
			bg = "red",
			fg = "dim",
		},
	},
	diagnostic_warnings = {
		provider = "diagnostic_warnings",
		hl = {
			bg = "yellow",
			fg = "dim",
		},
	},
	lsp_client_names = {
		provider = "lsp_client_names",
		hl = {
			fg = "dark_blue",
			bg = "dark_cyan",
			style = "bold",
		},
		left_sep = "left_filled",
		right_sep = "block",
	},
	file_type = {
		provider = {
			name = "file_type",
			opts = {
				filetype_icon = true,
				case = "titlecase",
			},
		},
		hl = {
			fg = "yellow",
			bg = "black",
			style = "bold",
		},
		left_sep = "block",
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
			fg = "orange_bright",
		},
	},
}

function extract_bg(component)
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

function create_color_maping(palate, direction)
	local new_colors = {}
	for i, v in pairs(palate) do
		table.insert(new_colors, i, {
			front = extract_bg(palate[i + direction]),
			back = extract_bg(v),
		})
	end
	return new_colors
end

function right2leftsepalign(component, color, sty)
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
function left2rightsepalign(component, color, sty)
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

function sepAlignHelper(aligner_fun, color, component, style)
	if type(component.hl) ~= "table" then
		return
	end
	local sty = "block"
	if style then
		sty = style
	end
	aligner_fun(component, color, sty)
end

local sepAlign = function(aligner, colors, row, style)
	local new_colors = colors
	for i, v in pairs(row) do
		sepAlignHelper(aligner, new_colors[i], v, style)
	end
end

local left = {
	c.vim_mode,
	c.gitBranch,
	c.gitDiffAdded,
	c.gitDiffRemoved,
	c.gitDiffChanged,
	c.fileinfo,
}
sepAlign(left2rightsepalign, create_color_maping(left, 1), left, "slant_right")

local middle = {
	-- c.diagnostic_errors,
	-- c.diagnostic_warnings,
	-- c.diagnostic_info,
	-- c.diagnostic_hints,
	c.lsp_process,
}

local right = {
	c.lsp_client_names,
	c.file_type,
	c.file_encoding,
	c.position,
	c.error_lnum,
	c.line_percentage,
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
		-- lsp_status = function()
		-- 	return table.getn(vim.lsp.buf_get_clients()) > 0 and require("lsp-status").status() or ""
		-- end,

		lsp_progress = function(components, opts)
			local lsp_message = require("mylsp").lsp_process()
			if table.getn(vim.lsp.buf_get_clients()) > 0 and lsp_message ~= "" then
				components.hl.fg = "white"
				return lsp_message
			end
			components.hl.fg = "green"
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
			if require("myfs").is_current_buf_modified() then
				filename = vim.fn.fnamemodify(filename, ":~:.") .. " ●"
			end
			return filename
		end,
	},
})
