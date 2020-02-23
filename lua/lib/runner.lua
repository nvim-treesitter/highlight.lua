local luv = vim.loop

local function get_highlighter(buf, definitions, color_lang)
    return function(node)
        local node_type = node:type()
        local row1, col1, row2, col2 = node:range()

        local highlight_group = definitions[node_type]

        if highlight_group == nil then
            print(node_type)
            return
        elseif highlight_group == '' then
            return
        end

        highlight_group = color_lang .. highlight_group

        local line = row1
        local col_start
        local col_end

        while line <= row2 do

            if line == row1 and line == row2 then
                col_start = col1
                col_end = col2
            elseif line == row1 then
                col_start = col1
                col_end = -1
            elseif line == row2 then
                col_start = 0
                col_end = col2
            else
                col_start = 0
                col_end = 0
            end

            vim.api.nvim_buf_add_highlight(buf, -1, highlight_group, line, col_start, col_end)
            line = line + 1
        end
    end
end

local function get_tree_runner(highlight)

    local function run_tree(node)
        highlight(node)

        local children = node:child_count()
        if children == 0 then return end

        local i = 0
        while i < children do
            run_tree(node:child(i))
            i = i + 1
        end
    end

    return run_tree
end

local function colorize_buffer(parser, run_tree)
    local tree = parser:parse()
    local root = tree:root()
    run_tree(root)
end

local function set_timeout(timeout, callback)
  local timer = luv.new_timer()
  timer:start(timeout, 0, function ()
    timer:stop()
    timer:close()
    callback()
  end)
  return timer
end

local TIMEOUT = 50

local function get_update_highlight(parser, run_tree)
    local running = false

    return function(_, buf)
        if running then return end

        running = true
        local tree = parser:parse()
        local root = tree:root()

        local timer = set_timeout(TIMEOUT, vim.schedule_wrap(function()
            vim.api.nvim_buf_clear_namespace(buf, -1, 0, -1)
            run_tree(root)
            running = false
        end))
    end
end

local function init_ts_parser(buf, attributes)
    local parser = vim.treesitter.get_parser(buf, attributes.parser_lang)

    local highlighter = get_highlighter(buf, attributes.definitions, attributes.color_lang)
    local run_tree = get_tree_runner(highlighter)

    colorize_buffer(parser, run_tree)

    return get_update_highlight(parser, run_tree)
end

return { init_ts_parser = init_ts_parser }
