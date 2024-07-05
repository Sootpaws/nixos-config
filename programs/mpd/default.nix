# Configuration for mpd and ncmpcpp

{ ... }: {
    programs.ncmpcpp = {
        enable = true;
    };

    services.mpd = {
        enable = true;
    };
}
