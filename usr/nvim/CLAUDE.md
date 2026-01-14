# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a modern Neovim configuration using lazy.nvim as the plugin manager, configured entirely in Lua. The setup prioritizes LSP integration, AI assistance, and development workflow efficiency.

## Architecture

### Entry Point Flow
1. **init.lua**: Bootstraps lazy.nvim and loads core configuration
   - Loads `opts.lua` (options/settings)
   - Bootstraps lazy.nvim if not present
   - Imports plugins from `plugins/init_plugins.lua` and `plugins/` directory
   - Loads `keymaps.lua` (base keymaps)
   - Loads custom files from `custom/`

### Directory Structure
- **lua/opts.lua**: Neovim options (leader key, line numbers, clipboard, etc.)
- **lua/keymaps.lua**: Base keybindings not related to specific plugins
- **lua/plugins/**: Plugin specifications (lazy.nvim format)
  - **init_plugins.lua**: Core plugin list
  - Individual files for complex plugin configs (telescope.lua, lspconfig.lua, etc.)
- **lua/custom/**: User-specific customizations
- **lua/lib/**: Utility functions (currently unused)
- **lazy-lock.json**: Lock file for plugin versions
- **queries/**: Custom treesitter queries
- **spell/**: Spell check dictionaries

### Plugin Management
- Uses lazy.nvim with `plugins.import = "plugins"` for auto-loading
- Plugins can be defined in `plugins/init_plugins.lua` or as separate files in `plugins/`
- Lock file (`lazy-lock.json`) tracks exact versions

## Language Server Protocol (LSP)

### Configuration Approach (Modern)
The config uses Neovim's new native LSP configuration via `vim.lsp.config()` and `vim.lsp.enable()`:
- **lspconfig.lua**: Central LSP setup
- Capabilities provided by blink.cmp for completion
- Global config applied to all servers via `vim.lsp.config('*', {...})`
- Servers enabled via `vim.lsp.enable({...})` array

### Enabled LSP Servers
- **gopls**: Go
- **rust_analyzer**: Rust
- **ts_ls**: TypeScript/JavaScript
- **clangd**: C/C++
- **csharp_ls**: C#
- **html**: HTML
- **lua_ls**: Lua
- **teal_ls**: Teal
- **marksman**: Markdown
- **pyright**: Python (via nvim.nix)
- **nil**: Nix (via nvim.nix)

Note: LSP tools are installed via Nix (see nvim.nix), NOT via Mason for most servers.

### LSP Keybindings (Set on LspAttach)
- `<leader>rn`: Rename symbol
- `<F3>`: Code action
- `gd`: Go to definition (Telescope)
- `gr`: Find references (Telescope)
- `gI`: Go to implementation (Telescope)
- `gD`: Go to declaration
- `K`: Hover documentation
- `<C-k>`: Signature help
- `<leader>D`: Type definition
- `<leader>ds`: Document symbols (Telescope)
- `<leader>ws`: Workspace symbols (Telescope)

## Completion System

### Blink.cmp
- Modern completion engine replacing nvim-cmp
- Version pinned: v0.7.6
- Keymap preset: "enter" (Enter to accept)
- Uses blink.compat for nvim-cmp compatibility

### Completion Sources
- LSP
- Path
- Snippets (friendly-snippets)
- Buffer
- CodeCompanion (AI)
- Obsidian (markdown-specific: notes, new notes, tags)

## Key Plugins

### Core Functionality
- **lazy.nvim**: Plugin manager
- **nvim-lspconfig**: LSP configuration
- **blink.cmp**: Completion engine
- **telescope.nvim**: Fuzzy finder (files, LSP, grep, etc.)
- **nvim-treesitter**: Syntax highlighting and text objects
- **which-key.nvim**: Keymap help

### Git Integration
- **vim-fugitive**: Git commands
- **vim-rhubarb**: GitHub integration
- **gitsigns.nvim**: Git signs in gutter, hunk operations

### UI/Visual
- **catppuccin**: Colorscheme
- **lualine.nvim**: Statusline (uses catppuccin theme)
- **indent-blankline.nvim**: Indentation guides
- **fidget.nvim**: LSP progress notifications

### Editor Enhancement
- **vim-sleuth**: Auto-detect tabstop/shiftwidth
- **Comment.nvim**: Easy commenting
- **nvim-autopairs**: Auto-close brackets
- **mini.nvim**: Various mini plugins
- **oil.nvim**: File explorer

### Development Tools
- **nvim-dap**: Debug Adapter Protocol
  - Debug adapters: delve (Go), netcoredbg (C#)
  - **nvim-dap-ui**: Debug UI
  - **nvim-dap-go**: Go debugging
  - Uses Mason for debug adapter installation
- **none-ls.nvim**: Null-ls replacement for formatters/linters

### AI/Productivity
- **gp.nvim**: ChatGPT integration
  - API key from `~/.dotfiles/secret.txt`
  - Agent: ChatGPT4o
  - Custom hook: UnitTests
  - Keybinds: `<leader>ar` (rewrite), `<leader>arb` (rewrite buffer)
- **codecompanion.nvim**: AI coding assistant
- **obsidian.nvim**: Obsidian vault integration
- **neorg**: Note-taking and organization

### Language-Specific
- **teal**: Teal language support

### Tmux Integration
- Tmux navigation plugin (seamless pane switching)

## Essential Keybindings

### Leader Key
- `<Space>`: Leader and local leader

### Navigation
- `j`/`k`: Move by visual lines (not file lines)
- `[d`/`]d`: Previous/next diagnostic
- `[c`/`]c`: Previous/next git hunk
- `[m`/`]m`: Previous/next function (treesitter)
- `[[`/`]]`: Previous/next class (treesitter)

### Window Management
- `<M-j>`/`<M-k>`: Resize height
- `<M-h>`/`<M-l>`: Resize width

### Diagnostics
- `<leader>e`: Open floating diagnostic
- `<leader>q`: Open diagnostics list
- `<leader>i`: Open floating diagnostic at cursor

### Execution
- `<leader>x`: Execute current line as Lua
- `<leader><leader>x`: Source current file

### Terminal
- `<Esc>`: Exit terminal mode (instead of `<C-\><C-n>`)

### Git (Gitsigns)
- `<leader>hs`: Stage hunk
- `<leader>hr`: Reset hunk
- `<leader>hS`: Stage buffer
- `<leader>hR`: Reset buffer
- `<leader>hp`: Preview hunk
- `<leader>hb`: Blame line
- `<leader>hd`: Diff against index
- `<leader>tb`: Toggle blame line
- `ih`: Select git hunk (text object)

### Treesitter Text Objects
- `aa`/`ia`: Around/inside parameter
- `af`/`if`: Around/inside function
- `ac`/`ic`: Around/inside class
- `<leader>a`/`<leader>A`: Swap parameter with next/previous

### Telescope (see telescope.lua for full list)
Common patterns use `<leader>s` prefix (search)

## Important Configuration Details

### Options (opts.lua)
- Leader: Space
- Line numbers: Relative + absolute
- Scrolloff: 999 (cursor always centered)
- No line wrap
- Clipboard: System integrated
- Spell check: Enabled (en_us, cs)
- Split behavior: Below and right
- List chars: Custom EOL character (󰌑)

### Home-Manager Integration (nvim.nix)
- Config directory symlinked via `home.file.".config/nvim".source`
- LSP servers/tools installed as packages (not via Mason)
- Neovim aliases: `vi` and `vim` point to `nvim`
- Conditional ROCm ollama package based on `userSettings.enableROCm`

## Extending the Configuration

### Adding a New Plugin
1. Create file in `lua/plugins/plugin-name.lua` OR add to `init_plugins.lua`
2. Return lazy.nvim spec:
   ```lua
   return {
       "author/plugin-name",
       dependencies = {...},
       config = function()
           -- setup code
       end,
   }
   ```
3. Restart Neovim (lazy.nvim auto-loads from plugins/ directory)

### Adding a New LSP Server
1. Add language server package to nvim.nix
2. Add server name to `vim.lsp.enable({...})` array in lspconfig.lua
3. Run `update` from shell to apply home-manager changes

### Adding Custom Keymaps
- Plugin-agnostic: Add to `keymaps.lua`
- Plugin-specific: Add in plugin's config function
- LSP-specific: Add in LspAttach autocmd in lspconfig.lua

### Adding Custom Options
- Add to `opts.lua` using `vim.opt.*` or `vim.o.*`

## Debugging

### DAP Configuration
- UI opens automatically on debug start
- Keybindings set in debug.lua
- Adapters installed via Mason (delve, netcoredbg)
- Language-specific: nvim-dap-go provides Go debugging

### Treesitter
- Parsers installed: c, cpp, go, lua, python, rust, tsx, javascript, typescript, vimdoc, vim, bash
- Auto-install: Disabled (manual control)
- Incremental selection: `<C-Space>` to expand, `<M-Space>` to shrink

## Known Issues/TODOs

From code comments:
- init.lua: "TODO: Split into separate files" (plugins)
- opts.lua: "TODO: set shada"
- init_plugins.lua: Gitsigns keybinds don't work currently (line 128)
- custom/lualine_codecompaion.lua: Currently not loaded (commented in init.lua)

## AI Integration Notes

### gp.nvim
- Requires secret.txt in dotfiles root with OpenAI API key
- Custom hook: UnitTests - generates table-driven tests
- Primary use: Code rewriting with GPT-4o

### codecompanion.nvim
- Integrated into blink.cmp completion sources
- Appears in completion menu with high priority (score_offset: 100)
