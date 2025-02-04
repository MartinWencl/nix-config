return {
    "neovim/nvim-lspconfig",
    dependencies = {
        -- Completion 
        'saghen/blink.cmp',

        -- Mason
        { "williamboman/mason.nvim", config = true },
        "williamboman/mason-lspconfig.nvim",


        -- Useful status updates for LSP
        { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
        --  This function gets run when an LSP connects to a particular buffer.
        local on_attach = function(_, bufnr)
            local nmap = function(keys, func, desc)
                if desc then
                    desc = "LSP: " .. desc
                end

                vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
            end

            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
            vim.keymap.set("n", "<F3>", vim.lsp.buf.code_action)

            -- TODO: Refactor code intelligence
            vim.keymap.set("n","gd", require("telescope.builtin").lsp_definitions)
            vim.keymap.set("n","gr", require("telescope.builtin").lsp_references)
            vim.keymap.set("n","gI", require("telescope.builtin").lsp_implementations)
            vim.keymap.set("n","<leader>D", vim.lsp.buf.type_definition)
            vim.keymap.set("n","<leader>ds", require("telescope.builtin").lsp_document_symbols)
            vim.keymap.set("n","<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols)

            -- See `:help K` for why this keymap
            vim.keymap.set("n","K", vim.lsp.buf.hover)
            vim.keymap.set("n","<C-k>", vim.lsp.buf.signature_help)

            -- Lesser used LSP functionality
            vim.keymap.set("n","gD", vim.lsp.buf.declaration)
            -- nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
            -- nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
            -- nmap("<leader>wl", function()
            --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            -- end, "[W]orkspace [L]ist Folders")
        end

        require("mason").setup()
        require("mason-lspconfig").setup()

        -- Declare lsp servers
        -- filetypes overrides on which lsp attaches
        local servers = {
            gopls = {},
            rust_analyzer = {},
            ts_ls = {},
            marksman = {},
            clangd = {},
            html = { filetypes = { "html", "twig", "hbs"} },

            lua_ls = {
                Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                },
            },
        }

        -- Setup neovim lua configuration
        require("neodev").setup()

        -- Blink
        local lspconfig = require('lspconfig')
        for server, config in pairs(servers) do
          -- passing config.capabilities to blink.cmp merges with the capabilities in your
          -- `opts[server].capabilities, if you've defined it
          config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
          lspconfig[server].setup(config)
        end

        local mason_lspconfig = require("mason-lspconfig")
        mason_lspconfig.setup_handlers({
            function(server_name)
                require("lspconfig")[server_name].setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = servers[server_name],
                    filetypes = (servers[server_name] or {}).filetypes,
                })
            end,
        })
    end,
}
