return {
    {
        "saghen/blink.compat",
        version = "*",
        lazy = true,
        opts = {
            impersonate_nvim_cmp = true,
        },
    },

    {
        "saghen/blink.cmp",
        lazy = false, -- lazy loading handled internally
        dependencies = {
            "rafamadriz/friendly-snippets",
            "stevearc/dressing.nvim",
        },

        -- Use latest stable v1.x
        version = "*",

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = { preset = "enter" },

            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = "mono",
            },

            completion = {
                accept = {
                    auto_brackets = {
                        enabled = true,
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                },
            },

            sources = {
                -- Default sources for all filetypes
                default = { "lsp", "path", "snippets", "buffer" },

                -- Per-filetype configuration
                per_filetype = {
                    markdown = { "obsidian", "obsidian_new", "obsidian_tags" },
                    lua = { "lazydev", "lsp", "path", "snippets", "buffer" },
                },

                providers = {
                    lsp = {
                        score_offset = 90,
                    },
                    snippets = {
                        score_offset = 85,
                    },
                    path = {
                        score_offset = 25,
                    },
                    buffer = {
                        score_offset = 15,
                        max_items = 50,
                    },
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                    obsidian = {
                        name = "obsidian",
                        module = "blink.compat.source",
                        score_offset = 100,
                    },
                    obsidian_new = {
                        name = "obsidian_new",
                        module = "blink.compat.source",
                        score_offset = 100,
                    },
                    obsidian_tags = {
                        name = "obsidian_tags",
                        module = "blink.compat.source",
                        score_offset = 100,
                    },
                },
            },

            signature = {
                enabled = true,
                window = {
                    border = "rounded",
                },
            },
        },
    },
}
