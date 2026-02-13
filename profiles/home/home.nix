 { config, pkgs, lib, userSettings,... }:

{
  imports = [
    # terminal only
    ../../usr/sh.nix
    ../../usr/starship.nix
    ../../usr/nvim/nvim.nix
    ../../usr/autin.nix
    ../../usr/zoxide.nix
    ../../usr/tmux.nix
    ../../usr/claude-code.nix
  ] ++ lib.optionals (!userSettings.headless) [
    ../../usr/alacritty/alacritty.nix
    ../../usr/rofi.nix
    ../../usr/awesome/awesome.nix
    ../../usr/hyprland/hypr.nix
    ../../usr/waybar/waybar.nix
    ../../usr/kitty/kitty.nix
    ../../usr/wofi/wofi.nix
    ../../usr/hyprpaper/hyprpaper.nix
    ../../usr/hypridle/hypridle.nix
    ../../usr/qutebrowser/quteb.nix
    ../../usr/openrgb.nix
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
    # terminal only
    zsh
    eza
    bat
    ripgrep
    fd
    # gcc
    nodejs
    go
    rustup
    fzf
    yazi
    python3
    cmake
    tokei
    gojq
    btop
    jdk17
  ] ++ lib.optionals (!userSettings.headless) [
    vscode
    alacritty
    kitty
    swww
    zathura
    xfce.thunar
    # steam
    wl-clipboard
    firefox
    pwvucontrol
    discord
    lmstudio
    obsidian
    rqbit
    tofi
    open-webui

    remmina
    sstp
    networkmanager-sstp
    networkmanagerapplet

    spice
    spice-gtk
    win-spice

    #HACK:
    xclip

    #TODO: Move to "gaming" profile
    prismlauncher
  ];

  xsession.enable = !userSettings.headless;
  # xsession.windowManager.command = "hyprland";
  xsession.windowManager.awesome.enable = !userSettings.headless;

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  home.sessionVariables = {
     EDITOR = userSettings.editor;
     TERM = userSettings.term;
  };
  
  home.sessionPath = [
    "$HOME/.bin"
  ];

  # home.file.".bin/lofi".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/lofi/build/lofi";

  programs.home-manager.enable = true;
}
