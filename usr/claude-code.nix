{ config, pkgs, userSettings, ... }:

{
  home.packages = [
    pkgs.claude-code
    pkgs.mcp-nixos
  ];

  # TODO: Add Claude Code configuration here (MCP servers, settings, etc.)
}
