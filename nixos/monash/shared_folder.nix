{ pkgs, ... }:
{
    #https://nixos.wiki/wiki/Samba
    environment.systemPackages = [ pkgs.cifs-utils ];
    fileSystems."/mnt/monash_sdrive_home" = {
      device = "//ad.monash.edu/home";
      fsType = "cifs";
      options = let
        # this line prevents hanging on network split
        # added "uid=1000,gid=100" in the string to get read and write access
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,uid=1000";

      in ["${automount_opts},credentials=/etc/nixos/smb-secrets"];
    };
    fileSystems."/mnt/monash_sdrive_shared" = {
      device = "//ad.monash.edu/shared";
      fsType = "cifs";
      options = let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

      in ["${automount_opts},credentials=/etc/nixos/smb-secrets"];
    };
    networking.firewall.extraCommands = ''iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns'';
}
