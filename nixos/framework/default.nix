{ config, pkgs, ... }:
{
    imports = [
        ../modules/bootloader.nix
        ../modules/common
        ../modules/steam.nix

        ./hardware.nix
    ];

    services = {
      # display settings:
      # To trigger autorandr during lock/unlock and sleep/out of sleep?
      udev.extraRules = ''ACTION=="change", SUBSYSTEM=="drm", RUN+="${pkgs.autorandr}/bin/autorandr -c"'';

      autorandr = {
        enable = true;
        defaultTarget = "laptop";
        matchEdid = true;
        profiles = {
          "laptop" = {
            fingerprint = { # EDID from $ xrandr --prop
              eDP-1   = "00ffffffffffff0009e55f0900000000171d0104a51c137803de50a3544c99260f505400000001010101010101010101010101010101115cd01881e02d50302036001dbe1000001aa749d01881e02d50302036001dbe1000001a000000fe00424f452043510a202020202020000000fe004e4531333546424d2d4e34310a00fb";
            };
            config.eDP-1 = {
                enable = true;
                primary = true;
                position = "0x0";
                mode = "1920x1200";
                rate = "60.00";
                crtc = 0;
                gamma = "1.0:0.833:0.714";
            };
          };
          "home" = {
            fingerprint = { # EDID from $ xrandr --prop
              eDP-1   = "00ffffffffffff0009e55f0900000000171d0104a51c137803de50a3544c99260f505400000001010101010101010101010101010101115cd01881e02d50302036001dbe1000001aa749d01881e02d50302036001dbe1000001a000000fe00424f452043510a202020202020000000fe004e4531333546424d2d4e34310a00fb";
              DP-3-3 = "00ffffffffffff004c2d860c374c5a5a211c0103803420782a01f1a257529f270a505423080081c0810081809500a9c0b300d1c00101283c80a070b023403020360006442100001a000000fd00383c1e5111000a202020202020000000fc00533234453635300a2020202020000000ff0048345a4b3830303333320a2020018302010400023a80d072382d40102c458006442100001e011d007251d01e206e28550006442100001e011d00bc52d01e20b828554006442100001e8c0ad090204031200c4055000644210000188c0ad08a20e02d10103e9600064421000018000000000000000000000000000000000000000000000000000000000000000000d2";
            };
            config = {
              eDP-1.enable = false;
              DP-3-3 = {
                enable = true;
                primary = true;
                position = "0x0";
                mode = "1920x1200";
                rate = "60.00";
                crtc = 0;
                gamma = "1.0:0.833:0.714";
              };
            };
          };
        };
      };
    };

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

