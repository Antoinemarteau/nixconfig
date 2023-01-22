{ config, pkgs, ... }:
{
    imports = [
        ../modules/bootloader.nix
        ../modules/common
        ../modules/steam.nix

        ./hardware.nix
    ];

    # framework is gen 12 proc, needs recent kernel
    boot.kernelPackages = pkgs.linuxPackages_6_1;

    networking.hostName = "framework";

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "22.11"; # Did you read the comment?

}

