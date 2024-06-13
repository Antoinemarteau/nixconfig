{ config, pkgs, ... }:
{
    imports = [
        ./i3status.nix
    ];

    home.packages = with pkgs; [
        python3
        xvkbd # for commands outputing text
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
                { class = "Spotify"; }
                { class = "blueman-manager-wrapped"; }
                { class = ".arandr-wrapped"; }
                { class = "Pavucontrol"; }
                { title = "Makie"; }
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
                laptop_output = pkgs.writeScript "laptop" ''
                #!/bin/sh
                xrandr --output eDP-1 --mode 1920x1200 --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off --output DP-3 --off --output DP-4 --off --output DP-5 --off --output DP-4-1 --off --output DP-4-2 --off --output DP-4-3 --off
            '';
            in {
                "${mod}+o" = "exec i3lock";
                "${mod}+Shift+o" = "exec i3lock && systemctl suspend";
                "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5%      && ${refresh_i3status}";
                "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5%      && ${refresh_i3status}";
                "XF86AudioMute"        = "exec --no-startup-id pactl set-sink-mute   @DEFAULT_SINK@   toggle && ${refresh_i3status}";
                "XF86AudioMicMute"     = "exec --no-startup-id pactl set-sink-mute   @DEFAULT_SOURCE@ toggle && ${refresh_i3status}";

                "${mod}+Return" = "exec ${term}";
                "${mod}+Shift+a" = "kill";

                "${mod}+l" = "exec --no-startup-id ${laptop_output}";

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

                "${mod}+f" = "fullscreen toggle";
                "${mod}+Shift+space" = "floating toggle";

                "${mod}+z" = "layout tabbed";
                "${mod}+e" = "layout toggle split";

                "${mod}+percent"    = "exec setxkbmap fr oss       && dunstify 'loaded azerty layout'";
                "${mod}+parenright" = "exec setxkbmap bepo_antoine && dunstify 'loaded bepo   layout'";

                "${mod}+d" = "exec --no-startup-id rofi -show run";
                "${mod}+Shift+l" = "reload";
                "${mod}+Shift+h" = "restart";
                "${mod}+Shift+q" = "exec i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'";
                "Print" = "exec --no-startup-id flameshot gui";
                "${mod}+Insert" = "exec --no-startup-id scrot -e 'mv $f ~/Pictures/'";

                "${mod}+Tab           " = "workspace number 1";
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

                "${mod}+Shift+Tab           " = "move container to workspace number 1";
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

                "${mod}+w" = "[class=\"ttrm\"] scratchpad show; move position center"; # floating terminal
                "${mod}+y" = "[class=\"btop\"] scratchpad show; move position center"; # floating task manager
                "${mod}+x" = "[class=\"Spotify\"] scratchpad show; move position center"; # spotify
                "${mod}+period" = "exec blueman-manager"; # bluetooth applet
                "${mod}+k" = "exec arandr"; # choosing display layout
                "${mod}+apostrophe" = "exec pavucontrol --tab=3"; # sound manager

                "${mod}+g" = "exec zathura --mode fullscreen ${../../../../nixos/modules/common/keyboard/Glove80_full.pdf}";
                "${mod}+h" = "mode resize";

                # Text typing commands (e.g. email adresses)
                # antoine.marteau@protonmail.com
                "${mod}+Control+p" = "exec sleep 0.2 && bash -c \"printf 'antoine.marteau@protonmail.com' | xvkbd -utf8 -file -\"";
                # antoine.marteau@monash.edu
                "${mod}+Control+m" = "exec sleep 0.2 && bash -c \"printf 'antoine.marteau@monash.edu' | xvkbd -utf8 -file -\"";
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
                { command = "blueman-applet"; }
                { command = "nm-applet"; }
                { command = "signal-desktop"; }
                { command = "firefox"; }
                { command = "nextcloud"; }
                { command = "zotero"; }
                { command = "${pkgs.redshift}/bin/redshift -P -O 4500"; }
                { command = "${pkgs.feh}/bin/feh --bg-fill ${./wallpaper.jpeg}"; }
                { command = "kitty --class=ttrm";      always = true; }
                { command = "kitty --class=btop btop"; always = true; }
            ];

            terminal = "kitty";

            window = {
                commands = [
                    {
                        command = "focus";
                        criteria = { class = "firefox"; urgent = "latest"; };
                    }
                    { command = "fullscreen enable";                     criteria = { class = "Civ5XP"; }; }
                    { command = "move scratchpad";                       criteria = { class = "ttrm"; }; }
                    { command = "move scratchpad";                       criteria = { class = "btop"; }; }
                    { command = "move scratchpad";                       criteria = { class = "Spotify"; }; }
                    { command = "resize set width 90 ppt height 90 ppt"; criteria = { class = "ttrm"; }; }
                    { command = "resize set width 90 ppt height 90 ppt"; criteria = { class = "btop"; }; }
                    { command = "resize set width 90 ppt height 90 ppt"; criteria = { class = "Spotify"; }; }
                    { command = "resize set width 80 ppt height 80 ppt"; criteria = { class = ".arandr-wrapped"; }; }
                    { command = "resize set width 80 ppt height 80 ppt"; criteria = { class = "Pavucontrol"; }; }
                    { command = "move position center";                  criteria = { class = ".arandr-wrapped"; }; }
                    { command = "move position center";                  criteria = { class = "Pavucontrol"; }; }
                ];
                hideEdgeBorders = "smart";
                titlebar = false;
            };

            workspaceAutoBackAndForth = false;

            workspaceOutputAssign = [
                { workspace = "2"; output = ["xroot-0" "DP-4-1"]; }
                { workspace = "5"; output = ["xroot-0" "DP-4-1"]; }
                { workspace = "6"; output = ["xroot-0" "DP-4-1"]; }
                { workspace = "7"; output = ["xroot-0" "DP-4-1"]; }

                { workspace = "1"; output = ["xroot-0" "DP-4-2"]; }
                { workspace = "3"; output = ["xroot-0" "DP-4-2"]; }
                { workspace = "4"; output = ["xroot-0" "DP-4-2"]; }
            ];
        };
    };
}
