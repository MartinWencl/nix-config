return {
  dir = "~/source/explorer",
  config = function()
    require("expedition").setup({
      ai = {
        enabled = true,
        cli = {
          cmd = "claude",
          timeout = 120000,
        },
      },
    })
  end,
}
