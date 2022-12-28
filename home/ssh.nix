{
    programs.ssh = {
        enable = true;

        matchBlocks = {
            ########
            # Mage #
            ########
            mage = {
                user = "marteaua";
                hostname = "manjaro.g2elab.grenoble-inp.fr";
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
        dahu = "ssh -t dahu.ciment .nix-profile/bin/zsh-5.8";
    };
}
