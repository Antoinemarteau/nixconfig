{
    fileSystems."/mnt/common_with_host" = {
        device = "common_with_vm";
        fsType = "vboxsf";
        options = [ "rw" ];
    };
}
