{ config, lib, ... }:
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
             (lib.mkIf ( config.home.sessionVariables.HOSTNAME == "desktop" )
                {
                    alert = 10.0;
                    alias = "hdd";
                    block = "disk_space";
                    info_type = "available";
                    interval = 60;
                    path = "/mnt/hdd/";
                    unit = "GB";
                    warning = 20.0;
                }
             )
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
                    on_click = "pavucontrol --tab=3";
                }
                {
                    block = "time";
                    format = "%a %d/%m %R";
                    interval = 60;
                    on_click = "kitty --hold cal -y -w";
                }
            (lib.mkIf ( builtins.elem config.home.sessionVariables.HOSTNAME [ "framework" "vm" ] )
                {
                    block = "battery";
                }
            )

            ];
        };

    };
}
