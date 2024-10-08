{ config, pkgs, lib, ... }:

{
  home.shellAliases = lib.mkAfter {
    c = "cd /mnt/c/";
    v = "cd /mnt/c/vyvoj/";
    d = "cd /mnt/c/vyvoj/Vyvoj - Developer/";
  };
}
