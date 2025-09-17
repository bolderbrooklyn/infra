vim.g.snacks_animate = false

vim.lsp.config["nil_ls"] = {
	settings = {
		["nil"] = {
			nix = {
				flake = {
					autoArchive = true,
				},
			},
		},
	},
}
