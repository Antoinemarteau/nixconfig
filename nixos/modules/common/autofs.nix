{ pkgs, config, ... }:
{
    environment.systemPackages = [ pkgs.sshfs ];
    # in mage desktop
    # change ssh config for mage:user is now 'antoine' (not marteaua)

    services.autofs = {
        enable = true;

        #======================================================================
        # auto mount gricad folder
        #
        # dont forget to copy the rsa_sshfs key to .ssh, or put a new one on
        # gricad (trinity, rotule, dahu)
        #
        # the first time the folder is used :
        # sudo ssh -o IdentityFile=/home/antoine/.ssh/rsa_sshfs,ProxyCommand="ssh -i /home/antoine/.ssh/rsa_sshfs -q marteaua@access-gricad.univ-grenoble-alpes.fr nc -w 60 cargo 22" marteaua@cargo:/bettik/marteaua
        #======================================================================
        autoMaster = let
            uid = toString config.users.users.antoine.uid;
            gid = toString config.users.groups.antoine.gid;

            #########
            # SSHFS #
            #########

            pathToRsaKey = "/home/antoine/.ssh/rsa_sshfs";
            sshfsOptions = "-fstype=fuse.sshfs,rw,allow_other,IdentityFile=${pathToRsaKey}";
            mapConf = pkgs.writeText "autofs.mnt" ''
                mage_desktop \
                    ${sshfsOptions} \
                    :antoine@nixos.g2elab.grenoble-inp.fr\:/home/antoine/
            '';

            gricadProxyCommand = "ssh -i ${pathToRsaKey} -q marteaua@access-gricad.univ-grenoble-alpes.fr nc -w 60 cargo 22";

            gricadMapConf = pkgs.writeText "autofs.mnt.sshfs" ''
                marteaua \
                    ${sshfsOptions},ProxyCommand="${gricadProxyCommand}" \
                    :marteaua@cargo\:/bettik/marteaua
                projet \
                    ${sshfsOptions},ProxyCommand="${gricadProxyCommand}" \
                    :marteaua@cargo\:/bettik/PROJECTS/pr-multiscale_mor
                home \
                    ${sshfsOptions},ProxyCommand="${gricadProxyCommand}" \
                    :marteaua@cargo\:/home/marteaua
            '';

            autoMasterSshfsOptions = "uid=${uid},gid=${gid},--timeout=60,--ghost";

        in ''
            /mnt/gricad  ${gricadMapConf} ${autoMasterSshfsOptions}
        '';
            #/mnt         ${mapConf}       ${autoMasterSshfsOptions}
    };
}
