{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    waybar
    dunst
    hyprcursor
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  home.file.".config/hypr".source = ./.;
  home.file.".config/hypr".recursive = true;

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "waybar"
      "hyprpaper"
      "hypridle"
      "dunst"
    ];
    
    source = "~/.config/hypr/mocha.conf";

    monitor="DP-1,2560x1440@60,0x0,1";

    "$mod" = "SUPER";

    bind = [
      "$mod, Q, exec, qutebrowser"
      "$mod, R, exec, wofi --show drun"
      "$mod, Return, exec, kitty"
      "super_shift, Q, exit,"
      "$mod, C, killactive,"
      "$mod, F, fullscreen"
      "$mod, Space, togglefloating"

      "$mod, Left, movefocus, l # [hidden]"
      "$mod, Right, movefocus, r # [hidden]"
      "$mod, Up, movefocus, u # [hidden]"
      "$mod, Down, movefocus, d # [hidden]"

      "$mod, BracketLeft, movefocus, l # [hidden]"
      "$mod, BracketRight, movefocus, r # [hidden]"

      # Scroll through existing workspaces with mod + scroll
      "$mod, mouse_down, workspace, e+1"
      "$mod, mouse_up, workspace, e-1"

      "$mod CTRL, left, movewindow, l"
      "$mod CTRL, right, movewindow, r"
      "$mod CTRL, up, movewindow, u"
      "$mod CTRL, down, movewindow, d"

      "$mod SHIFT, left, resizeactive,-50 0"
      "$mod SHIFT, right, resizeactive,50 0"
      "$mod SHIFT, up, resizeactive,0 -50"
      "$mod SHIFT, down, resizeactive,0 50"
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

    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];


    input = {
      kb_layout = "us,cz";
      kb_variant = ",ucw";
      kb_options = "grp:switch,caps:swapescape";
    };

    env = "HYPRCURSOR_THEME,BreezeX-RosePine-Linux";
  };
}
