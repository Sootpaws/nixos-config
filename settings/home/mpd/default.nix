{ pkgs, config, ... }: let
    enable = config.services.mpd.enable;
in {
    programs.ncmpcpp.enable = enable;
    services.mpdris2.enable = enable;
    home.packages = if enable then [ pkgs.mpc ] else [];
}
