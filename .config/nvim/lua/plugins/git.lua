return {
    {
        "lewis6991/gitsigns.nvim",
        lazy = false,
        keys = {
            { "]h", ":silent Gitsigns next_hunk<CR>" },
            { "[h", ":silent Gitsigns prev_hunk<CR>" },
            -- { "gs", ":Gitsigns stage_hunk<CR>" },
            -- { "gS", ":Gitsigns undo_stage_hunk<CR>" },
            -- { "gp", ":Gitsigns preview_hunk<CR>" },
            -- { "gb", ":Gitsigns blame_line<CR>" },
        },
        opts = {
            preview_config = {
                border = { "", "", "", " " },
            },
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false,
            },
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "┄" },
                untracked = { text = "┆" },
            },
            signs_staged = {
                add = { text = "│" },
                change = { text = "≈" },
                delete = { text = "▁" },
                topdelete = { text = "▔" },
                changedelete = { text = "┈" },
                untracked = { text = "║" },
            },
        },
    },
    {
        "kdheepak/lazygit.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
        },
        cmd = {
            "LazyGit",
        },
        keys = {
            { "<leader>z", "<cmd>LazyGit<cr>", desc = "open lazygit", remap = true },
        },
    },
    {
        "tpope/vim-fugitive",
    },
    {
        "sindrets/diffview.nvim",
        keys = {
            { "<leader>d", "<cmd>DiffviewOpen<cr>", desc = "open diff view", remap = true },
        },
    },
}
