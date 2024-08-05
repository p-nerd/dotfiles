local lsps = {
    "bashls",
    "lua_ls",
    "mesonlsp",

    "html",
    "cssls",
    "emmet_ls",
    "tailwindcss",

    "jsonls",
    "markdown_oxide",
    "mdx_analyzer",
    "yamlls",

    "dockerls",
    "nginx_language_server",
    "sqlls",

    "clangd",

    "tsserver",
    "vuels",
    "svelte",
    "astro",

    "intelephense",
    "twiggy_language_server",

    "elixirls",

    "gopls",

    "rust_analyzer",
}

return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup {
                ui = {
                    icons = {
                        package_pending = " ",
                        package_installed = " ",
                        package_uninstalled = " ",
                    },
                },
                max_concurrent_installers = 10,
            }
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup {
                ensure_installed = lsps,
                automatic_installation = true,
            }
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require "lspconfig"

            for _, lsp in ipairs(lsps) do
                lspconfig[lsp].setup {}
            end
        end,
    },
}
