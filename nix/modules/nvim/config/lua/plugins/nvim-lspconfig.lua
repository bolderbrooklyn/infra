return {
	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			opts.servers = {
				marksman = { mason = false },
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
			}
		end,
	},
}
