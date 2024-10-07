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
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
require("lazy").setup({
	spec = {
		{
			"pmizio/typescript-tools.nvim",
			dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
			opts = {},
		},
		{'VonHeikemen/lsp-zero.nvim', branch = 'v4.x'},
		{'neovim/nvim-lspconfig'},
		{'hrsh7th/cmp-nvim-lsp'},
		{'hrsh7th/nvim-cmp'},
		{
			"jiaoshijie/undotree",
			dependencies = "nvim-lua/plenary.nvim",
			config = true,
			keys = { -- load the plugin only when using it's keybinding:
				{ "<leader><F5>", "<cmd>lua require('undotree').toggle()<cr>" },
			},
		},
		{
			"kdheepak/lazygit.nvim",
			lazy = true,
			cmd = {
				"LazyGit",
				"LazyGitConfig",
				"LazyGitCurrentFile",
				"LazyGitFilter",
				"LazyGitFilterCurrentFile",
			},
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
			keys = {
				{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
			}
		},
		{
			'windwp/nvim-autopairs',
			event = "InsertEnter",
			config = true
		},
		{'nvim-telescope/telescope.nvim', tag = '0.1.8'},
		{
			'sainnhe/gruvbox-material',
			lazy = false,
			priority = 1000,
			config = function()
				-- Optionally configure and load the colorscheme
				-- directly inside the plugin declaration.
				vim.g.gruvbox_material_enable_italic = true
				vim.g.gruvbox_material_enable_bold = true
				vim.g.gruvbox_material_enable_bold = true
				vim.cmd.colorscheme('gruvbox-material')
			end
		},
		{'nvim-telescope/telescope.nvim', tag = '0.1.8'},
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			config = function () 
				local configs = require("nvim-treesitter.configs")

				configs.setup({
					ensure_installed = { "typescript", "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html" },
					highlight = { enable = true },
					indent = { enable = true },  
				})
			end
		}
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "gruvbox-material" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})
-- LSP Setup
require('lspconfig').lua_ls.setup({
})
require("typescript-tools").setup({
})
local cmp = require('cmp')

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  mapping = cmp.mapping.preset.insert({}),
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
})
