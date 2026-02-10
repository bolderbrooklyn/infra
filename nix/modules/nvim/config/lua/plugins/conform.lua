local biome_supported = {
	"astro",
	"css",
	"graphql",
	"javascript",
	"javascriptreact",
	"json",
	"jsonc",
	"svelte",
	"typescript",
	"typescriptreact",
	"vue",
}

return {
	"stevearc/conform.nvim",
	optional = true,
	opts = function(_, opts)
		opts.formatters_by_ft = opts.formatters_by_ft or {}

		opts.formatters_by_ft.ruby = { "standardrb", "rubocop" }

		for _, ft in ipairs(biome_supported) do
			opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
			table.insert(opts.formatters_by_ft[ft], "biome")
			table.insert(opts.formatters_by_ft[ft], "biome-organize-imports")
		end

		opts.formatters = opts.formatters or {}

		opts.formatters.biome = {
			require_cwd = true,
		}

		opts.formatters.standardrb = {
			condition = function(_, ctx)
				return vim.fs.find({ ".standard.yml" }, { path = ctx.filename, upward = true })[1]
			end,
		}

		opts.formatters.rubocop = {
			condition = function(_, ctx)
				return vim.fs.find({ ".rubocop.yml" }, { path = ctx.filename, upward = true })[1]
			end,
		}
	end,
}
