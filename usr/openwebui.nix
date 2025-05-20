{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    open-webui
  ];

  services.open-webui.enable = true;
}
