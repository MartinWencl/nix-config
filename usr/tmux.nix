{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    tmux
  ];

  programs.tmux = {
    enable = true;
    prefix = "C-Space";
    baseIndex = 1;
    keyMode = "vi";

    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.sensible
      tmuxPlugins.catppuccin
    ];

    extraConfig = ''
    set-option -g renumber-windows on

    bind-key r command-prompt -I "rename-window %%"
    bind-key k confirm-before -p "kill session? (y/n)" kill-session

    bind C-c run "tmux save-buffer - | xclip -i -sel clip"
    bind C-v run "tmux set-buffer $(xclip -o -sel clip); tmux paste-buffer"

    # change selection mode keybinds
    bind-key -T copy-mode-vi v send-keys -X begin-selection
    bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
    bind-key -T copy-mode-vi C-v send-keys -X copy-selection-and-cance

    bind '"' split-window -v -c "#{pane_current_path}"
    bind '%' split-window -h -c "#{pane_current_path}"
    '';
  }; 
}
