local is_neovide = vim.g.neovide ~= nil

return {
	"catppuccin/nvim",
	opts = {
		float = {
			transparent = not is_neovide,
		},
		auto_integrations = true,
		term_colors = true,
		transparent_background = not is_neovide,
	},
}
