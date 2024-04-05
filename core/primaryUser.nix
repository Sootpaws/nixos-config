# Interface for information on the "primary user"

{ lib, ... }: {
    imports = [];

    options.primaryUser = {
        systemName = lib.mkOption { type = lib.types.str; };
        displayName = lib.mkOption { type = lib.types.str; };
        email = lib.mkOption { type = lib.types.str; };
    };
}
