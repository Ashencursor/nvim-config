return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
    },
    config = function()
			-- Optional: Automatically install specified language servers
      require("mason").setup()
			require("mason-lspconfig").setup({
			ensure_installed = { "clangd", "rust_analyzer", "lua_ls" },
			automatic_enable = true, -- Enable all installed servers by default
		})
      require("config.lsp")   -- <-- loads the whole folder/file
    end,
  },
}
