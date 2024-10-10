return function(custom_opts)
	return custom_opts.disable_feature.fzf_lua and {}
		or {
			"ibhagwan/fzf-lua",
			cmd = "FzfLua",
			opts = { winopts = { border = "none", fullscreen = true } },
		}
end
