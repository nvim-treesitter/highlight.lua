local fn = vim.fn
local api = vim.api

local list_runtime = api.nvim_list_runtime_paths
local get_runtime_file = api.nvim_get_runtime_file
local system = fn.system

local function executable(ex)
    return fn.executable(ex) == 1
end

local function has(var)
    return fn.has(var) == 1
end

local function exists(var)
    return fn.exists(var) == 1
end

local function err_msg(err)
    if err ~= nil then
        api.nvim_command('echohl ErrorMsg')
        api.nvim_command('echomsg "'..err..'"')
        api.nvim_command('echohl None')
    end
end

local function get(var, fallback)
    if exists(var) then
        return api.nvim_get_var(var)
    else
        return fallback
    end
end

return {
    has = has;
    exists = exists;
    get = get;
    err_msg = err_msg;
    executable = executable;
    list_runtime = list_runtime;
    system = system;
    get_runtime_file = get_runtime_file;
}
