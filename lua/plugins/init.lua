return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"c",
				"lua",
				"cpp",
				"rust",
				"markdown",
				"vimdoc",
				"markdown_inline",
			},
			auto_install = true,
		},
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "night",
			transparent = "false",
			styles = {
				-- sidebars = "transparent",
				-- floats = "transparent",
			},
		},
	},
	{
		"williamboman/mason.nvim",
		lazy = false,
		opts = {},
	},
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				section_separators = { left = "", right = "" },
				globalstatus = true,
			},
		},
		config = function(_, opts)
			local custom_ocean = require("lualine.themes.OceanicNext")
			custom_ocean.normal.a.bg = ""
			custom_ocean.normal.b.bg = ""
			custom_ocean.normal.c.bg = ""
			custom_ocean.insert.a.bg = ""
			custom_ocean.insert.b.bg = ""
			custom_ocean.insert.c.bg = ""
			custom_ocean.visual.a.bg = ""
			custom_ocean.visual.b.bg = ""
			custom_ocean.visual.c.bg = ""
			opts.options.theme = custom_ocean
			require("lualine").setup(opts)
		end,
	},
	{
		"xiyaowong/transparent.nvim",
		lazy = false,
		opts = {
			extra_groups = {
				"NvimTreeNormal",
			},
		},
		config = function(_, opts)
			require("transparent").clear_prefix("NvimTree")
			require("transparent").setup(opts)
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = function(_, keys)
			local bt = require("telescope.builtin")
			local maps = {
				{ "<leader>ff", bt.find_files, { "n", "v" } },
				{ "<leader>fw", bt.live_grep, { "n" } },
				{ "<leader>fb", bt.buffers, { "n" } },
				{ "<leader>fb", bt.buffers, { "n" } },
				{ "<leader>fo", bt.oldfiles, { "n" } },
				-- LSP
				{ "<leader>fr", bt.lsp_references, { "n" }, { desc = "Find References" } },
				{ "<leader>fs", bt.lsp_document_symbols, { "n" }, { desc = "Find Document Symbols" } },
				{ "<leader>fS", bt.lsp_workspace_symbols, { "n" }, { desc = { "Find Workspace Symbols" } } },
				{ "<leader>fd", bt.lsp_definitions, { "n" }, { desc = { "Find Definitions" } } },
				{ "<leader>ft", bt.lsp_type_definitions, { "n" }, { desc = { "Find Type" } } },
			}
			return vim.tbl_deep_extend("force", keys, maps)
		end,
		opts = {
			pickers = {
				find_files = {
					theme = "dropdown",
				},
			},
		},
	},
	{
		"nvim-tree/nvim-tree.lua",
		cmd = {
			"NvimTreeOpen",
		},
		keys = function(_, keys)
			local tree = require("nvim-tree")
			local api = require("nvim-tree.api")
			local maps = {
				{ "<C-N>", api.tree.toggle, { "n" }, { desc = "Toggle Nvim Tree" } },
			}

			return vim.tbl_deep_extend("force", keys, maps)
		end,
		opts = {
			actions = {
				open_file = {
					quit_on_open = true,
				},
			},
		},
	},
	{
		"mcauley-penney/visual-whitespace.nvim",
		config = true,
		event = "ModeChanged *:[vV\22]", -- optionally, lazy load on entering visual mode
		opts = {},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		opts = {
			disable_filetype = { "TelescopePrompt", "vim" },
		},
	},
	-- LSP CMP
	{
		"stevearc/conform.nvim",
		lazy = true,
		keys = {
			"<leader>lf",
		},

		---@module "conform"
		---@type conform.setupOpts
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				rust = { "rustfmt", lsp_format = "fallback" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
		},
		opts = function()
			local cmp = require("cmp")
			local opts = {
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					-- { name = 'vsnip' }, -- For vsnip users.
					-- { name = 'luasnip' }, -- For luasnip users.
					-- { name = 'ultisnips' }, -- For ultisnips users.
					-- { name = 'snippy' }, -- For snippy users.
				}, {
					{ name = "buffer" },
				}),
			}
			return opts
		end,
	},
	{
		"chentoast/marks.nvim",
		lazy = true,
		event = "VeryLazy",
		opts = {
			mappings = {
				annotate = "m&",
			},
			bookmark_0 = {
				sign = "⚑",
				virt_text = "Lea! Hi!",
				annotate = true,
			},
			bookmark_1 = {
				sign = "󰜫",
			},
			bookmark_2 = {
				sign = "",
			},
		},
	},
	{
		"ntpeters/vim-better-whitespace",
		lazy = false,
		opts = {},
		config = function(_, _)
			vim.api.nvim_set_hl(0, "ExtraWhitespace", { fg = "#111111", bg = "#111111" })
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
}
