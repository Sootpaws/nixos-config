# User information for Sootpaws

{ ... }: {
    imports = [ ../core/primaryUserInfo.nix ];

    primaryUserInfo = {
        systemName = "sootpaws";
        displayName = "Sootpaws";
        email = "sootpaws@proton.me";
    };
}
