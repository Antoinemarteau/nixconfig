{ config, pkgs, ... }:
{
    imports = [
        ../modules/bootloader.nix
        ../modules/common

        ./hardware.nix
    ];

    networking.hostName = "monash";

    services = {
      # display settings:
      # To trigger autorandr during lock/unlock and sleep/out of sleep?
      udev.extraRules = ''ACTION=="change", SUBSYSTEM=="drm", RUN+="${pkgs.autorandr}/bin/autorandr -c"'';

      autorandr = {
        enable = true;
        matchEdid = true;
        profiles = {
          "default" = {
            fingerprint = {
              eDP1   = "00ffffffffffff0006af9af900000000141f0104a51e13780363f5a854489d240e505400000001010101010101010101010101010101fa3c80b870b0244010103e002dbc1000001ac83080b870b0244010103e002dbc1000001a000000fe004a38335646804231343055414e0000000000024101b2001100000a410a20200068";
            };
            config.eDP1 = {
                enable = true;
                primary = true;
                position = "0x0";
                mode = "1920x1200";
                rate = "60.00";
                crtc = 0;
                gamma = "1.0:0.833:0.714";
            };
          };
          "math_office" = {
            fingerprint = {
              eDP1   = "00ffffffffffff0006af9af900000000141f0104a51e13780363f5a854489d240e505400000001010101010101010101010101010101fa3c80b870b0244010103e002dbc1000001ac83080b870b0244010103e002dbc1000001a000000fe004a38335646804231343055414e0000000000024101b2001100000a410a20200068";
              DP-4-1 = "00ffffffffffff00220e0539010101011f210104a5351e783a5625ab534f9d25105054a54b00d1c0b300a9c095008180810081c00101023a801871382d40582c45000f282100001e000000fd00324b1e5612010a202020202020000000fc004850204532342047350a202020000000ff00434e4b333331313059510a2020014f020311b149909f04131211030201e200ea2a4480a070382740302035000f282100001a023a801871382d40582c45000f282100001e023a80d072382d40102c45800f282100001e011d007251d01e206e2855000f282100001e011d00bc52d01e20b82855400f282100001e000000000000000000000000000000000000000069";
              DP-4-2 = "00ffffffffffff00220e0539010101011f210104a5351e783a5625ab534f9d25105054a54b00d1c0b300a9c095008180810081c00101023a801871382d40582c45000f282100001e000000fd00324b1e5612010a202020202020000000fc004850204532342047350a202020000000ff00434e4b333331313059570a20200149020311b149909f04131211030201e200ea2a4480a070382740302035000f282100001a023a801871382d40582c45000f282100001e023a80d072382d40102c45800f282100001e011d007251d01e206e2855000f282100001e011d00bc52d01e20b82855400f282100001e000000000000000000000000000000000000000069";
            };
            config = {
              eDP1.enable = false;
              DP-4-1 = {
                enable = true;
                primary = false;
                position = "0x0";
                mode = "1920x1080";
                rate = "60.00";
                crtc = 2;
                gamma = "1.0:0.833:0.714";
              };
              DP-4-2 = {
                enable = true;
                primary = true;
                position = "1920x0";
                mode = "1920x1080";
                rate = "60.00";
                crtc = 0;
                gamma = "1.0:0.833:0.714";
              };
            };
          };
        };
      };
    };

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.05"; # Did you read the comment?

}

