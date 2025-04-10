return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
        require("mason").setup()

        require("mason-tool-installer").setup {
            ensure_installed = require "configs.tools",
            auto_update = false,
            run_on_start = true,
        }
    end,
}
