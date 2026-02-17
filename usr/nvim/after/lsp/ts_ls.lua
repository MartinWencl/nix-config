local bin = vim.fn.exepath('vue-language-server')
if bin == '' then
    return {}
end

local resolved = vim.fn.resolve(bin)
local store_path = resolved:match('(.+)/bin/vue%-language%-server$')
if not store_path then
    return {}
end

return {
    filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'vue' },
    init_options = {
        plugins = {
            {
                name = '@vue/typescript-plugin',
                location = store_path .. '/lib/language-tools/packages/typescript-plugin',
                languages = { 'vue' },
            },
        },
    },
}
