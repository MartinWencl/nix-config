{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    neovim
    neovim-remote
    neovide

    ollama-rocm

    clang
    clang-tools
    clang-analyzer
    pyright
    lua-language-server
    stylua
    nil
    marksman

  #   universal-ctags
  #   (pkgs.buildGoModule {
  #     pname = "ctags-lsp";
  #     version = "0.6.0";
  #     src = fetchgit {
  #       url = "git@github.com:netmute/ctags-lsp.git";
  #     };
  #     vendorHash = null;
  #   })
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
