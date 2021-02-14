local map = require("utils").map

require"compe".setup {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = "enable",
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    allow_prefix_unmatch = false,
    source = {
        path = true,
        buffer = true,
        calc = true,
        vsnip = true,
        nvim_lsp = true,
        nvim_lua = true
    }
}

map("i", "<C-Space>", "compe#complete()", {expr = true, silent = true})
map("i", "<C-y>", "compe#confirm(\"<C-y>\")", {expr = true, silent = true})
map("i", "<C-e>", "compe#confirm(\"<C-e>\")", {expr = true, silent = true})