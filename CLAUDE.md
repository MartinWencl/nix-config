# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a NixOS dotfiles repository using flakes and home-manager for declarative system and user configuration management. The configuration supports both graphical (home) and headless (work/WSL) environments.

## Core Architecture

### Flake Structure
- **flake.nix**: Main entry point defining system and home-manager configurations
- **systemSettings**: System-level config (hostname, timezone, locale)
- **userSettings**: User-specific settings (username, editor, terminal, GUI flags)
- **Profiles**: Different environment configurations (home, work)
- **Modules**: Per-application configurations in `usr/`

### Configuration Model
The flake uses two parallel configuration systems:
1. **nixosConfigurations**: System-level configs (profiles/*/configuration.nix)
2. **homeConfigurations**: User-level configs (profiles/*/home.nix)

Both receive `systemSettings` and `userSettings` via specialArgs/extraSpecialArgs.

### Headless vs GUI Mode
The `userSettings.headless` flag controls which modules are loaded:
- `headless = true`: Terminal-only tools (shell, nvim, tmux, etc.)
- `headless = false`: GUI applications (Hyprland, Awesome, Kitty, browsers, etc.)

This allows the same dotfiles to work on both bare-metal NixOS and WSL environments.

### Directory Organization
- **profiles/**: Environment-specific configurations
  - **home/**: Full desktop setup (configuration.nix + home.nix)
  - **work/**: WSL-specific settings (wsl-config.nix with Windows mount aliases)
- **usr/**: Per-application module files (nvim.nix, tmux.nix, etc.)
- **system/**: System-level modules (nordvpn.nix)

## Common Commands

### System Management
```bash
# Update home-manager and auto-commit
update

# Update NixOS system configuration and auto-commit
update-system

# Update flake inputs (nixpkgs, home-manager, etc.) and auto-commit
update-flake

# Manual operations (if aliases fail)
home-manager switch --flake ~/.dotfiles
sudo nixos-rebuild switch --flake ~/.dotfiles
nix flake update
```

Note: The `update*` aliases automatically commit changes with descriptive messages including derivation hashes.

### Development Tools
- **nvim**: Primary editor (custom Neovim config in usr/nvim/)
- **zsh**: Default shell with custom aliases
- **tmux**: Terminal multiplexer

### Key Aliases (from usr/sh.nix)
```bash
ls/s    → eza with icons
la      → eza -la with icons
n       → nvim
ns      → fzf-based file picker with bat preview into nvim
cat     → bat
find    → fd
grep    → rg
gl      → git log --all --decorate --graph
gs/gss  → git status variants
```

## Modifying Configuration

### Adding New Applications
1. Create module file in `usr/appname.nix` or `usr/appname/appname.nix`
2. Import in appropriate profile's home.nix
3. For GUI apps, add to the `lib.optionals (!userSettings.headless)` list
4. Run `update` to apply changes

### Profile-Specific Settings
- Home profile: Full desktop with Hyprland/Awesome, gaming tools, virtualization
- Work profile: Minimal with WSL aliases for Windows filesystem access

### System vs Home-Manager Scope
- **System (configuration.nix)**: Services, hardware, display managers, system packages
- **Home-Manager (home.nix)**: User apps, dotfiles, shell config, window managers

## Special Configurations

### Hardware-Specific Features
- **ROCm GPU**: Ollama configured for AMD GPU (rocm-rocm, gfx1101)
- **OpenRGB**: RGB lighting control enabled
- **Virtualization**: libvirtd + virt-manager for VMs

### Experimental Features
Both system and home configs enable:
- nix-command
- flakes

### Important Paths
- Dotfiles directory: `~/.dotfiles` (referenced in userSettings.dotfilesDir)
- Custom binaries: `~/.bin` (in sessionPath)
- Neovim config: `usr/nvim/` (includes Lua config, LSP, queries)
