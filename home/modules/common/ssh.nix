{
    programs.ssh = {
        enable = true;

        matchBlocks = {
            ########
            # Mage #
            ########
            mage = {
                user = "antoine";
                hostname = "nixos.g2elab.grenoble-inp.fr";
            };

            ###########
            # Desktop #
            ###########
            desktop = {
                user = "antoine";
                hostname = "glepage.com";
                port = 224;
            };

            ##########
            # GriCAD #
            ##########
            "*.ciment" = {
                user = "marteaua";
                serverAliveInterval = 30;
                proxyCommand = "ssh -q marteaua@access-gricad.univ-grenoble-alpes.fr 'nc -w 60 `basename %h .ciment` %p'";
            };
        };
    };

    home.shellAliases = {
        mage  = "ssh -t mage";
        dahu  = "ssh -t dahu.ciment  .nix-profile/bin/zsh-5.8";
        cargo = "ssh -t cargo.ciment .nix-profile/bin/zsh-5.8";
    };
}
