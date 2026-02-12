local pickerOptions = {
	hidden = true,
	ignored = true,
	exclude = {
		"**/.bundle",
		"**/.crush",
		"**/.direnv*",
		"**/.devenv*",
		"**/.git",
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
	keys = {
		{ "<D-p>", LazyVim.pick(), desc = "Find Files (Root Dir)" },
		{
			"<D-S-p>",
			function()
				Snacks.picker.commands()
			end,
			desc = "Commands",
		},
	},
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
