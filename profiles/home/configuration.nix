# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, systemSettings, userSettings, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;

  # virtualisation.libvirt.enable = true;
  # virtualisation.libvirtd.enable = true;
  # virtualisation.libvirt.swtpm.enable = true;  # Software TPM for Windows 11
  # 
  # virtualisation.libvirt.pools.default.volumes.windowsDisk = {
  #   source = null;
  #   name = "windows11.qcow2";
  #   capacity = 50 * 1024 * 1024 * 1024;  # 100 GiB in bytes
  #   allocation = 10 * 1024 * 1024 * 1024;
  #   format = "qcow2";
  # };
  #
  # virtualisation.libvirt.connections."qemu:///system".domains = [
  #   {
  #     definition = (import <path-to-nixvirt-lib-domain-nixos-or-flake> {}).lib.domain.writeXML (
  #       (import <path-to-nixvirt-lib-domain-nixos-or-flake> {}).lib.domain.templates.windows {
  #         name = "Windows11VM";
  #         uuid = "4c90ac4c-9282-4833-b1a4-2df2f9c460b0";
  #         memory = { count = 8; unit = "GiB"; };
  #         storage_vol = { pool = "default"; volume = "windows11.qcow2"; };
  #         install_vol = "/path/to/windows11.iso";
  #         bridge_name = "virbr0"; # or your bridge interface
  #         virtio_net = true;
  #         virtio_video = true;
  #         virtio_drive = true;
  #       }
  #     ));
  #     active = true;
  #   }
  # ];

  environment.shells = with pkgs; [ bash zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  networking.hostName = systemSettings.hostname; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  #TODO: Move into a separate bluetooth module
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

  services.open-webui = {
    enable = true;
    environment = {
      ANONYMIZED_TELEMETRY = "False";
      DO_NOT_TRACK = "True";
      SCARF_NO_ANALYTICS = "True";
      OLLAMA_API_BASE_URL = "http://127.0.0.1:11434/api";
      OLLAMA_BASE_URL = "http://127.0.0.1:11434";
      WEBUI_AUTH = "False";
    };
  };

  # Set your time zone.
  time.timeZone = systemSettings.timezone;

  # Select internationalisation properties.
  i18n.defaultLocale = systemSettings.defaultLocale;
  i18n.extraLocaleSettings = systemSettings.extraLocaleSettings;

  fonts.packages = with pkgs; [
    # (nerdfonts.override { fonts = [userSettings.font]; })
    nerd-fonts.${userSettings.font}
  ];

  # RGB
  services.hardware.openrgb.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # enable WMs
  services.xserver.windowManager.awesome.enable = true;

  programs.hyprland.enable = true;
  # programs.hyprland.package = inputs.hyprland.package."${pkgs.system}".hyrpland;

  # Enable the sddm display manager
  services.displayManager.sddm.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb = {
  #   layout = "us";
  #   variant = "";
  # };
  
  # virtualization.docker = {
  #   enable = true;
  # };

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["martinw"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  # ollama
  services.ollama = {
    package = pkgs.ollama-rocm;
    enable = true;
    environmentVariables = {
      HCC_AMDGPU_TARGET = "gfx1101"; # used to be necessary, but doesn't seem to anymore
    };
    rocmOverrideGfx = "11.0.1";
    acceleration = "rocm";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = [
    pkgs.neovim
    pkgs.wget
    pkgs.git
    pkgs.zip
    pkgs.unzip
    pkgs.curl
    # pkgs.docker
  ];

  #TODO: Move into a separate "gaming" section, so it can be separated out of a work profile
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers

    package = pkgs.steam.override { 
      extraPkgs = pkgs: [
        pkgs.jq
        pkgs.cabextract
        pkgs.wget
        pkgs.git
        pkgs.pkgsi686Linux.libpulseaudio
        pkgs.pkgsi686Linux.freetype
        pkgs.pkgsi686Linux.xorg.libXcursor
        pkgs.pkgsi686Linux.xorg.libXcomposite
        pkgs.pkgsi686Linux.xorg.libXi
      ];
    };
  };
  
  #TODO: needed for prismlauncher, make into nix-shell
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [
    pkgs.libcef 
    pkgs.mesa
    pkgs.libGL
    pkgs.wayland

    # needed for btop
    pkgs.rocmPackages.rocm-smi
  ];
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "24.05"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
