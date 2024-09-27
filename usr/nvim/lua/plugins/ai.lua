return {
    -- https://github.com/jackMort/ChatGPT.nvim
    -- {
    --     "jackMort/ChatGPT.nvim",
    --     dependencies = {
    --         { "MunifTanjim/nui.nvim" },
    --         { "nvim-lua/plenary.nvim" },
    --         { "nvim-telescope/telescope.nvim" },
    --     },
    --     -- event = "VeryLazy",
    --     config = function()
    --         require("chatgpt").setup({
    --             api_key_cmd = "/home/martinw/.config/nvim/secret.sh",
    --             actions_paths = {},
    --             openai_params = {
    --                 model = "gpt-4o",
    --                 max_tokens = 4000,
    --             },
    --             openai_edit_params = {
    --                 model = "gpt-4o",
    --                 max_tokens = 4000,
    --                 temperature = 0,
    --                 top_p = 1,
    --                 n = 1,
    --             },
    --         })
    --     end,
    -- },

    {
    -- help:
    -- /modellist
    -- /model  <model name from model list>
    -- /replace <number from code suggestion>
    -- exit with CTRL+C
        "dustinblackman/oatmeal.nvim",
        cmd = { "Oatmeal" },
        keys = {
            { "<leader>om", mode = "n", desc = "Start Oatmeal session" },
        },
        opts = {
            backend = "ollama",
            model = "codellama:latest",
        },
    },
}
