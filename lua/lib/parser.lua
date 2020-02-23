local echo_err = require 'lib/nvim'.echo_err

local function has_parser(lang)
    for path in string.gmatch(package.path, '[^;]*') do
        local parser = string.sub(path, 0, -10)..'parser/'..lang..'.so'
        if vim.loop.fs_access(parser, 'RX') then
            return true
        end
    end
    echo_err('Did not find parser for language `' .. lang ..'`. Please run `:InstallParser '..lang..'`')
    return false
end

return {
    has_parser = has_parser
}
