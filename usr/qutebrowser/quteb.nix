{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    qutebrowser
  ];

  home.file.".config/qutebrowser".source = ./.;
  home.file.".config/qutebrowser".recursive = true;

  # error with read only file system
  # home.file.".local/share/qutebrowser/greasemonkey".source = ./greasemonkey;
}
