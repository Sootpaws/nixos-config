# Configuration for mpd and ncmpcpp

{ pkgs, ... }: {
    programs.ncmpcpp = {
        enable = true;
    };

    home.packages = [ pkgs.mpc ];

    services.mpd = {
        enable = true;
    };

    services.mpdris2 = {
        enable = true;
    };
}
