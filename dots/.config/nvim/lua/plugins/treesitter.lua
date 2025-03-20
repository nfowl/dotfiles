return {
    "nvim-treesitter/nvim-treesitter",
    init = function(plugin)
        local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
        parser_config.cloudflare = {
            install_info = {
                url = "https://github.com/nfowl/tree-sitter-cloudflare",
                files = { "src/parser.c" },
                branch = "main",
                generate_requires_npm = false,
                requires_generate_from_grammar = false,
            },
            filetype = "cfrule",
        }
    end,
    opts = {
        parser_install_dir = parser_install_dir,
        -- Custom treesitters
        ensure_installed = { 
            "cloudflare",
            "rust",
            "lua",
            "json",
            "yaml",
            "toml",
            "html",
            "css",
            "javascript",
            "typescript",
            "tsx",
            "c",
            "cpp",
            "python",
            "bash",
            "go",
            "java",
            "graphql",
            "php",
            "ruby",
            "markdown",
            "regex",
            "dockerfile",
            "jsonc",
            "cmake",
            "comment",
            "query",
            "hcl",
            "starlark",
            "terraform",
        },
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
            custom_captures = {
            ["@error"] = "Error"
            }
        },
        textobjects = {
            select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ap"] = "@parameter.outer",
                ["ip"] = "@parameter.inner",
                ["ac"] = "@class.outer",
                ["av"] = "@class.outer",
                ["aa"] = "@assignment.outer",
                ["ai"] = "@assignment.inner",
                -- You can optionally set descriptions to the mappings (used in the desc parameter of
                -- nvim_buf_set_keymap) which plugins like which-key display
                ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                -- You can also use captures from other query groups like `locals.scm`
                ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
            },
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            -- selection_modes = {
            --   ['@parameter.outer'] = 'v', -- charwise
            --   ['@function.outer'] = 'V', -- linewise
            --   ['@class.outer'] = '<c-v>', -- blockwise
            -- },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true of false
            include_surrounding_whitespace = true,
            },
        },
    }
}