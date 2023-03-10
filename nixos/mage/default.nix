{ config, pkgs, ... }:
{
    imports = [
        ../modules/bootloader.nix
        ../modules/common
        ../modules/ssh.nix
        ../modules/nvidia.nix

        ./hardware.nix
    ];

    hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_470;

    networking.hostName = "mage";

    services.xserver.serverFlagsSection = ''
          Option "BlankTime" "0"
          Option "StandbyTime" "0"
          Option "SuspendTime" "0"
          Option "OffTime" "0"
        '';

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "22.11"; # Did you read the comment?

    # xrdp setup
    services.xrdp.enable = true;
    services.xrdp.defaultWindowManager = "i3";
    networking.firewall.allowedTCPPorts = [ 3389 ];
}

