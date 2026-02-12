{ pkgs, ... }: {
    # TODO: Use the HM module and figure out how to make keepassxc not complain
    # about having a write-only config file
    home.packages = [ pkgs.keepassxc ];

    # This needs to get run through a shell to get the right env vars
    wayland.windowManager.sway.customConfig.openKeybinds.k =
        "nu --login --commands keepassxc";
}
