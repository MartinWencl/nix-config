{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    awesome
    lua
  ];

  home.file.".config/awesomewm".source = ./.;
  home.file.".config/awesomewm".recursive = true;
}
