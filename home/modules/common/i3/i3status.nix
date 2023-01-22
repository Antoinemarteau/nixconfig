{
    programs.i3status-rust = {
        enable = true;

        bars.default = {
            theme = "gruvbox-dark";
            icons = "material-nf";

            blocks = [
                {
                    alert = 10.0;
                    alias = "/";
                    block = "disk_space";
                    info_type = "available";
                    interval = 60;
                    path = "/";
                    unit = "GB";
                    warning = 20.0;
                }
                {
                    block = "memory";
                    display_type = "memory";
                    format_mem = "{mem_used_percents}";
                    format_swap = "{swap_used_percents}";
                }
                {
                    block = "cpu";
                    interval = 1;
                }
                {
                    block = "load";
                    format = "{1m}";
                    interval = 1;
                }
                {
                    block = "sound";
                }
                {
                    block = "time";
                    format = "%a %d/%m %R";
                    interval = 60;
                }
                {
                    block = "battery";
                }
            ];
        };

    };
}
