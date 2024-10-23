{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    waybar
    dunst
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # currently theming is in a sep file
  home.file.".config/hypr".source = ./.;
  home.file.".config/hypr".recursive = true;

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "waybar"
      "hyprpaper"
      "dunst"
    ];
    
    # import theming
    source = "~/.config/hypr/mocha.conf";

    # Keybinds
    "$mod" = "SUPER";

    bind = [
      "$mod, Q, exec, qutebrowser"
      "$mod, R, exec, wofi --show drun"
      "$mod, Return, exec, kitty"
      "super_shift, Q, exit,"
      "$mod, C, killactive,"

      "$mod, mouse_down, workspace, e+1"
      "$mod, mouse_up, workspace, e-1"

      # Move/resize windows with mainMod + LMB/RMB and dragging
      # "$mod, mouse:272, movewindow"
      # "$mod, mouse:273, resizewindow"
      # "ALT, mouse:272, resizewindow"

      ]
      ++ (
        # workspaces
        # s $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          9)
      );

    input = {
      follow_mouse = 1;
    };

    # "$color0" = "rgba(1d192bee)"
    # "$color1" = "rgba(465EA7ee)"
    # "$color2" = "rgba(5A89B6ee)"
    # "$color3" = "rgba(6296CAee)"
    # "$color4" = "rgba(73B3D4ee)"
    # "$color5" = "rgba(7BC7DDee)"
    # "$color6" = "rgba(9CB4E3ee)"
    # "$color7" = "rgba(c3dde7ee)"
    # "$color8" = "rgba(889aa1ee)"
    # "$color9" = "rgba(465EA7ee)"
    # "$color10" = "rgba(5A89B6ee)"
    # "$color11" = "rgba(6296CAee)"
    # "$color12" = "rgba(73B3D4ee)"
    # "$color13" = "rgba(7BC7DDee)"
    # "$color14" = "rgba(9CB4E3ee)"
    # "$color15" = "rgba(c3dde7ee)"

  };
}
