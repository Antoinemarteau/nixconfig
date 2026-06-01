{ pkgs, config, inputs, ... }:
{
    # sources:
    # - https://github.com/vimjoyer/sops-nix-video
    # - https://www.youtube.com/watch?v=G5f6GC7SnhU (VimJoyer video "")
    # - https://github.com/Mic92/sops-nix
    #
    # Main steps:
    # - create a age key (see ./sops.yaml) into sops.age.keyFile
    # - add secrets using `$ nsp sops; sops ./secrets.yaml
    # - manage secrets below in sops.secrets
    # - create services that get permission to use secrets

    sops = {
      defaultSopsFile = ./secrets.yaml;
      defaultSopsFormat = "yaml";

      age.keyFile = "/home/antoine/.config/sops/age/keys.txt";
      #age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt"; # isn't available in nixos :/

      secrets = {
        # actual fields in the SopsFile
        example_key = {
          owner = config.users.users.antoine.name; # on top of sudo
          # optional per secret overrides
          # format = "yaml";
          # sopsFile = ./secrets.yaml;
          # # permission digits  "flag|owner/user|group|others", bits: read(4)+write(2)+execute(1)
          # mode = "0440";
          # path = "/var/lib/hass/secrets.yaml"; # to symlink the secret there
        };
        "myservice/my_subdir/my_secret" = {
                owner = "sometestservice";
        };
      };
    };

    systemd.services."sometestservice" = {
      script = ''
          echo "
          Hey bro! I'm a service, and imma send this secure password:
          $(cat ${config.sops.secrets."myservice/my_subdir/my_secret".path})
          located in:
          ${config.sops.secrets."myservice/my_subdir/my_secret".path}
          to database and hack the mainframe
          " > /var/lib/sometestservice/testfile
        '';
      serviceConfig = {
        User = "sometestservice";
        WorkingDirectory = "/var/lib/sometestservice";
      };
    };

    users.users.sometestservice = {
      home = "/var/lib/sometestservice";
      createHome = true;
      isSystemUser = true;
      group = "sometestservice";
    };
    users.groups.sometestservice = { };
}
