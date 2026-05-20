return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
			nil_ls = { enabled = false },
			nixd = { enabled = true },
			pyright = { enabled = false },
			standardrb = { enabled = true },
			tsgo = { enabled = true },
			ty = { enabled = true },
			vtsls = { enabled = false },
		},
	},
}
