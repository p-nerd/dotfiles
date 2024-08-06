return {
    {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("dashboard").setup {
                theme = "hyper",
                config = {
                    week_header = {
                        enable = true,
                    },
                    shortcut = {
                        {
                            desc = "󰊳 Update",
                            group = "@property",
                            action = "Lazy update",
                            key = "u",
                        },
                        {
                            desc = " Files",
                            group = "Label",
                            action = "Telescope find_files",
                            key = "f",
                            icon_hl = "@variable",
                        },
                        {
                            desc = "🌲Tree",
                            group = "Label",
                            action = "NvimTreeToggle",
                            key = "t",
                        },
                        {
                            desc = " Mason",
                            group = "@property",
                            action = "Mason",
                            key = "m",
                        },
                    },
                },
            }
        end,
    },
}