return {
	cmd = {'lua-language-server', "--background-index"},
	root_markers = {".luarc.json"},
	filetypes = { "lua" },
	settings = {
		Lua = {
			diagnostics = {
				globals = {
					'vim',
					'require',
				},
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},

}
