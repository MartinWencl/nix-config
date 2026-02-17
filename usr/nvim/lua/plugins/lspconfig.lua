return {
    "neovim/nvim-lspconfig",
    dependencies = {
        -- Completion
        'saghen/blink.cmp',

        -- Useful status updates for LSP
        { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
        -- LSP keymaps via LspAttach autocmd
        -- Using Neovim 0.11 default mappings (gr*, gO, K)
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
            callback = function(ev)
                local bufnr = ev.buf

                -- Neovim 0.11 default mappings
                vim.keymap.set("n", "grn", vim.lsp.buf.rename, { buffer = bufnr, desc = "LSP: Rename" })
                vim.keymap.set("n", "gra", vim.lsp.buf.code_action, { buffer = bufnr, desc = "LSP: Code Action" })
                vim.keymap.set("n", "grr", require("telescope.builtin").lsp_references, { buffer = bufnr, desc = "LSP: References" })
                vim.keymap.set("n", "gri", require("telescope.builtin").lsp_implementations, { buffer = bufnr, desc = "LSP: Implementation" })
                vim.keymap.set("n", "grt", require("telescope.builtin").lsp_type_definitions, { buffer = bufnr, desc = "LSP: Type Definition" })
                vim.keymap.set("n", "gO", require("telescope.builtin").lsp_document_symbols, { buffer = bufnr, desc = "LSP: Document Symbols" })

                -- Navigation (telescope integration)
                vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, { buffer = bufnr, desc = "LSP: Go to Definition" })
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "LSP: Go to Declaration" })

                -- Hover and signature help
                vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP: Hover" })
                vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "LSP: Signature Help" })

                -- Formatting
                vim.keymap.set("n", "grf", function() vim.lsp.buf.format({ async = true }) end, { buffer = bufnr, desc = "LSP: Format" })

                -- Workspace symbols
                vim.keymap.set("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, { buffer = bufnr, desc = "LSP: Workspace Symbols" })
            end,
        })

        -- Global LSP config: apply blink.cmp capabilities to all servers
        vim.lsp.config('*', {
            capabilities = require('blink.cmp').get_lsp_capabilities(),
        })

        -- Enable all configured servers
        -- Configs come from nvim-lspconfig + overrides in after/lsp/*.lua
        vim.lsp.enable({
            'gopls',
            'rust_analyzer',
            'ts_ls',
            'volar',
            'marksman',
            'clangd',
            'omnisharp',
            'html',
            'lua_ls',
            'teal_ls',
            'nil_ls',
        })
    end,
}
