return {
	"stevearc/overseer.nvim",
	opts = {
		component_aliases = {
			default = {
				"on_exit_set_status",
				"on_complete_notify",
				{ "on_complete_dispose", require_view = { "SUCCESS", "FAILURE" } },
				{ "open_output", on_start = "if_no_on_output_quickfix", direction = "dock", focus = false },
			},
			default_neotest = {
				"on_exit_set_status",
				"on_complete_notify",
				{ "on_complete_dispose", require_view = { "SUCCESS", "FAILURE" } },
			},
		},
		template_cache_threshold_ms = 200,
	},
	init = function()
		local overseer = require("overseer")
		vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
			callback = function()
				local cwd = vim.v.cwd or vim.fn.getcwd()
				overseer.preload_task_cache({ dir = cwd })
			end,
		})
	end,
}
