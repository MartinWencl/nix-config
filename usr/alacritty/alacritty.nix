{ pkgs, lib, userSettings, ... }:

{
  home.packages = with pkgs; [
    alacritty
  ];
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    window.opacity = lib.mkForce 0.93;
    font.normal.family = userSettings.nerdFont;
    font.normal.style = "Regular";
  };
}
