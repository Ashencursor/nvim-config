-- Keymaps to all servers
local function on_attach(_, bufnr)
    local opts = { buffer = bufnr }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })
    end, opts)
end

-- defaults to all servers
--vim.lsp.config("*", {
--    on_attach = on_attach,
--   opts = opts,
--})

-- Rust
vim.lsp.config("rust_analyzer", {
    filetypes = { "rust" },
    on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            cargo = { allFeatures = true },
						checkOnSave = { enable = false },
						checkOnChange = true,
            check = { command = "clippy" },
        }
    }
})

-- C++
vim.lsp.config("clangd", {
    filetypes = { "c", "cpp", "objc", "objcpp" },
    on_attach = on_attach,
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--completion-style=detailed",
        "--header-insertion=iwyu",
    },
})

-- Start the LSPs
-- Cant do vim.lsp.enable() for some reason
-- I think its because it cant detect the stuff
vim.lsp.enable({       
    "clangd",
    "rust_analyzer",
    })


