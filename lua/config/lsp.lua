-- Setup LSP

vim.lsp.set_log_level("debug")
local lsps = {
	"lua-language-server",
	"rust-analyzer",
	"ccls",
	"marksman"
	-- "clangd",
}
vim.lsp.enable(lsps)

local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local capabilities_other = vim.lsp.protocol.make_client_capabilities()
local capabilities = vim.tbl_deep_extend('keep', cmp_capabilities, capabilities_other)

local map = vim.keymap.set

local range_conform = function()
	require("conform").format({ async = true }, function(err)
		if not err then
			local mode = vim.api.nvim_get_mode().mode
			if vim.startswith(string.lower(mode), "v") then
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
			end
		end
	end)
end

local on_attach = function(_, bufnr)
	local function opts(desc)
		return { buffer = bufnr, desc = "LSP " .. desc }
	end

	map("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
	map("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
	map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
	map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))
	--custom
	map("n", "<leader>la", vim.lsp.buf.code_action, opts("Code action"))
	map({ "n", "v" }, "<leader>lf", range_conform, opts("Format"))
	map("n", "gh", vim.lsp.buf.hover, opts("Hover"))

	map("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts("List workspace folders"))

	map("n", "<leader>D", vim.lsp.buf.type_definition, opts("Go to type definition"))
end

for _, lsp in ipairs(lsps) do
	vim.lsp.config(lsp, {
		capabilities = capabilities,
		on_attach = on_attach,
	})
end

-- Autocompletion
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client then
			if client:supports_method("textDocument/completion") then
				vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = false })
			end
		end
	end,
})


-- TODO: Enable diagnostics based on filetype
--
vim.diagnostic.enable(true)
