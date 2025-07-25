# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
    imports =
        [ # Include the results of the hardware scan.
            ./autofs.nix
            ./bluetooth.nix
            ./firefox.nix
            ./keyboard
            ./neovim.nix
            ./nix.nix
            ./singularity.nix
            ./sound.nix
            ./users.nix
            ./xorg.nix
            ./zsh.nix
        ];

    networking = {
        firewall.enable = true;
        networkmanager.enable = true;
    };

    #time.timeZone = "Europe/Paris";
    time.timeZone = "Australia/Melbourne";

    # Select internationalisation properties.
    i18n = {
        defaultLocale = "en_US.UTF-8";     # langue generale du PC
        extraLocaleSettings = {
            LC_TIME    = "fr_FR.UTF-8";    # format date / heure
        };
    };

    console = {
        font = "Lat2-Terminus16";
        useXkbConfig = true; # use xkbOptions in tty.
    };

    fonts.packages = with pkgs; [
      nerd-fonts.dejavu-sans-mono
    ];
    fonts.fontDir.enable = true;

    services = {
        # update grub ?
        fwupd.enable = true;

        # unlocks ssh keys when unlocking session
        gnome.gnome-keyring.enable = true;

        #enables udiskie services
        udisks2.enable = true;

        # mounting phone android storage
        gvfs.enable = true;

        # Enable touchpad support (enabled default in most desktopManager).
        libinput.enable = true;
    };


    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        btop
        fd
        htop
        nfs-utils
        ncdu
        ripgrep
        xclip
        wget
        git
        unzip
    ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    programs = {
        # Some programs need SUID wrappers, can be configured further or are started in user sessions.
        dconf.enable = true;
        # needed to use gtk

        gnupg.agent = {
          enable = true;
          enableSSHSupport = true;
        };
    };

}

