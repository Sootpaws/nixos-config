# Configuration for cool-retro-term

{ pkgs, ... }: {
    home.packages = with pkgs; [ cool-retro-term ];

    xdg.configFile.coolRetroTermTheme = {
        source = ./theme.json;
        target = "cool-retro-term/profile.json";
    };
}
