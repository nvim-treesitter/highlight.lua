local nvim = require 'lib/nvim'
local err_msg = nvim.err_msg
local get_runtime_file = nvim.get_runtime_file

local function read_scm(path)
    local f = io.open(path, "rb")
    if not f then return nil end
    local content = f:read("*all")
    f:close()
    return content
end

local function get_query(lang)
    local file = get_runtime_file('lua/syntax/'..lang..'.scm', false)[1]

    if not file or not vim.loop.fs_access(file, 'R') then
        err_msg('Did not find query for language `' .. lang ..'`')
        return nil
    end

    return read_scm(file)
end

local function has_parser(lang)
    local parser = get_runtime_file('parser/'..lang..'.so', false)[1]

    if not parser or not vim.loop.fs_access(parser, 'RX') then
        err_msg('Did not find parser for language `' .. lang ..'`. Please run `:InstallTSParser '..lang..'`')
        return false
    end

    return true
end

return {
    has_parser = has_parser;
    get_query = get_query;
}
