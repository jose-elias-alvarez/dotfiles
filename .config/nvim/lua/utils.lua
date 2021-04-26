local uv = vim.loop
local api = vim.api

local nvim_config_dir = vim.fn.getenv("HOME") .. "/.config/nvim/lua/"

local get_map_options = function(opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend("force", options, opts) end
    return options
end

local close_handle = function(handle)
    if handle and not handle:is_closing() then handle:close() end
end

local code_is_ok = function(code) return code == 0 and true or false end

local M = {}

M.exec = function(command) vim.api.nvim_exec(command, false) end

M.t =
    function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
    end

M.contains = function(list, candidate)
    for _, element in pairs(list) do
        if element == candidate then return true end
    end
    return false
end

M.config_file_exists = function(name)
    local f = vim.loop.fs_open(nvim_config_dir .. name .. ".lua", "r", 438)
    if f then return true end
    return false
end

M.map = function(mode, lhs, rhs, opts)
    vim.api.nvim_set_keymap(mode, lhs, rhs, get_map_options(opts))
end

M.buf_map = function(bufnr, mode, lhs, rhs, opts)
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, get_map_options(opts))
end

M.buf_opt = function(bufnr, opt, val)
    vim.api.nvim_buf_set_option(bufnr, opt, val)
end

M.get_os = function()
    return vim.api.nvim_eval([[substitute(system("uname"), "\n", "", "")]])
end

_G.inspect = function(...) print(vim.inspect(...)) end
M.inspect = _G.inspect

M.concat = function(target, new)
    for _, v in pairs(new) do table.insert(target, v) end
end

M.buf_to_string = function(bufnr)
    if bufnr == nil then bufnr = 0 end
    local content = api.nvim_buf_get_lines(bufnr, 0, -1, false)
    return table.concat(content, "\n")
end

M.split_at_newline = function(str)
    local split = {}
    for line in string.gmatch(str, "([^\n]*)\n?") do
        table.insert(split, line)
    end
    table.remove(split)
    return split
end

M.buf_to_stdin = function(cmd, args, handler)
    local handle, ok
    local output, error_output = "", ""

    local handle_stdout = vim.schedule_wrap(
                              function(err, chunk)
            if err then error("stdout error: " .. err) end

            if chunk then output = output .. chunk end
            if not chunk then
                vim.wait(5000, function() return ok ~= nil end, 10)
                if not ok and error_output == "" then
                    error_output = output
                    output = ""
                end

                if output == "" then output = nil end
                if error_output == "" then error_output = nil end
                handler(error_output, output)
            end
        end)

    local handle_stderr = function(err, chunk)
        if err then error("stderr error: " .. err) end
        if chunk then error_output = error_output .. chunk end
    end

    local stdin = uv.new_pipe(true)
    local stdout = uv.new_pipe(false)
    local stderr = uv.new_pipe(false)
    local stdio = {stdin, stdout, stderr}

    handle = uv.spawn(cmd, {args = args, stdio = stdio}, function(code)
        ok = code_is_ok(code)

        stdout:read_stop()
        stderr:read_stop()

        close_handle(stdin)
        close_handle(stdout)
        close_handle(stderr)
        close_handle(handle)
    end)

    uv.read_start(stdout, handle_stdout)
    uv.read_start(stderr, handle_stderr)

    stdin:write(M.buf_to_string(), function() stdin:close() end)
end

return M
