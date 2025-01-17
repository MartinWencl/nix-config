{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    openrgb
  ];

  # create a systemd service to run at startup 
  systemd.user.services.start-openrgb = {
    Unit = {
      Description = "Autostart openrgb";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = lib.getExe pkgs.openrgb;
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
