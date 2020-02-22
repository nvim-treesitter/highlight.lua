local fn = vim.fn
local api = vim.api

local function has(var)
    return fn.has(var) == 1
end

local function exists(var)
    return fn.exists(var) == 1
end

local function echo_err(msg)
    return api.nvim_command('echoerr '..msg)
end

local function get(var)
    return api.nvim_get_var(var)
end

return {
    has = has;
    exists = exists;
    get = get;
    echo_err = echo_err;
}
