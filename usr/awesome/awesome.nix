{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    awesome
  ];

  home.file.".config/awesome".source = ./.;
  home.file.".config/awesome".recursive = true;
}
