local function get_typescript_lib()
    local bin = vim.fn.exepath('tsc')
    if bin == '' then return nil end
    local resolved = vim.fn.resolve(bin)
    local store_path = resolved:match('(.+)/bin/tsc$')
    if store_path then
        return store_path .. '/lib/node_modules/typescript/lib'
    end
end

return {
    init_options = {
        vue = {
            hybridMode = false,
        },
        typescript = {
            tsdk = get_typescript_lib(),
        },
    },
}
