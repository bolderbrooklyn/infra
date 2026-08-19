local pickerOptions = {
	hidden = true,
	ignored = true,
	exclude = {
		"**/.bundle",
		"**/.claude",
		"**/.crush",
		"**/.direnv*",
		"**/.devenv*",
		"**/.git",
		"**/.omc",
		"**/.omo",
		"**/.opencode",
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
				explorer = vim.tbl_deep_extend("force", pickerOptions, {
					win = {
						input = {
							keys = {
								["<C-j>"] = false,
								["<C-k>"] = false,
							},
						},
						list = {
							keys = {
								["<C-j>"] = false,
								["<C-k>"] = false,
							},
						},
					},
				}),
				files = pickerOptions,
			},
		})
	end,
}
