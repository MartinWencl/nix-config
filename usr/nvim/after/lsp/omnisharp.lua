local util = require('lspconfig.util')

-- Only override root_dir; rest merges from nvim-lspconfig base config
return {
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        vim.notify('omnisharp root_dir: fname=' .. fname, vim.log.levels.DEBUG)

        local sln_root = util.root_pattern('*.sln', '*.slnx')(fname)
        if sln_root then
            vim.notify('omnisharp root_dir: sln_root=' .. sln_root, vim.log.levels.DEBUG)
            return on_dir(sln_root)
        end

        local git_root = util.root_pattern('.git')(fname)
        vim.notify('omnisharp root_dir: git_root=' .. tostring(git_root), vim.log.levels.DEBUG)
        if git_root then
            local sln_files = vim.fn.glob(git_root .. '/*/*.sln', false, true)
            vim.notify('omnisharp root_dir: sln_files=' .. #sln_files, vim.log.levels.DEBUG)
            if #sln_files > 0 then
                return on_dir(git_root)
            end
        end

        local fallback = util.root_pattern('*.csproj', 'omnisharp.json', 'function.json')(fname) or git_root
        vim.notify('omnisharp root_dir: fallback=' .. tostring(fallback), vim.log.levels.DEBUG)
        on_dir(fallback)
    end,
}
