require("luatab").setup({
	-- title = function() return '' end,
	modified = function()
		if require("myfs").is_current_buf_modified() then
			return " *"
		else
			return ""
		end
	end,
	-- windowCount = function() return '' end,
	-- devicon = function() return '' end,
	separator = function()
		return "|"
	end,
})
