{
  description = "";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      systemSettings = rec {
        system = "x86_64-linux";
        hostname = "nixos";
        profile = "personal";
        timezone = "Europe/Prague";
        defaultLocale = "en_US.UTF-8";

        extraLocaleSettings = {
          LC_ADDRESS = "cs_CZ.UTF-8";
          LC_IDENTIFICATION = "cs_CZ.UTF-8";
          LC_MEASUREMENT = "cs_CZ.UTF-8";
          LC_MONETARY = "cs_CZ.UTF-8";
          LC_NAME = "cs_CZ.UTF-8";
          LC_NUMERIC = "cs_CZ.UTF-8";
          LC_PAPER = "cs_CZ.UTF-8";
          LC_TELEPHONE = "cs_CZ.UTF-8";
          LC_TIME = "cs_CZ.UTF-8";
        };
      };

      userSettings = rec {
        username = "martinw";
        name = "Martin Wencl";
        email = "marta.wencl@gmail.com";
        dotfilesDir = "~/.dotfiles";
        browser = "qutebrowser";
        term = "kitty";
        font = "JetBrainsMono"; # Nerd font expected
        nerdFont = font + " Nerd Font";
        editor = "nvim";
      };

      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${systemSettings.system};

    in {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          system = systemSettings.system;
          modules = [./profiles/home/configuration.nix];

          specialArgs = {
            inherit userSettings;
            inherit systemSettings;
          };
        };
      };

      homeConfigurations = {
        martinw = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [./profiles/home/home.nix];

          extraSpecialArgs = {
            inherit userSettings;
          };
        }; 
    };
  };  
}
