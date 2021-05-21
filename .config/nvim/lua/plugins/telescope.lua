local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local conf = require("telescope.config").values
local u = require("utils")

local vimgrep_arguments = vim.list_extend(conf.vimgrep_arguments, {
    "--hidden", "-g", "!{node_modules,.git}"
})

telescope.setup {
    extensions = {
        fzf = {override_generic_sorter = true, override_file_sorter = true}
    },
    defaults = {mappings = {i = {["<Esc>"] = actions.close, ["<C-u>"] = false}}}
}

local find_files = function(opts)
    if opts and opts.search_dirs then
        builtin.find_files(opts)
        return
    end

    local is_git_project = pcall(builtin.git_files, opts)
    if not is_git_project then builtin.find_files(opts) end
end

_G.telescope_custom = {
    live_grep = function()
        builtin.grep_string {
            shorten_path = true,
            word_match = "-w",
            only_sort_text = true,
            search = "",
            vimgrep_arguments = vimgrep_arguments
        }
    end,
    find_files = find_files,
    open = function()
        local open = function(arg)
            vim.g.loaded_netrw = true
            local search_dirs = arg and {arg} or nil
            find_files({search_dirs = search_dirs})
        end

        local args = vim.v.argv
        table.remove(args, 1)
        if vim.tbl_isempty(args) then
            open()
            return
        end

        for _, arg in pairs(args) do
            if vim.fn.isdirectory(arg) == 1 then
                open(arg)
                return
            end
        end
    end
}
u.define_augroup("TelescopeOnEnter", "VimEnter", "lua telescope_custom.open()")

u.define_lua_command("Files", "telescope_custom.find_files()")
u.define_lua_command("Rg", "telescope_custom.live_grep()")
u.define_command("BLines", "Telescope current_buffer_fuzzy_find")
u.define_command("History", "Telescope oldfiles")
u.define_command("Buffers", "Telescope buffers")
u.define_command("BCommits", "Telescope git_bcommits")
u.define_command("Commits", "Telescope git_commits")

u.map("n", "<Leader>ff", "<cmd>Files<CR>")
u.map("n", "<Leader>fg", "<cmd>Rg<CR>")
u.map("n", "<Leader>fb", "<cmd>Buffers<CR>")
u.map("n", "<Leader>fh", "<cmd>History<CR>")
u.map("n", "<Leader>fl", "<cmd>BLines<CR>")
u.map("n", "<Leader>fs", "<cmd>LspSym<CR>")

-- lsp
u.define_command("LspRef", "Telescope lsp_references")
u.define_command("LspSym", "Telescope lsp_workspace_symbols")
u.define_command("LspAct", "Telescope lsp_code_actions")

u.map("n", "ga", "<cmd>LspAct<CR>")
u.map("n", "gr", "<cmd>LspRef<CR>")
