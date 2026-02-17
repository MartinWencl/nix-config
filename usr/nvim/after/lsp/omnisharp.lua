return {
    cmd = { "OmniSharp" },
    root_dir = function(fname)
        local util = require('lspconfig.util')

        -- First, try to find a .sln file by searching upward
        local sln_root = util.root_pattern('*.sln')(fname)
        if sln_root then
            return sln_root
        end

        -- If no .sln found, check if we're in a monorepo structure
        -- Search upward for .git, then look for .sln in immediate subdirectories
        local git_root = util.root_pattern('.git')(fname)
        if git_root then
            -- Check direct subdirectories for .sln files (one level only)
            local sln_files = vim.fn.glob(git_root .. '/*/*.sln', false, true)
            if #sln_files > 0 then
                -- Return the parent directory (git root) as the workspace root
                return git_root
            end
        end

        -- Fall back to .csproj as project root
        return util.root_pattern('*.csproj')(fname) or git_root
    end,
}
