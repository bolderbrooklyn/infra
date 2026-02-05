return {
	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			opts.servers = vim.tbl_deep_extend("force", opts.servers or {}, {
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
			})
		end,
	},
}
