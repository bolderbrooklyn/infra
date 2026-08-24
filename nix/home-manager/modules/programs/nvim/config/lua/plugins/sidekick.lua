return {
	{
		"folke/sidekick.nvim",
		opts = function(_, opts)
			opts = opts or {}
			opts.cli = opts.cli or {}
			opts.cli.win = opts.cli.win or {}

			local prev_config = opts.cli.win.config
			opts.cli.win.config = function(terminal)
				if prev_config then
					prev_config(terminal)
				end

				local function follow_or_preserve()
					if not (terminal:buf_valid() and terminal:win_valid()) then
						return
					end
					local lines = vim.api.nvim_buf_line_count(terminal.buf)
					local height = vim.api.nvim_win_get_height(terminal.win)
					vim.api.nvim_win_call(terminal.win, function()
						local view = vim.fn.winsaveview()
						-- "at bottom" = bottom edge of view is at the buffer's last line.
						-- Only pin when the user hasn't scrolled up; otherwise preserve.
						if view.topline + height - 1 >= lines then
							vim.fn.winrestview({ topline = math.max(1, lines - height + 1) })
						end
					end)
				end

				vim.api.nvim_create_autocmd({ "WinEnter", "TextChanged" }, {
					group = terminal.group,
					callback = function(ev)
						if ev.event == "TextChanged" and ev.buf ~= terminal.buf then
							return
						end
						if not terminal:is_focused() then
							return
						end
						follow_or_preserve()
					end,
				})
			end

			return opts
		end,
	},
}