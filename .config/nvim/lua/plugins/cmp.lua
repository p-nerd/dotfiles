local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

local tab_fallback = function(cmp, luasnip)
    return function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        elseif luasnip.locally_jumpable(1) then
            luasnip.jump(1)
        elseif has_words_before() then
            cmp.complete()
        else
            fallback()
        end
    end
end

local shift_tab_fallback = function(cmp, luasnip)
    return function(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end
end

-- local icons = {
--     Array = " ",
--     Boolean = "󰨙 ",
--     Class = " ",
--     Codeium = "󰘦 ",
--     Color = " ",
--     Control = " ",
--     Collapsed = " ",
--     Constant = "󰏿 ",
--     Constructor = " ",
--     Copilot = " ",
--     Enum = " ",
--     EnumMember = " ",
--     Event = " ",
--     Field = " ",
--     File = " ",
--     Folder = " ",
--     Function = "󰊕 ",
--     Interface = " ",
--     Key = " ",
--     Keyword = " ",
--     Method = "󰊕 ",
--     Module = " ",
--     Namespace = "󰦮 ",
--     Null = " ",
--     Number = "󰎠 ",
--     Object = " ",
--     Operator = " ",
--     Package = " ",
--     Property = " ",
--     Reference = " ",
--     Snippet = " ",
--     String = " ",
--     Struct = "󰆼 ",
--     TabNine = "󰏚 ",
--     Text = " ",
--     TypeParameter = " ",
--     Unit = " ",
--     Value = " ",
--     Variable = "󰀫 ",
-- }

return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-calc",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "roobert/tailwindcss-colorizer-cmp.nvim",
        "zbirenbaum/copilot-cmp",
    },
    config = function()
        require("copilot_cmp").setup()

        local sources = {
            nvim_lsp = "lsp",
            nvim_lsp_signature_help = "signature",
            buffer = "buffer",
            path = "path",
            calc = "calc",
            luasnip = "snippet",
            copilot = "copilot",
        }

        ---@type table
        local cmp = require "cmp"
        ---@type table
        local luasnip = require "luasnip"

        cmp.setup {
            preselect = cmp.PreselectMode.Item,
            sorting = (require "cmp.config.default"()).sorting,
            completion = {
                completeopt = "menu,menuone,noinsert",
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = {
                ["<CR>"] = cmp.mapping.confirm { select = true },
                ["<Tab>"] = cmp.mapping(tab_fallback(cmp, luasnip), { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(shift_tab_fallback(cmp, luasnip), { "i", "s" }),
            },
            sources = {
                { name = "nvim_lsp" },
                { name = "nvim_lsp_signature_help" },
                { name = "buffer" },
                { name = "path" },
                { name = "calc" },
                { name = "luasnip" },
            },
            formatting = {
                fields = { "abbr", "kind", "menu" },
                format = function(entry, item)
                    -- Ensure source name is a string
                    local source_name = entry.source.name or ""
                    local source_label = sources[source_name] or source_name

                    -- Ensure kind is a string
                    local kind_text = item.kind or ""

                    -- Build the kind string safely
                    item.kind = string.format("[%s] %s", source_label, kind_text)

                    -- Apply tailwindcss colorizer formatting
                    return require("tailwindcss-colorizer-cmp").formatter(entry, item)
                end,
            },
        }

        require("luasnip.loaders.from_vscode").lazy_load {
            paths = { vim.fn.stdpath "config" .. "/snippets" },
        }
    end,
}
