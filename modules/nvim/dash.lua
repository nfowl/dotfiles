local logo = [[
]]
logo = string.rep("\n", 8) .. logo .. "\n\n"
-- dashboard
require("dashboard").setup {
  theme = "doom",
  config = {
    header = vim.split(logo, "\n"),
  },
}
