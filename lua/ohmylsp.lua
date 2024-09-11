local M = {}

function M.setup(opts)
	opts = opts or {}
  opts.disable_feature = opts.disable_feature or {}
	opts.misc = opts.misc or {}
	opts.keys = opts.keys or {}
	opts.keys.typescript = opts.keys.typescript or {}
	opts.misc = opts.misc or {}
	opts.keys.cmp = opts.keys.cmp or {}
	opts.keys.lsp = opts.keys.lsp or {}
	opts.icons = opts.icons or {}

	local specs = {
		require("base.lsp")(opts),
		require("base.cmp")(opts),
		require("base.treesitter")(opts),
		require("base.formatting")(opts),
	}

	for _, lang in ipairs(opts) do
		local hello = require("lang." .. lang)(opts)
		table.insert(specs, hello)
	end

	return specs
end

return M
