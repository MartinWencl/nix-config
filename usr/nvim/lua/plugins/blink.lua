-- require("codecompanion")
--
return {
    {
        "saghen/blink.compat",
        version = "*",
        lazy = true,
        -- make sure to set opts so that lazy.nvim calls blink.compat's setup
        opts = {
            debug = true,
            impersonate_nvim_cmp = true,
        },
    },

    {
        "saghen/blink.cmp",
        lazy = false, -- lazy loading handled internally
        -- optional: provides snippets for the snippet source
        dependencies = {
            "rafamadriz/friendly-snippets",
            "stevearc/dressing.nvim",
        },

        -- use a release tag to download pre-built binaries
        version = "v0.7.6",
        -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' for mappings similar to built-in completion
            -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
            -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
            -- see the "default configuration" section below for full documentation on how to define
            -- your own keymap.
            keymap = { preset = "enter" },

            appearance = {
                -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                -- Useful for when your theme doesn't support blink.cmp
                -- will be removed in a future release
                use_nvim_cmp_as_default = true,
                -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = "mono",
            },

            sources = {
                completion = {
                    enabled_providers = {
                        "lsp",
                        "path",
                        "snippets",
                        "buffer",
                        "codecompanion",
                    },
                    per_filetype = {
                        markdown = {
                            "obsidian",
                            "obsidian_new",
                            "obsidian_tags",
                        },
                    },
                },
                providers = {
                    codecompanion = {
                        name = "CodeCompanion",
                        module = "codecompanion.providers.completion.blink",
                        enabled = true,
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

            signature = { enabled = true },
            -- allows extending the providers array elsewhere in your config
            -- without having to redefine it
            opts_extend = { "sources.default" },
        },
    },
}
