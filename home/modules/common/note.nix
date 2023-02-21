{ config, pkgs, ... }:
{
    # config taken from Calin Leafshade dotfiles https://www.youtube.com/watch?v=zB_3FIGRWRU
    # Take notes with mod+n, look the last one with mod+Shift+n.
    # They are stored in ~/glepage_cloud/Misc/notes/src (markdowns) and
    #                 in ~/glepage_cloud/Misc/notes/pdf (pdfs)
    config.xsession.windowManager.i3.config = {
        keybindings = let
            mod = config.xsession.windowManager.i3.config.modifier;
            noteTaker = pkgs.writeScript "noteTaker" ''
                #!/bin/sh

                noteFilename="$HOME/glepage_cloud/Misc/notes/src/notes-$(date +%Y-%m-%d).md"

                if [ ! -f $noteFilename ]; then
                  echo "# Notes for $(date +%Y-%m-%d)" > $noteFilename
                fi

                nvim -c "norm G2o" \
                  -c "norm zz" \
                  -c "startinsert" $noteFilename
            '';
            mostRecentNote = pkgs.writeScript "mostRecentNote" ''
                #!/bin/sh
                ls -r ~/glepage_cloud/Misc/notes/pdf/*.pdf | head -n1 | xargs ${pkgs.zathura}/bin/zathura
            '';
        in {
            "${mod}+n"       = "exec kitty --class=noteTakerWin ${noteTaker}";
            "${mod}+Shift+n" = "exec ${mostRecentNote}";
        };

        floating.criteria = [ { class = "noteTakerWin"; } { class = "athura"; title = "notes-"; } ];
        window.commands = [
            { command = "resize set width 80 ppt height 80 ppt"; criteria = { class = "noteTakerWin"; }; }
            { command = "resize set width 80 ppt height 80 ppt"; criteria = { class = "athura"; title = "notes-"; }; }
            { command = "move position center";                  criteria = { class = "noteTakerWin"; }; }
            { command = "move position center";                  criteria = { class = "athura"; title = "notes-"; }; }
        ];
    };

    config.home.sessionPath = [ "$HOME/.local/bin" ]; #add it to system path
    config.home.file = {
        buildNote = {
            executable = true;
            text = ''
                #!/bin/sh

                filename=$1
                target="$(dirname "$filename")/../pdf"
                outputFile="$(basename "$filename" .md).pdf"

                mkdir -p $target

                ${pkgs.pandoc}/bin/pandoc \
                    --pdf-engine=xelatex \
                    -V 'mainfont:DejaVuSerif' \
                    -V 'mainfontoptions:Extension=.ttf, UprightFont=*, BoldFont=*-Bold, ItalicFont=*-Italic, BoldItalicFont=*-BoldItalic' \
                    -V 'sansfont:DejaVuSans.ttf' \
                    -V 'monofont:DejaVuSansMono.ttf' \
                    -V "geometry:margin=1in" \
                    -o "$target/$outputFile" $filename &
            '';

            target = ".local/bin/buildNote";
        };
    };
}

