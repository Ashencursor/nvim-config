return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function()
      require("mason").setup()
      require("config.lsp")   -- <-- loads the whole folder/file
    end,
  },
}
