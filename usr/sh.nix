
{ config, pkgs, ... }:
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

    # update = "home-manager switch --flake ~/.dotfiles";
    # update-system = "sudo nixos-rebuild switch --flake ~/.dotfiles";
    # update-flake = "nix flake update --commit-lock-file";

    update = ''
    cd ~/.dotfiles && \
    if home-manager switch --flake ~/.dotfiles; then
      drvpath=$(home-manager generations | head -n1 | grep -oP "/nix/store/[a-z0-9]+-home-manager-generation" || echo "")
      drvhash=$(echo "$drvpath" | grep -oP "[a-z0-9]+" | head -n1)
      git add . && \
      git commit -m "home-manager: update to derivation ${drvhash:0:7}" && \
      echo "Successfully updated and committed home-manager changes"
    else
      echo "home-manager update failed, no changes committed"
      exit 1
    fi
  '';

  update-system = ''
    cd ~/.dotfiles && \
    if sudo nixos-rebuild switch --flake ~/.dotfiles; then
      system_profile=$(readlink -f /run/current-system)
      drvhash=$(echo "$system_profile" | grep -oP "[a-z0-9]+" | head -n1)
      hostname=$(hostname)
      git add . && \
      git commit -m "nixos($hostname): update to derivation ${drvhash:0:7}" && \
      echo "Successfully updated and committed NixOS changes"
    else
      echo "NixOS update failed, no changes committed"
      exit 1
    fi
  '';

  update-flake = ''
    cd ~/.dotfiles && \
    if nix flake update; then
      hash=$(grep -A1 "lastModified" flake.lock | grep "narHash" | grep -oP 'sha256-[A-Za-z0-9+/=]+')
      git add flake.lock && \
      git commit -m "flake: update inputs to $hash" && \
      echo "Successfully updated and committed flake lock file"
    else
      echo "Flake update failed, no changes committed"
      exit 1
    fi
  '';
  };
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
}
