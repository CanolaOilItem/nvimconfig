-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- install = { colorscheme = { "tokyonight" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

vim.cmd[[colorscheme tokyonight]]
vim.opt.fillchars = {
	eob = ' ',
}
vim.api.nvim_set_hl(0, 'WinSeparator', { fg = "#c7c7c7", bg = ""})
vim.api.nvim_set_hl(0, 'NvimTreeWinSeparator', { fg = "#c7c7c7", bg = ""})
vim.api.nvim_set_hl(0, 'LineNr', { fg = "#FFFFFF", bg = ""})
vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = "#c7c7c7", bg = ""})
vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = "#c7c7c7", bg = ""})
vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = "#c7c7c7", bg = ""})
vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { fg = "", bg = "#323244" })
vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { fg = "", bg = "#323244" })
vim.api.nvim_set_hl(0, 'TelescopePromptPrefix', { bg = "#323244" })
vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { bg = "#323244" })
vim.api.nvim_set_hl(0, 'TelescopeTitle', { fg = "", bg = "#323244" })
vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', { fg = "", bg = "#16161e" })
vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', { fg = "", bg = "#16161e" })
vim.api.nvim_set_hl(0, 'TelescopeBorder', { fg = "#323244" })
-- vim.api.nvim_set_hl(0, 'TelescopeNormal', { fg = "", bg = "#323244" })
