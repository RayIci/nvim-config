local M = {}

function M.print_table(table)
    vim.print(vim.inspect(table))
end

function M.concat_lists(...)
    local result = {}
    for _, list in ipairs({ ... }) do
        for _, item in ipairs(list) do
            table.insert(result, item)
        end
    end

    return result
end

function M.concat_tables(t1, t2)
    local result = {}
    for _, v in ipairs(t1) do
        table.insert(result, v)
    end
    for _, v in ipairs(t2) do
        table.insert(result, v)
    end

    return result
end

return M
