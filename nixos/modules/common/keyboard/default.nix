{
    services.xserver = {
        xkbOptions = "caps:swapescape";
        layout = "bepo_antoine";
        extraLayouts.bepo_antoine = {
            description = "bepo antoine";
            languages = [ "fr" ];
            symbolsFile = ./layout.xkb;
        };
    };

    console.useXkbConfig = true;
}
