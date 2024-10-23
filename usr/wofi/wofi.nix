{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    wofi
  ];

  home.file.".config/wofi".source = ./.;
  home.file.".config/wofi".recursive = true;
}
