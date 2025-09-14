return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
			nil_ls = {
				nix = {
					flake = {
						autoArchive = true,
					},
				},
			},
		},
	},
}
