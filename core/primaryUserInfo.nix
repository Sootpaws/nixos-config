# Interface for information on the "primary user"

{ lib, ... }: {
    imports = [];

    options.primaryUserInfo = {
        systemName = lib.mkOption { type = lib.types.str; };
        displayName = lib.mkOption { type = lib.types.str; };
        email = lib.mkOption { type = lib.types.str; };
        sshKeys = lib.mkOption { type = lib.types.listOf lib.types.str; };
    };
}
