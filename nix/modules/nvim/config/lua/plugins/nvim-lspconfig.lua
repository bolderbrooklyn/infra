return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				marksman = {
					mason = false,
				},
				nil_ls = {
					mason = false,
					settings = {
						["nil"] = {
							nix = {
								flake = {
									autoArchive = true,
								},
							},
						},
					},
				},
				rubocop = {
					mason = false,
					cmd = { "bundle", "exec", "rubocop", "--lsp" },
				},
				ruby_lsp = {
					mason = false,
				},
			},
		},
	},
}
