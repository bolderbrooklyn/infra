return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
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
			nixd = {
				enabled = true,
			},
			tsgo = {
				enabled = true,
				filetypes = {
					"javascript",
					"javascript.jsx",
					"javascriptreact",
					"typescript",
					"typescript.tsx",
					"typescriptreact",
				},
			},
			vtsls = {
				enabled = false,
			},
		},
	},
}
