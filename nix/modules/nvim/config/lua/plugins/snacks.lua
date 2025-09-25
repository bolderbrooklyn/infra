local pickerOptions = {
	hidden = true,
}

return {
	{
		"folke/snacks.nvim",
		opts = {
			picker = {
				sources = {
					explorer = pickerOptions,
					files = pickerOptions,
				},
			},
		},
	},
}
