return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
    },

    config = function()
      local lsp = require("lsp-zero")

      lsp.preset("recommended")

      -- ======================================
      -- 1. Mason MUST be set up first
      -- ======================================
      require("mason").setup()

      -- ======================================
      -- 2. Mason-LSPConfig handles server setup
      -- ======================================
      require("mason-lspconfig").setup({
        ensure_installed = { "clangd" },

        handlers = {
          -- Default handler for all servers
          function(server)
            require("lspconfig")[server].setup({})
          end,

          -- Custom clangd config
          ["clangd"] = function()
            require("lspconfig").clangd.setup({
              cmd = { "clangd", "--background-index", "--clang-tidy" },
              filetypes = { "c", "cpp", "objc", "objcpp" },
            })
          end,
        },
      })

      -- ======================================
      -- CMP SETUP (new for lsp-zero v3)
      -- ======================================
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        }
      })
      
      lsp.on_attach(function(_, bufnr)
        local opts = { buffer = bufnr }
        local km = vim.keymap.set

        km("n", "gd", vim.lsp.buf.definition, opts)
        km("n", "gr", vim.lsp.buf.references, opts)
        km("n", "K", vim.lsp.buf.hover, opts)
        km("n", "<leader>rn", vim.lsp.buf.rename, opts)
        km("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      end)

      lsp.setup()

      vim.diagnostic.config({
        virtual_text = true,
      })
    end,
  }
}
