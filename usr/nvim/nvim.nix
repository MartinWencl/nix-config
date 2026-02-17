{ config, pkgs, lib, userSettings, ... }:

{
  home.packages = with pkgs; [
    neovim
    neovim-remote

    clang
    clang-tools
    clang-analyzer
    pyright
    lua-language-server
    stylua
    nil
    marksman
    rustup
    gopls
    typescript
    nodePackages.typescript-language-server
    vue-language-server
    vscode-langservers-extracted
    omnisharp-roslyn

  #   universal-ctags
  #   (pkgs.buildGoModule {
  #     pname = "ctags-lsp";
  #     version = "0.6.0";
  #     src = fetchgit {
  #       url = "git@github.com:netmute/ctags-lsp.git";
  #     };
  #     vendorHash = null;
  #   })
  ] ++ lib.optionals (!(userSettings.headless or false)) [
    neovide
  ] ++ lib.optionals (userSettings.enableROCm or false) [
  ];
  programs.neovim = {
    viAlias = true;
    vimAlias = true;
  };
  home.file.".config/nvim".source = ./.;
  home.file.".config/nvim".recursive = true;

  home.sessionVariables = {
    LUA_PATH="$LUA_PATH:~/.local/share/nvim";
  };
}
