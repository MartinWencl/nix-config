{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    starship
  ];

  programs.starship.enable = true;
  programs.starship.enableZshIntegration = true;
  programs.starship.enableBashIntegration = true;

  programs.starship.settings = {
    dotnet.format = "[$symbol(🎯 $tfm )]($style)";
  };
}
