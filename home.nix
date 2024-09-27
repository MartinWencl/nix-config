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
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
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

  # The home.packages option allows you to install Nix packages into your
  # environment.
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
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

  };

  home.sessionVariables = {
     EDITOR = "nvim";
     TERM = "alacritty";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
