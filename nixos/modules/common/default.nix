# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
    imports =
        [ # Include the results of the hardware scan.
            ./bluetooth.nix
            ./keyboard
            ./neovim.nix
            ./nix.nix
            ./sound.nix
            ./users.nix
            ./xorg.nix
            ./zsh.nix
        ];

    networking = {
        firewall.enable = true;
        networkmanager.enable = true;
    };

    time.timeZone = "Europe/Paris";

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

    fonts.fonts = with pkgs; [
        (nerdfonts.override { fonts = [ "DejaVuSansMono" ]; })
    ];

    services = {
        # update grub ?
        fwupd.enable = true;

        # unlocks ssh keys when unlocking session
        gnome.gnome-keyring.enable = true;

        #enables udiskie services
        udisks2.enable = true;
    };


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
        xclip
        wget
        git
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

