{ config, pkgs, ... }:
{
    imports = [
        ./i3status.nix
    ];

    home.packages = with pkgs; [
        python3
    ];

    xsession.windowManager.i3 = {
        enable = true;

        config = {
            assigns = {
                "2" = [{class = "irefox$"; }];
                "4" = [{class = "FLTK"; }];
                "5" = [{class = "Signal"; }];
                "6" = [{class = "Zotero"; }];
                "7" = [{class = "^evince$"; }];
            };

            bars = [
                {statusCommand =  "./mybar.sh";}
            ];

            defaultWorkspace = "workspace number 1";

            floating.criteria = [
                { class = "firefox"; title = "Library"; }
            ];

            #fonts = {name = }; TODO font pango:monospace 8

            gaps = {
                inner = 3;
                outer = 0;
                smartBorders = "on";
                smartGaps = true;
            };

            keybindings = let
                mod = config.xsession.windowManager.i3.config.modifier;
                term = config.xsession.windowManager.i3.config.terminal;
                refresh_i3status = "killall -SIGUSR1 i3status";
            in {
                "${mod}+o" = "exec i3lock";
                "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5%      && ${refresh_i3status}";
                "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5%      && ${refresh_i3status}";
                "XF86AudioMute"        = "exec --no-startup-id pactl set-sink-mute   @DEFAULT_SINK@   toggle && ${refresh_i3status}";
                "XF86AudioMicMute"     = "exec --no-startup-id pactl set-sink-mute   @DEFAULT_SOURCE@ toggle && ${refresh_i3status}";

                "${mod}+Return" = "exec ${term}";
                "${mod}+a" = "kill";

                "${mod}+c" = "focus left ";
                "${mod}+t" = "focus down ";
                "${mod}+s" = "focus up   ";
                "${mod}+r" = "focus right";
                "${mod}+space" = "focus mode_toggle";

                "${mod}+Shift+c" = "move left ";
                "${mod}+Shift+t" = "move down ";
                "${mod}+Shift+s" = "move up   ";
                "${mod}+Shift+r" = "move right";
                "${mod}+b"       = "workspace back_and_forth";
                "${mod}+Shift+b" = "move container to workspace back_and_forth; workspace back_and_forth";

                "${mod}+g" = "split h"; # split in horizontal orientation
                "${mod}+v" = "split v"; # split in vertical orientation
                "${mod}+f" = "fullscreen toggle";
                "${mod}+Shift+space" = "floating toggle";

                "${mod}+k" = "layout stacking    ";
                "${mod}+z" = "layout tabbed      ";
                "${mod}+e" = "layout toggle split";

                "${mod}+d" = "exec --no-startup-id rofi -show run";
                "${mod}+Shift+l" = "reload";
                "${mod}+Shift+h" = "restart";
                "${mod}+Shift+e" = "exec i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'";
                "Print" = "exec --no-startup-id flameshot gui";
                "${mod}+Insert" = "exec --no-startup-id scrot -e 'mv $f ~/Pictures/'";

                "${mod}+quotedbl      " = "workspace number 1";
                "${mod}+guillemotleft " = "workspace number 2";
                "${mod}+guillemotright" = "workspace number 3";
                "${mod}+numbersign    " = "workspace number 4";
                "${mod}+dead_greek    " = "workspace number 5";
                "${mod}+copyright     " = "workspace number 6";
                "${mod}+plus          " = "workspace number 7";
                "${mod}+minus         " = "workspace number 8";
                "${mod}+at            " = "workspace number 9";
                "${mod}+equal         " = "workspace number 10";

                "${mod}+Shift+quotedbl      " = "move container to workspace number 1";
                "${mod}+Shift+guillemotleft " = "move container to workspace number 2";
                "${mod}+Shift+guillemotright" = "move container to workspace number 3";
                "${mod}+Shift+numbersign    " = "move container to workspace number 4";
                "${mod}+Shift+dead_greek    " = "move container to workspace number 5";
                "${mod}+Shift+copyright     " = "move container to workspace number 6";
                "${mod}+Shift+plus          " = "move container to workspace number 7";
                "${mod}+Shift+minus         " = "move container to workspace number 8";
                "${mod}+Shift+at            " = "move container to workspace number 9";
                "${mod}+Shift+equal         " = "move container to workspace number 10";

                "${mod}+h" = "mode resize";
            };

            modes.resize = {
                c = "resize shrink width 10 px or 10 ppt ";
                t = "resize grow height 10 px or 10 ppt  ";
                s = "resize shrink height 10 px or 10 ppt";
                r = "resize grow width 10 px or 10 ppt   ";

                Return = "mode default";
                Escape = "mode default";
                "${config.xsession.windowManager.i3.config.modifier}+h" = "mode default";
            };

            modifier = "Mod4";

            startup = [
                { command = "dunst"; }
                { command = "picom"; }
                { command = "nitrogen --restore"; }
                { command = "kitty"; }
                { command = "pa-applet"; }
                { command = "signal-desktop"; }
                { command = "firefox"; }
                { command = "nextcloud"; }
                { command = "zotero"; }
                { command = "redshift -P -O 4500"; }
                { command = "VBoxClient-All"; }
                { command = "nm-applet"; }
            ];

            terminal = "kitty";

            window = {
                commands = [ {
                    command = "focus";
                    criteria = { class = "firefox"; urgent = "latest"; };
                } ];
                hideEdgeBorders = "smart";
            };

            workspaceAutoBackAndForth = false;
        };
    };

    xdg.configFile.barScript = {
        source = ./mybar.sh;
        target = "i3status/mybar.sh"; # targets ~/.config/i3status/mybar.sh
        executable = true;
    };

    xdg.configFile.bar_click_time = {
        source = ./click_time.sh;
        target = "i3status/click_time.sh";
        executable = true;
    };

    xdg.configFile.bar_click_vpn = {
        source = ./click_vpn.sh;
        target = "i3status/click_vpn.sh";
        executable = true;
    };

    xdg.configFile.bar_cpu = {
        source = ./cpu.py;
        target = "i3status/cpu.py";
        executable = true;
    };

    xdg.configFile.bar_disk = {
        source = ./disk.py;
        target = "i3status/disk.py";
        executable = true;
    };

    xdg.configFile.bar_ip = {
        source = ./ip.py;
        target = "i3status/ip.py";
        executable = true;
    };

    xdg.configFile.bar_memory = {
        source = ./memory.py;
        target = "i3status/memory.py";
        executable = true;
    };

    xdg.configFile.bar_meteo = {
        source = ./meteo.py;
        target = "i3status/meteo.py";
        executable = true;
    };
}
