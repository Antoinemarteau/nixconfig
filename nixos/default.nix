# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
        ./bluetooth.nix
        ./framework-hardware.nix
        ./keyboard
        ./neovim.nix
        ./nix.nix
        ./sound.nix
        ./steam.nix
        ./users.nix
        ./zsh.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "framework"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    #keyMap = "fr";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  services = {
      fwupd.enable = true;

      gnome.gnome-keyring.enable = true;

      # Enable the X11 windowing system.
      xserver = {
          enable = true;
          displayManager.lightdm.enable = true;
          #desktopManager.gnome.enable = true;
          windowManager.i3 = {
              enable = true;
              package = pkgs.i3-gaps;
          };
      };
  };


  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    btop
    fd
    htop
    nfs-utils
    ncdu
    ripgrep
    wget

    firefox
    git
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs = {
      gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };

      singularity.enable = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}

