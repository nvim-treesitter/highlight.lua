local nvim = require 'lib/nvim'
local has = nvim.has
local system = nvim.system
local err_msg = nvim.err_msg
local executable = nvim.executable
local list_runtime = nvim.list_runtime

local package_path = nil

for _, path in pairs(list_runtime()) do
    if string.match(path, 'nvim/.*/highlight.lua') then
        package_path = path
        break
    end
end

local REPOS = {
    javascript = {
        url = "https://github.com/tree-sitter/tree-sitter-javascript",
        files = "src/parser.c src/scanner.c",
    }
}

local function install_parser(lang)
    if has('win32') then
        err_msg('This command is not available on windows.')
        return
    end

    local repo = REPOS[lang]
    if not repo then
        err_msg('Parser not available for language '..lang)
        return
    end

    if not package_path then
        err_msg('Plugin runtime path not found.')
        return
    end

    if not executable('git') then
        err_msg('Please install `git` to download parsers.')
        return
    end

    print("Downloading parser...")
    system("cd /tmp && git clone "..repo.url)

    print("Compiling parser...")
    system("cd /tmp/tree-sitter-"..lang..[[ && \
    gcc -o parser.so -shared ]]..repo.files..[[ -Os -I./src && \
    mv parser.so ]]..package_path.."/parser/"..lang..[[.so && \
    rm -rf /tmp/tree-sitter-]]..lang)

    print("Done !")
end

return { install_parser = install_parser }
