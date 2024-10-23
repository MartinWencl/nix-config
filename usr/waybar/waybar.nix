{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    waybar
  ];

  home.file.".config/waybar".source = ./.;
  home.file.".config/waybar".recursive = true;
}
