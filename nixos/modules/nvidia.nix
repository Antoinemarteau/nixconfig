{
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.opengl.enable = true;

    # Set $LD_LIBRARY_PATH so that Julia can find OpenGL
    hardware.opengl.setLdLibraryPath = true;
}
