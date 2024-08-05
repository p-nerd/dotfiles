return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        tag = "0.1.8",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            -- Clone the default Telescope configuration
            local vimgrep_arguments = {
                unpack(require("telescope.config").values.vimgrep_arguments),
            }

            require("telescope").setup {
                defaults = {
                    vimgrep_arguments = vimgrep_arguments,
                    sorting_strategy = "ascending",
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                        },
                    },
                    mappings = {
                        n = {
                            ["q"] = require("telescope.actions").close,
                        },
                    },
                },
                pickers = {
                    find_files = {
                        -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
                        find_command = {
                            "rg",
                            "--files",
                            "--hidden",
                            "--glob",
                            "!**/.git/*",
                        },
                    },
                },
            }

            -- I want to search in hidden/dot files.
            table.insert(vimgrep_arguments, "--hidden")
            -- I don't want to search in the `.git` directory.
            table.insert(vimgrep_arguments, "--glob")
            table.insert(vimgrep_arguments, "!**/.git/*")
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup {
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {},
                    },
                },
            }
            require("telescope").load_extension "ui-select"
        end,
    },
}
