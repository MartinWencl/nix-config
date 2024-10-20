return {
    {
        "robitx/gp.nvim",
        config = function()
            local conf = {
                openai = {
                    endpoint = "https://api.openai.com/v1/chat/completions",
                    secret = { "cat", "/home/martinw/.dotfiles/secret.txt" },
                },
                agents = {
                    {
                        name = "ChatGPT4o",
                        chat = true,
                        command = false,
                        model = { model = "gpt-4o", temperature = 1.1, top_p = 1 },
                        system_prompt = "",
                    },
                },
                hooks = {
                    UnitTests = function(gp, params)
                        local template = "I have the following code from {{filename}}:\n\n"
                            .. "```{{filetype}}\n{{selection}}\n```\n\n"
                            .. "Please respond by writing table driven unit tests for the code above."
                        local agent = gp.get_command_agent()
                        gp.Prompt(params, gp.Target.enew, agent, template)
                    end,
                },
            }
            require("gp").setup(conf)

            vim.keymap.set({"n", "v"}, "<leader>ar", "<Cmd>GpRewrite<CR>")
            vim.keymap.set("n", "<leader><leader>a", "<Cmd>GpRewrite<CR>")
            vim.keymap.set({"n", "v"}, "<leader>arb", "<Cmd>%GpRewrite<CR>")
        end,
    },
}
