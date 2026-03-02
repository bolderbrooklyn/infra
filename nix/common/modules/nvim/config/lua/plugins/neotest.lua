return {
	"nvim-neotest/neotest",
	lazy = true,
	dependencies = {
		"zidhuss/neotest-minitest",
		"adrigzr/neotest-mocha",
	},
	opts = {
		adapters = {
			"neotest-minitest",
			"neotest-mocha",
			["neotest-rspec"] = false,
		},
	},
}
