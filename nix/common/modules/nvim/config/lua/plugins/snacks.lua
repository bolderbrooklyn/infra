local pickerOptions = {
	hidden = true,
	ignored = true,
	exclude = {
		"**/.bundle",
		"**/.direnv*",
		"**/.devenv*",
		"**/.git",
		"**/.ruby-lsp",
		"**/.yarn",
		"**/__pycache__",
		"**/*.pyc",
		"**/node_modules",
	},
}

return {
	"folke/snacks.nvim",
	opts = function(_, opts)
		opts.indent = { enabled = false }

		opts.picker = vim.tbl_deep_extend("force", opts.picker or {}, {
			sources = {
				explorer = pickerOptions,
				files = pickerOptions,
			},
		})
	end,
}
