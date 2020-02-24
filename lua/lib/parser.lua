local nvim = require 'lib/nvim'
local err_msg = nvim.err_msg
local list_runtime = nvim.list_runtime

local function read_scm(path)
    local f = io.open(path, "rb")
    if not f then return nil end
    local content = f:read("*all")
    f:close()
    return content
end

local function get_query(lang)
    for path in string.gmatch(package.path, '[^;]*') do
        local parser = string.sub(path, 0, -10)..'lua/syntax/'..lang..'.scm'
        if vim.loop.fs_access(parser, 'R') then
            return read_scm(parser)
        end
    end

    echo_err('Did not find query for language `' .. lang)
    return nil
end

local function has_parser(lang)
    for _, path in pairs(list_runtime()) do
        local parser = path..'/parser/'..lang..'.so'
        if vim.loop.fs_access(parser, 'RX') then
            return true
        end
    end

    err_msg('Did not find parser for language `' .. lang ..'`. Please run `:InstallTSParser '..lang..'`')
    return false
end

return {
    has_parser = has_parser;
    get_query = get_query;
}
