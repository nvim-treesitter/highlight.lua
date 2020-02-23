local fn = vim.fn
local api = vim.api

local function has(var)
    return fn.has(var) == 1
end

local function exists(var)
    return fn.exists(var) == 1
end

local function echo_err(err)
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
    echo_err = echo_err;
}
