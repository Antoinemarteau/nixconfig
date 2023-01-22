{ config, pkgs, ... }:
{
    imports = [
        ./i3status.nix
    ];

    home.packages = with pkgs; [
        python3
    ];

    xdg.dataFile.wallpaper.source = ./wallpaper.jpeg;

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
                {
                    statusCommand =  "i3status-rs ~/.config/i3status-rust/config-default.toml";
                    fonts = {
                        names = [ "DejaVu Sans Mono" ];
                        size = 16.;
                    };
                    position = "bottom";
                }
            ];

            defaultWorkspace = "workspace number 1";

            floating.criteria = [
                { class = "firefox"; title = "Library"; }
                { class = "blueman-manager-wrapped"; }
            ];

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

                "${mod}+percent"  = "exec setxkbmap fr oss && dunstify 'loaded azerty layout'";
                "${mod}+parenright" = "exec setxkbmap bepo_antoine && dunstify 'loaded bepo layout'";

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
                { command = "nitrogen --restore"; }
                { command = "kitty"; }
                { command = "pa-applet"; }
                { command = "signal-desktop"; }
                { command = "firefox"; }
                { command = "nextcloud"; }
                { command = "zotero"; }
                { command = "${pkgs.redshift}/bin/redshift -P -O 4500"; }
                { command = "VBoxClient-All"; }
                { command = "${pkgs.feh}/bin/feh --bg-fill ${config.xdg.dataFile.wallpaper.target}"; }
            ];

            terminal = "kitty";

            window = {
                commands = [
                    {
                        command = "focus";
                        criteria = { class = "firefox"; urgent = "latest"; };
                    }
                    {
                        command = "fullscreen enable";
                        criteria = { class = "Civ5XP"; };
                    }
                    {
                        command = "move to workspace 8";
                        criteria = { class = "potify"; };
                    }
                ];
                hideEdgeBorders = "smart";
            };

            workspaceAutoBackAndForth = false;
        };
    };
}