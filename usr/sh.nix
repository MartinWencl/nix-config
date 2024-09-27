
{ config, pkgs, ... }:
let
  myAliases = {
    ls = "eza --group-directories-first --icons";
    la = "eza --group-directories-f.irst -la --icons";
    s = "eza --group-directories-first --icons";
    gl = "git log --all --decorate --graph";
    n = "nvim";
    ns = "eza --oneline --only-files | fzf --reverse --preview \"bat {}\" | xargs -r nvim";
    cat = "bat --color=auto";
    find = "fd --color=auto";
    grep = "rg --color=auto";
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
