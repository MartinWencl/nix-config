local function get_vue_plugin_path()
    local handle = io.popen('realpath $(which vue-language-server) 2>/dev/null')
    if not handle then return nil end
    local bin_path = handle:read('*l')
    handle:close()
    if not bin_path then return nil end
    -- bin is at <store-path>/bin/vue-language-server
    -- plugin is at <store-path>/lib/language-tools/packages/typescript-plugin
    local store_path = bin_path:match('(.+)/bin/vue%-language%-server$')
    if store_path then
        return store_path .. '/lib/language-tools/packages/typescript-plugin'
    end
end

local vue_plugin_path = get_vue_plugin_path()

if not vue_plugin_path then
    return {}
end

return {
    init_options = {
        plugins = {
            {
                name = '@vue/typescript-plugin',
                location = vue_plugin_path,
                languages = { 'vue' },
            },
        },
    },
}
