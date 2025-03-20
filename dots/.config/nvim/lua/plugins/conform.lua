return {
  "conform.nvim",
  opts = {
    formatters_by_ft = {
      terraform = { "terraform_fmt" },
      python = { "isort", "ruff_format" },
      typescript = { "prettier" },
      markdown = { "prettier" },
      json = { "prettier" },
      starlark = { "buildifier" },
      bazel = { "buildifier" },
      bzl = { "buildifier" },
      -- Experimental and need to work out if worth it
      -- toml = { "taplo" },
      -- lua = { "stylua" },
    },
    -- Longer timeout on terraform
    -- format_on_save = function(bufnr)
    --   if vim.bo[bufnr].filetype == "terraform" then
    --     return { lsp_fallback = true, timeout_ms = 10000, }
    --   end
    --   return { lsp_fallback = true, }
    -- end,
    formatters = {
      ruff_format = {
        args = {
          "format",
          "--line-length=100",
          "--stdin-filename",
          "$FILENAME",
          "-",
        },
      },
      black = {
        prepend_args = {
          "--line-length=100",
        },
      },
      isort = {
        prepend_args = {
          "--profile", "google",
          "--line-length", "100",
          "--multi-line", "3",
          "--trailing-comma",
          "--use-parentheses",
          "--ensure-newline-before-comments",
        },
      }
    }
  }
}

