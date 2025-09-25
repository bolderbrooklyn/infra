local pickerOptions = {
	hidden = true,
}

return {
	{
		"folke/snacks.nvim",
		opts = function(_, opts)
			opts.picker = {
				sources = {
					explorer = pickerOptions,
					files = pickerOptions,
				},
			}
		end,
	},
}
