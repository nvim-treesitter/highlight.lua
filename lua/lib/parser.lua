local echo_err = require 'lib/nvim'.echo_err

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
    for path in string.gmatch(package.path, '[^;]*') do
        local parser = string.sub(path, 0, -10)..'parser/'..lang..'.so'
        if vim.loop.fs_access(parser, 'RX') then
            return true
        end
    end

    echo_err('Did not find parser for language `' .. lang ..'`. Please run `:InstallParser '..lang..'`.')
    return false
end

return {
    has_parser = has_parser;
    get_query = get_query;
}
