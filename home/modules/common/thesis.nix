{ config, pkgs, ... }:
{
    home = {
        packages = with pkgs; [
            gmsh
            mpi
        ];

        sessionPath = [ "$HOME/.local/bin" ]; #add it to system path
        file = {
            sgetdp = {
                executable = true;
                text = ''
                    #!/bin/sh

                    # Absolute path to container
                    CONTAINER=$HOME/prog/these/gricad/singularity_container.sif

                    CONT_SOURCE_DIR=/home/working_dir/
                    singularity exec \
                        --bind $PWD:$CONT_SOURCE_DIR \
                        --home $CONT_SOURCE_DIR \
                        $CONTAINER \
                        getdp $@
                '';

                target = ".local/bin/sgetdp";
            };
        };
    };
}
