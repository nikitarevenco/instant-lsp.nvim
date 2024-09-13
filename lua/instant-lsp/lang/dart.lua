return function(custom_opts)
	return {
		{
			"nvim-treesitter/nvim-treesitter",
			opts = { ensure_installed = { "dart" } },
		},
		{
			"akinsho/flutter-tools.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"stevearc/dressing.nvim",
			},
			event = "LazyFile",
			cmd = {
				"FlutterRun",
				"FlutterDevices",
				"FlutterEmulators",
				"FlutterReload",
				"FlutterRestart",
				"FlutterQuit",
				"FlutterDetach",
				"FlutterOutlineToggle",
				"FlutterDevTools",
				"FlutterDevToolsActivate",
				"FlutterCopyProfilerUrl",
				"FlutterLspRestart",
				"FlutterSuper",
				"FlutterReanalyze",
				"FlutterRename",
			},
			opts = {
				debugger = {
					enabled = true,
					run_via_dap = true,
					exception_breakpoints = "default",
				},
				dev_log = {
					enabled = false,
				},
			},
			keys = {
				{ custom_opts.keys.flutter.start, "<cmd>FlutterRun<CR>", ft = "dart", desc = "flutter start" },
				{ custom_opts.keys.flutter.devices, "<cmd>FlutterDevices<CR>", ft = "dart", desc = "flutter devices" },
				{
					custom_opts.keys.flutter.emulators,
					"<cmd>FlutterEmulators<CR>",
					ft = "dart",
					desc = "flutter emulators",
				},
				{ custom_opts.keys.flutter.reload, "<cmd>FlutterReload<CR>", ft = "dart", desc = "flutter reload" },
				{ custom_opts.keys.flutter.restart, "<cmd>FlutterRestart<CR>", ft = "dart", desc = "flutter restart" },
				{ custom_opts.keys.flutter.quit, "<cmd>FlutterQuit<CR>", ft = "dart", desc = "flutter quit" },
				{ custom_opts.keys.flutter.detach, "<cmd>FlutterDetach<CR>", ft = "dart", desc = "flutter detach" },
				{ custom_opts.keys.flutter.rename, "<cmd>FlutterRename<CR>", ft = "dart", desc = "flutter rename" },
			},
		},
	}
end
