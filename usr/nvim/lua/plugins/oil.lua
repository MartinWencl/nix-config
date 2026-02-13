return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  config = function(_, opts)
    require('oil').setup(opts)
    -- Set keybinding to open oil
    vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "Open file explorer (Oil)" })
  end,
}
