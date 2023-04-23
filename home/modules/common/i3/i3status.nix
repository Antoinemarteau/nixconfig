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
                    format = "$icon / $available";
                    block = "disk_space";
                    info_type = "available";
                    interval = 60;
                    path = "/";
                    warning = 20.0;
                }
             (lib.mkIf ( config.home.sessionVariables.HOSTNAME == "desktop" )
                {
                    alert = 10.0;
                    format = "$icon hdd $available";
                    block = "disk_space";
                    info_type = "available";
                    interval = 60;
                    path = "/mnt/hdd/";
                    warning = 20.0;
                }
             )
                {
                    block = "memory";
                    format = " $icon $mem_total_used_percents.eng(w:2) ";
                    format_alt = " $icon_swap $swap_used_percents.eng(w:2) ";
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
                    click = [{
                      button = "left";
                      cmd = "pavucontrol --tab=3";
                    }];
                }
                {
                    block = "time";
                    format = " $timestamp.datetime(f:'%a %d/%m %R') ";
                    interval = 10;
                    click = [{
                      button = "left";
                      cmd = "kitty --hold cal -y -w";
                    }];
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
