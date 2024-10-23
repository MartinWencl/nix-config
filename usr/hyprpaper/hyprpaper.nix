{ config, pkgs, inputs, lib, ... }:

{
  home.packages = with pkgs; [
    hyprpaper
  ];

  home.file.".config/backgrounds".source = ./backgrounds;
  home.file.".config/backgrounds".recursive = true;

  home.file.".config/hypr/hyprpaper.conf".source = lib.mkDefault ./hyprpaper.conf;
}
