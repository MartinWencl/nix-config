
{ config, pkgs, userSettings, ... }:
let
  myAliases = {
    ls = "eza --group-directories-first --icons";
    la = "eza --group-directories-first -la --icons";
    s = "eza --group-directories-first --icons";
    gl = "git log --all --decorate --graph";
    gs = "git status --show-stash";
    gss = "git status --show-stash -s";
    n = "nvim";
    ns = "eza --oneline --only-files | fzf --reverse --preview \"bat {}\" | xargs -r nvim";
    cat = "bat --color=auto";
    find = "fd --color=auto";
    grep = "rg --color=auto";

    # TODO: Move to gaming module
    faf = "steam-run ~/source/faf-linux/run";
  };

  dotfilesDir = builtins.replaceStrings ["~"] ["$HOME"] userSettings.dotfilesDir;

  updateScript = pkgs.writeShellScriptBin "update" ''
    set -euo pipefail

    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[0;33m'
    NC='\033[0m'

    DOTFILES_DIR="${dotfilesDir}"

    if [ ! -d "$DOTFILES_DIR" ]; then
      echo -e "''${RED}Error: $DOTFILES_DIR does not exist''${NC}"
      exit 1
    fi

    cd "$DOTFILES_DIR"

    if grep -qi microsoft /proc/version 2>/dev/null; then
      HM_CONFIG="${userSettings.username}@work-wsl"
    else
      HM_CONFIG="${userSettings.username}@desktop"
    fi

    echo -e "''${YELLOW}Switching home-manager config: $HM_CONFIG''${NC}"

    if home-manager switch --flake "$DOTFILES_DIR#$HM_CONFIG"; then
      drvpath=$(home-manager generations | head -n1 | grep -oP "/nix/store/[a-z0-9]+-home-manager-generation" || true)
      drvhash=$(echo "$drvpath" | grep -oP "[a-z0-9]+" | head -n1 || true)

      if git diff --quiet && git diff --cached --quiet && [ -z "$(git ls-files --others --exclude-standard)" ]; then
        echo -e "''${YELLOW}No changes to commit''${NC}"
      else
        git add .
        git commit -m "home-manager: update to derivation ''${drvhash:0:7}"
        echo -e "''${GREEN}Successfully updated and committed home-manager changes''${NC}"
      fi
    else
      echo -e "''${RED}home-manager update failed, no changes committed''${NC}"
      exit 1
    fi
  '';

  updateSystemScript = pkgs.writeShellScriptBin "update-system" ''
    set -euo pipefail

    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[0;33m'
    NC='\033[0m'

    DOTFILES_DIR="${dotfilesDir}"

    if [ ! -d "$DOTFILES_DIR" ]; then
      echo -e "''${RED}Error: $DOTFILES_DIR does not exist''${NC}"
      exit 1
    fi

    cd "$DOTFILES_DIR"

    echo -e "''${YELLOW}Rebuilding NixOS system configuration...''${NC}"

    if sudo nixos-rebuild switch --flake "$DOTFILES_DIR"; then
      system_profile=$(readlink -f /run/current-system)
      drvhash=$(echo "$system_profile" | grep -oP "[a-z0-9]+" | head -n1 || true)
      hn=$(hostname)

      if git diff --quiet && git diff --cached --quiet && [ -z "$(git ls-files --others --exclude-standard)" ]; then
        echo -e "''${YELLOW}No changes to commit''${NC}"
      else
        git add .
        git commit -m "nixos($hn): update to derivation ''${drvhash:0:7}"
        echo -e "''${GREEN}Successfully updated and committed NixOS changes''${NC}"
      fi
    else
      echo -e "''${RED}NixOS update failed, no changes committed''${NC}"
      exit 1
    fi
  '';

  updateFlakeScript = pkgs.writeShellScriptBin "update-flake" ''
    set -euo pipefail

    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[0;33m'
    NC='\033[0m'

    DOTFILES_DIR="${dotfilesDir}"

    if [ ! -d "$DOTFILES_DIR" ]; then
      echo -e "''${RED}Error: $DOTFILES_DIR does not exist''${NC}"
      exit 1
    fi

    cd "$DOTFILES_DIR"

    echo -e "''${YELLOW}Updating flake inputs...''${NC}"

    if nix flake update; then
      hash=$(grep -A1 "lastModified" flake.lock | grep "narHash" | grep -oP 'sha256-[A-Za-z0-9+/=]+' | xargs || true)

      if git diff --quiet flake.lock 2>/dev/null; then
        echo -e "''${YELLOW}No changes to commit''${NC}"
      else
        git add flake.lock
        git commit -m "flake: update inputs to $hash"
        echo -e "''${GREEN}Successfully updated and committed flake lock file''${NC}"
      fi
    else
      echo -e "''${RED}Flake update failed, no changes committed''${NC}"
      exit 1
    fi
  '';
in
{
  programs.zsh = {
    enable = true;
    shellAliases = myAliases;
  };

  programs.bash = {
    enable = true;
    shellAliases = myAliases;
  };

  home.packages = [
    updateScript
    updateSystemScript
    updateFlakeScript
  ];
}
