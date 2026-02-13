{ config, pkgs, userSettings, ... }:

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
      };
    };
  };
}
