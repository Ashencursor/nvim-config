return {{
    "mason-org/mason.nvim",
    opts = {},
    dependencies = {"neovim/nvim-lspconfig"},

    config = function()
        -- require("nvim-lspconfig")
        require("mason").setup() -- install and manage LSP servers
        require("lspconfig") -- nvim-lspconfig is a collection of LSP server configurations for the Nvim LSP client

        require('config.lsp')
    end
}}
