return {
	"nvim-neotest/neotest",
	lazy = true,
	dependencies = {
		"volodya-lombrozo/neotest-ruby-minitest",
	},
	opts = {
		adapters = {
			"neotest-ruby-minitest",
		},
	},
}
