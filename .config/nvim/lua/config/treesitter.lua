local parsers = require "nvim-treesitter.parsers"

parsers.get_parser_configs().blade = {
    install_info = {
        url = "https://github.com/EmranMR/tree-sitter-blade",
        files = {
            "src/parser.c",
        },
        branch = "main",
    },
    filetype = "blade",
}

vim.filetype.add {
    pattern = {
        [".*%.blade%.php"] = "blade",
    },
}
