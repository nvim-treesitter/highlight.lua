local nvim = require 'lib/nvim'
local err_msg = nvim.err_msg
local list_runtime = nvim.list_runtime

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
    has_parser = has_parser
}
