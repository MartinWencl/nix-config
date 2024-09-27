{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    alacritty
  ];
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    window.opacity = lib.mkForce 0.93;
    font.normal.family = "JetBrainsMono Nerd Font";
    font.normal.style = "Regular";
  };
}
