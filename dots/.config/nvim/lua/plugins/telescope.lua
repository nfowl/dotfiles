return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader><space>", LazyVim.pick("files", { root = false }), desc = "Find Files (CWD)" },
    { "<leader>/", LazyVim.pick("live_grep", { root = false }), desc = "Grep (Root Dir)" },
    { "<leader>sg", LazyVim.pick("live_grep", { root = false }), desc = "Grep (Root Dir)" },
  },
}
