return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = { "RRethy/nvim-treesitter-endwise" },
		opts = function(_, opts)
			opts = vim.tbl_deep_extend("force", opts or {}, {
				endwise = { enable = true },
				indent = { enable = true },
			})
		end,
	},
}
