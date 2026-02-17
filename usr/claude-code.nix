{ config, pkgs, userSettings, ... }:

let
  # Combine .NET 10 (needed by csharp-ls runtime) and .NET 8 SDK (needed by the project)
  combinedDotnet = pkgs.dotnetCorePackages.combinePackages [
    pkgs.dotnet-sdk_10
    pkgs.dotnet-sdk_8
  ];
in
{
  programs.claude-code = {
    enable = true;

    mcpServers = {
      mcp-nixos = {
        command = "${pkgs.mcp-nixos}/bin/mcp-nixos";
        args = [ "run" ];
      };
      lsp-csharp = {
        command = "${pkgs.mcp-language-server}/bin/mcp-language-server";
        args = [
          "--workspace" "/home/martinw/source/server"
          "--lsp" "${pkgs.csharp-ls}/bin/csharp-ls"
        ];
        env = {
          DOTNET_ROOT = "${combinedDotnet}/share/dotnet";
          PATH = "${combinedDotnet}/bin";
        };
      };
    };
  };
}
