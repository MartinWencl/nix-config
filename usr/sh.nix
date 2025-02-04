
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

    update = "home-manager switch --flake ~/.dotfiles";
    update-system = "sudo nixos-rebuild switch --flake ~/.dotfiles";
    update-flake = "nix flake update --commit-lock-file";
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
