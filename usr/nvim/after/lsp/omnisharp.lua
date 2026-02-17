local util = require('lspconfig.util')

-- Only override root_dir; rest merges from nvim-lspconfig base config
return {
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)

        -- First, try to find a .sln file by searching upward
        local sln_root = util.root_pattern('*.sln', '*.slnx')(fname)
        if sln_root then
            return on_dir(sln_root)
        end

        -- If no .sln found, check if we're in a monorepo structure
        -- Search upward for .git, then look for .sln in immediate subdirectories
        local git_root = util.root_pattern('.git')(fname)
        if git_root then
            local sln_files = vim.fn.glob(git_root .. '/*/*.sln', false, true)
            if #sln_files > 0 then
                return on_dir(git_root)
            end
        end

        -- Fall back to .csproj as project root
        on_dir(util.root_pattern('*.csproj', 'omnisharp.json', 'function.json')(fname) or git_root)
    end,
}
