return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
			nixd = { enabled = true },
			pyright = { enabled = false },
			standardrb = { enabled = true },
			tsgo = { enabled = true },
			ty = { enabled = true },
			vtsls = { enabled = false },
		},
	},
}
