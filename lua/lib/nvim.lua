local function has(var)
    return vim.fn.has(var) == 1
end

local function exists(var)
    return vim.fn.exists(var) == 1
end

local function echo_err(msg)
    return vim.api.nvim_command('echoerr '..msg)
end

local function get(var)
    return vim.api.nvim_get_var(var)
end

return {
    has = has;
    exists = exists;
    get = get;
    echo_err = echo_err;
}
