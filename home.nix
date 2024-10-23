{ config, pkgs, ... }:

{
  imports = [
    ./usr/sh.nix
    ./usr/alacritty/alacritty.nix
    ./usr/starship.nix
    ./usr/nvim/nvim.nix
    ./usr/autin.nix
    ./usr/zoxide.nix
    ./usr/tmux.nix
    ./usr/rofi.nix
    ./usr/awesome/awesome.nix
    ./usr/hyprland/hypr.nix
    ./usr/waybar/waybar.nix
    ./usr/kitty/kitty.nix
    ./usr/wofi/wofi.nix
    ./usr/hyprpaper/hyprpaper.nix
    ./usr/qutebrowser/quteb.nix
  ];

  home.username = "martinw";
  home.homeDirectory = "/home/martinw";

  nixpkgs.config.allowUnfree = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    zsh
    eza
    bat
    ripgrep
    fd
    gcc
    nodejs
    vscode
    go
    alacritty
    rustup
    fzf
    yazi
    kitty
    waybar
    swww
    zathura
    xfce.thunar
  ];

  xsession.enable = true;
  # xsession.windowManager.command = "hyprland";
  xsession.windowManager.awesome.enable = true;
  

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  home.sessionVariables = {
     EDITOR = "nvim";
     TERM = "alacritty";
  };

  programs.home-manager.enable = true;
}
