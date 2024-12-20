return {
    {
        "echasnovski/mini.pairs",
        version = false,
        config = function()
            require('mini.pairs').setup()
        end,
    },
    {
        "echasnovski/mini.surround",
        version = false,
        config = function()
            require('mini.surround').setup()
        end,
    },
    {
        "echasnovski/mini.operators",
        version = false,
        config = function()
            require('mini.operators').setup()
        end,
    },
    {
        "echasnovski/mini.bracketed",
        version = false,
        config = function()
            require('mini.bracketed').setup()
        end,
    },
    {
        "echasnovski/mini.files",
        version = false,
        config = function()
            require('mini.files').setup({
              mappings = {
                close       = 'q',
                go_in       = '<Rigth>',
                go_in_plus  = 'L',
                go_out      = '<CR>',
                go_out_plus = 'H',
                mark_goto   = "'",
                mark_set    = 'm',
                reset       = '<BS>',
                reveal_cwd  = '@',
                show_help   = 'g?',
                synchronize = '=',
                trim_left   = '<',
                trim_right  = '>',
              },

              options = {
                use_as_default_explorer = false,
              },

              windows = {
                max_number = math.huge,
                preview = true,
                width_focus = 50,
                width_nofocus = 15,
                width_preview = 25,
              },
            })

            vim.keymap.set("n", "<leader>e", "<Cmd>lua MiniFiles.open()<CR>")
        end,
    },
    {
        "echasnovski/mini.diff",
        version = false,
        config = function()
            require('mini.diff').setup()
        end,
    },
}

