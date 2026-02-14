vim.g.lazyvim_prettier_needs_config = true

vim.g.snacks_animate = false

vim.opt.spellcapcheck = ""

-- Enable list mode
vim.opt.list = true

-- Set listchars:
-- 'lead' handles leading spaces, 'trail' handles trailing spaces
-- 'tab' requires 2-3 characters (the character and the filler)
vim.opt.listchars = {
	space = " ", -- Keep regular spaces invisible
	lead = "·", -- Leading spaces as dots
	trail = "·", -- Trailing spaces as dots
	nbsp = "+", -- Non-breaking spaces
	tab = "> ", -- Tabs (e.g., a '>' followed by a space)
}

vim.opt.winborder = "rounded"

vim.o.number = true
vim.o.relativenumber = true
