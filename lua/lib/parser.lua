local nvim = require 'lib/nvim'
local err_msg = nvim.err_msg
local get_runtime_file = nvim.get_runtime_file

local function has_parser(lang)
    local parser = get_runtime_file('parser/'..lang..'.so', false)[1]

    if not parser or not vim.loop.fs_access(parser, 'RX') then
        err_msg('Did not find parser for language `' .. lang ..'`. Please run `:InstallTSParser '..lang..'`')
        return false
    end

    return true
end

return {
    has_parser = has_parser
}
