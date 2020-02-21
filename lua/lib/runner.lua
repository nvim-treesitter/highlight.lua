local function get_process_node(buf, definitions, color_lang)
    return function(node)
        local node_type = node:type()
        local row1, col1, row2, col2 = node:range()

        local highlight_group = nil

        local highlight_group = definitions[node_type]
        if highlight_group == nil then
            print(node_type)
            return
        elseif highlight_group == 'skip' then
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

local function get_tree_runner(process_node)
    local function run_tree(node)
        process_node(node)
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

local function update(parser, run_tree)
    return function()
        local tree = parser:parse()
        local root = tree:root()
        run_tree(root)
    end
end

local function create_process(buf, attributes)
    local parser = vim.treesitter.get_parser(buf, attributes.parser_lang)
    local process_node = get_process_node(buf, attributes.definitions, attributes.color_lang)
    local run_tree = get_tree_runner(process_node)
    return update(parser, run_tree)     
end

local function attach_to_buffer(buf, attributes)
    local update = create_process(buf, attributes)
    update()
    -- vim.api.nvim_buf_attach(buf, update)
end

return {
    attach_to_buffer = attach_to_buffer
}
