{ config, pkgs, inputs, lib, ... }:

{
  home.packages = with pkgs; [
    hypridle
  ];

  home.file.".config/hypr/hypridle.conf".source = lib.mkDefault ./hypridle.conf;
}
