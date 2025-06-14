return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
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
			highlight = {
				enable = true,
				use_languagetree = true,
			},

		},
		config = function(_, opts)
			local configs = require('nvim-treesitter.configs')
			configs.setup(opts)
		end,
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
		"mason-org/mason.nvim",
		lazy = false,
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		lazy = false,
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
				"clangd",
			},
			automatic_enable = false,
		},
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
			sections = {
				lualine_x = {
					'encoding',
					'lsp_status',
					'filetype',
				},
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
				{ "<leader>ff", bt.find_files,            { "n", "v" },{ desc = {"Find Files"}}},
				{ "<leader>fw", bt.live_grep,             { "n" } },
				{ "<leader>fb", bt.buffers,               { "n" } },
				{ "<leader>fb", bt.buffers,               { "n" } },
				{ "<leader>fo", bt.oldfiles,              { "n" } },
				-- LSP
				{ "<leader>fr", bt.lsp_references,        { "n" },     { desc = "Find References" } },
				{ "<leader>fs", bt.lsp_document_symbols,  { "n" },     { desc = "Find Document Symbols" } },
				{ "<leader>fS", bt.lsp_workspace_symbols, { "n" },     { desc = { "Find Workspace Symbols" } } },
				{ "<leader>fd", bt.lsp_definitions,       { "n" },     { desc = { "Find Definitions" } } },
				{ "<leader>ft", bt.lsp_type_definitions,  { "n" },     { desc = { "Find Type" } } },
			}
			return vim.tbl_deep_extend("force", keys, maps)
		end,
		config = function(_, opts)
			-- Display entry text after two tabs as comment.
			-- Used to display file paths as filename followed by greyed-out path.
			-- https://github.com/nvim-telescope/telescope.nvim/issues/2014#issuecomment-1873229658
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "TelescopeResults",
				callback = function(ctx)
					vim.api.nvim_buf_call(ctx.buf, function()
						vim.fn.matchadd("TelescopeParent", "\t\t.*$")
						vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
					end)
				end,
			})


			require('telescope').setup(opts)
			vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { fg = "#c7c7c7", bg = "#EEEEEE" })
		end,
		opts = {
			defaults = {
				path_display = function(_, path)
					local tail = vim.fs.basename(path)
					local parent = vim.fs.dirname(path)
					if parent == "." then
						return tail
					else
						return string.format("%s\t\t%s", tail, parent)
					end
				end,
				file_ignore_patterns = { "^.git/" },
				prompt_prefix = "   ",
				selection_caret = " ",
				entry_prefix = " ",
				sorting_strategy = "ascending",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
					},
					width = 0.87,
					height = 0.80,
				},
				mappings = {
					n = { ["q"] = require("telescope.actions").close },
				},
			},
			pickers = {
				find_files = {
					-- theme = "dropdown",
					find_command = {
						-- "rg",
						-- "--files",
						-- "--hidden",
						-- "--no-ignore-vcs",
						'fd',
						-- '-u',
						-- '-H',
						'-I',
						'-tf',
						'-tl',
						-- '-e h',
						-- '-e cpp',
						-- '-e c',

						-- "-E \'**/.ccls-cache/**\'",
						-- "-E \'**/clangd/**\'",
					},
					
				},
			},
			extensions_list = { "themes", "terms" },
			extensions = {},
		},
	},
	{
		"nvim-tree/nvim-tree.lua",
		enabled = false,
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
		'echasnovski/mini.files',
		version = false,
		opts = {},
		keys = function(_, keys)
			local minifiles_toggle = function(...)
				if not MiniFiles.close() then MiniFiles.open(...) end
			end

			local maps = {
				{ "<leader>n", function() minifiles_toggle(vim.api.nvim_buf_get_name(0)) end, { desc = "Toggle mini files" } }
			}

			return vim.tbl_deep_extend("force", keys, maps)
		end,
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
				cpp = { "clang-format" },
				c = { "clang-format" },
				h = { "clang-format" },
				sh = { "beautysh" },
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
			{ "hrsh7th/cmp-buffer" },
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
				sources = cmp.config.sources(
					{
						-- primary
						{ name = "nvim_lsp" },
					},
					{
						--secondary
						{ name = "buffer" },
					}
				),
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
			vim.api.nvim_set_hl(0, "ExtraWhitespace", { fg = "#EEEEEE", bg = "#EEEEEE" })
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
	{
		'ggandor/leap.nvim',
		lazy = false,
		config = function()
			local leap = require 'leap'
			leap.add_default_mappings()
			leap.opts.case_sensitive = true
		end,
		dependencies = {
			'tpope/vim-repeat'
		},
	},
	{
		'dhananjaylatkar/cscope_maps.nvim',
		dependencies = {
			'nvim-telescope/telescope.nvim',
			--'ludvicchabant/vim-gutentags',
		},
		opts = {
			skip_input_prompt = true,
			cscope = {
				db_file = {
					"cscope.out",
					"cscope.in.out",
					"cscope.po.out",
				},
				picker = "telescope",
				skip_picker_for_single_result = true,
				statusline_indicator = true,
				project_rooter = {
					enable = true,
					change_cwd = false,
				}
			}
		},
		-- ft = {
		--     "cpp", "c", "h", "hpp"
		-- },
		-- keys = {
		--     "<leader>cb",
		--     "<leader>cs",
		--     "<leader>cs",
		-- },
		lazy = false,
	},
	{
		"ludovicchabant/vim-gutentags",
		enabled = false,
		init = function()
			vim.g.gutentags_modules = { "cscope_maps" } -- This is required. Other config is optional
			vim.g.gutentags_cscope_build_inverted_index_maps = 1
			vim.g.gutentags_cache_dir = vim.fn.expand("~/code/.gutentags")
			vim.g.gutentags_file_list_command = "fd -e c -e h"
			-- vim.g.gutentags_trace = 1
		end,
	},
	{
		'MeanderingProgrammer/render-markdown.nvim',
		enabled = true,
		dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
		-- @module 'render-markdown'
		-- @type render.md.UserConfig
		opts = {
			completions = {
				lsp = {
					enabled = false,
				}
			},
			heading = {

			}
		},
	},
	{
		'hedyhli/markdown-toc.nvim',
		ft = "markdown",
		cmd = { "Mtoc" },
		opts = {},
	},
	{
		'sindrets/diffview.nvim',
		cmd = { "DiffviewOpen", "DiffViewFileHistory" },
	},
	{
		"ThePrimeagen/harpoon",
		lazy = false,
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function(_, opts)
			local harpoon = require("harpoon")
			harpoon:setup()

			local conf = require("telescope.config").values
			local function toggle_telescope(harpoon_files)
				local file_paths = {}
				for _, item in ipairs(harpoon_files.items) do
					table.insert(file_paths, item.value)
				end

				require("telescope.pickers").new({}, {
					prompt_title = "Harpoon",
					finder = require("telescope.finders").new_table({
						results = file_paths,
					}),
					previewer = conf.file_previewer({}),
					sorter = conf.generic_sorter({}),
				}):find()
			end

			vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
			vim.keymap.set("n", "<leader>hd", function() harpoon:list():delete() end)
			vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end)
		end,

	},
}
