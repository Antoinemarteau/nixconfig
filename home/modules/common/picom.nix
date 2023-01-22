{
    services.picom = {
        enable = true;

        backend = "xr_glx_hybrid";

        extraArgs = [ "--legacy-backends" ];

        settings.blur = {
            method = "gaussian";
            size = 10;
            deviation = 10.0;
        };
    };
}
