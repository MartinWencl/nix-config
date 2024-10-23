{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    kitty
  ];

  home.file.".config/kitty".source = ./.;
  home.file.".config/kitty".recursive = true;
}
