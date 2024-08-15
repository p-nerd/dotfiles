return {
    -- {
    --     "williamboman/mason.nvim",
    --     opts = {
    --         ensure_installed = {
    --             "phpcs",
    --         },
    --     },
    -- },
    -- {
    --     "mfussenegger/nvim-dap",
    --     optional = true,
    --     opts = function()
    --         local dap = require "dap"
    --         local path = require("mason-registry").get_package("php-debug-adapter"):get_install_path()
    --         dap.adapters.php = {
    --             type = "executable",
    --             command = "node",
    --             args = { path .. "/extension/out/phpDebug.js" },
    --         }
    --     end,
    -- },
    -- {
    --     "nvimtools/none-ls.nvim",
    --     optional = true,
    --     opts = function(_, opts)
    --         local nls = require "null-ls"
    --         opts.sources = opts.sources or {}
    --         table.insert(opts.sources, nls.builtins.diagnostics.phpcs)
    --     end,
    -- },
    -- {
    --     "mfussenegger/nvim-lint",
    --     optional = true,
    --     opts = {
    --         linters_by_ft = {
    --             php = { "phpcs" },
    --         },
    --     },
    -- },
}