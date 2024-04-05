# User information for Sootpaws

{ ... }: {
    imports = [ ../core/primaryUser.nix ];

    primaryUser = {
        systemName = "sootpaws";
        displayName = "Sootpaws";
        email = "sootpaws@proton.me";
    };
}
