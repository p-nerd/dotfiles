return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "antosha417/nvim-lsp-file-operations",
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local servers = require "configs.lsp_servers"

        require("mason").setup {}
        require("mason-lspconfig").setup {
            ensure_installed = vim.tbl_keys(servers),
            automatic_installation = true,
        }
        require("lsp-file-operations").setup()

        local lspconfig = require "lspconfig"
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        -- Modify handler for textDocument/definition
        ---@diagnostic disable: duplicate-set-field
        vim.lsp.handlers["textDocument/definition"] = function(_, result, _, _)
            if not result or vim.tbl_isempty(result) then
                vim.notify("No definition found", vim.log.levels.WARN)
                return
            end

            if vim.tbl_islist(result) and #result > 0 then
                vim.lsp.util.jump_to_location(result[1], "utf-8")
            else
                vim.lsp.util.jump_to_location(result, "utf-8")
            end
        end

        lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
            capabilities = vim.tbl_deep_extend(
                "force",
                vim.lsp.protocol.make_client_capabilities(),
                require("lsp-file-operations").default_capabilities()
            ),
        })

        local on_attach = function(_, bufnr)
            local opts = function(opts)
                return vim.tbl_extend("force", {
                    noremap = true,
                    silent = true,
                    buffer = bufnr,
                }, opts or {})
            end

            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts { desc = "go to definition" })
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts { desc = "go to declaration" })
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts { desc = "go to references" })
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts { desc = "go to implementation" })

            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts { desc = "show hover documentation" })
            vim.keymap.set("n", "<C-k>", vim.diagnostic.open_float, opts { desc = "show hover diagnostics" })

            vim.keymap.set("n", "<leader>h", vim.lsp.buf.signature_help, opts { desc = "signature help" })
            vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts { desc = "code actions" })
            vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts { desc = "rename symbol" })

            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "go to prev diagnostic" })
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "go to next diagnostic" })
        end

        for server_name, server_settings in pairs(servers) do
            lspconfig[server_name].setup(vim.tbl_deep_extend("force", {
                capabilities = capabilities,
                on_attach = on_attach,
            }, server_settings or {}))
        end
    end,
}
