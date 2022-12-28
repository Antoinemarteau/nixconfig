{
    programs.i3status = {
        enable = true;

        general = {
            colors = true;
            color_good = "#e0e0e0";
            color_degraded = "#d7ae00";
            color_bad = "#f69d6a";
            interval = 1;
        };

        modules = {
            "volume master" = {
                position = 1;
                settings = {
                    format = "♪ %volume";
                    format_muted = "♪ muted (%volume)";
                    device = "pulse:1";
                };
            };
            "disk /" = {
                position = 2;
                settings = {
                    format = "/ %avail";
                };
            };
        };
    };
}
