vim.opt.spellcapcheck = ""

vim.opt.list = true
vim.opt.listchars = {
	space = " ", -- Keep regular spaces invisible
	lead = "·", -- Leading spaces as dots
	trail = "·", -- Trailing spaces as dots
	nbsp = "+", -- Non-breaking spaces
	tab = "> ", -- Tabs (e.g., a '>' followed by a space)
}

vim.opt.winborder = "rounded"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.linespace = 7

vim.g.lazyvim_prettier_needs_config = true

if vim.g.neovide then
	vim.opt.winblend = 50
	vim.opt.pumblend = 50

	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0
	vim.g.neovide_highlight_matching_pair = true
	vim.g.neovide_input_macos_option_key_is_meta = "only_left"
	vim.g.neovide_normal_opacity = 0.9
	vim.g.neovide_opacity = 0.9
	vim.g.neovide_underline_stroke_scale = 2.0
	vim.g.neovide_window_blurred = true
end

vim.g.snacks_animate = false
