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
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
            callback = function(ev)
                local bufnr = ev.buf

                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "LSP: Rename" })
                vim.keymap.set("n", "<F3>", vim.lsp.buf.code_action, { buffer = bufnr, desc = "LSP: Code Action" })

                vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, { buffer = bufnr, desc = "LSP: Go to Definition" })
                vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, { buffer = bufnr, desc = "LSP: Find References" })
                vim.keymap.set("n", "gI", require("telescope.builtin").lsp_implementations, { buffer = bufnr, desc = "LSP: Go to Implementation" })
                vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "LSP: Type Definition" })
                vim.keymap.set("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, { buffer = bufnr, desc = "LSP: Document Symbols" })
                vim.keymap.set("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, { buffer = bufnr, desc = "LSP: Workspace Symbols" })

                vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP: Hover" })
                vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "LSP: Signature Help" })

                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "LSP: Go to Declaration" })
            end,
        })

        -- Global LSP config: apply blink.cmp capabilities to all servers
        vim.lsp.config('*', {
            capabilities = require('blink.cmp').get_lsp_capabilities(),
        })

        -- Enable all configured servers (configs are in lsp/*.lua)
        vim.lsp.enable({
            'gopls',
            'rust_analyzer',
            'ts_ls',
            'marksman',
            'clangd',
            'csharp_ls',
            'html',
            'lua_ls',
            'teal_ls',
        })
    end,
}
