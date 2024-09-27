{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    zoxide
  ];

  programs.zoxide.enable = true;
  programs.zoxide.enableBashIntegration= true;
  programs.zoxide.enableZshIntegration= true;
}

