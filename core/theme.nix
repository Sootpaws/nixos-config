# Interface for theme management

{ lib, ... }: {
    imports = [];

    options.theme = {
        wallpaper = lib.mkOption { type = lib.types.path; };

        font = lib.mkOption { type = lib.types.str; };

        colors = {
            primary = {
                extra = lib.mkOption { type = lib.types.str; };
                strong = lib.mkOption { type = lib.types.str; };
                medium = lib.mkOption { type = lib.types.str; };
                weak = lib.mkOption { type = lib.types.str; };
            };
            secondary = {
                extra = lib.mkOption { type = lib.types.str; };
                strong = lib.mkOption { type = lib.types.str; };
                medium = lib.mkOption { type = lib.types.str; };
                weak = lib.mkOption { type = lib.types.str; };
            };
            accent = {
                extra = lib.mkOption { type = lib.types.str; };
                strong = lib.mkOption { type = lib.types.str; };
                medium = lib.mkOption { type = lib.types.str; };
                weak = lib.mkOption { type = lib.types.str; };
            };
        };
    };
}
