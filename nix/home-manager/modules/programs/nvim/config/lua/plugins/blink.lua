return {
	"saghen/blink.cmp",
	opts = {
		completion = {
			ghost_text = {
				enabled = true,
			},
			list = {
				selection = {
					auto_insert = true,
					preselect = false,
				},
			},
		},
		keymap = {
			["<Tab>"] = { "select_next", "fallback" },
			["<S-Tab>"] = { "select_prev", "fallback" },
			["<C-Space"] = { "show_documentation", "hide_documentation", "fallback" },
		},
	},
}
