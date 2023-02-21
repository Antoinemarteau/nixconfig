{ config, ... }:
{
    programs = {
        zsh = {
            enable = true;

            dotDir = ".config/zsh";

            enableAutosuggestions = true;
            enableCompletion = true;
            enableSyntaxHighlighting = true;

            history = {
                path = "${config.xdg.stateHome}/zsh_history";
                size = 50000;
            };

            oh-my-zsh = {
                enable = true;
                plugins = [ "git" ];
                theme = "agnoster";
            };

            # Highly inspired by Mathieu Cneude's blog
            initExtra = ''
                # Run the ssh-agent
                eval `gnome-keyring-daemon --start --components=ssh --daemonize 2> /dev/null`
                export SSH_AUTH_SOCK

                # Remap arrows to Alt+ctsr
                bindkey -M viins '^[c' vi-backward-char
                bindkey -M viins '^[t' vi-down-line-or-history
                bindkey -M viins '^[s' vi-up-line-or-history
                bindkey -M viins '^[r' vi-forward-char

                # Mappings for completion mode
                zmodload zsh/complist
                bindkey -M menuselect 'c' vi-backward-char
                bindkey -M menuselect 't' vi-down-line-or-history
                bindkey -M menuselect 's' vi-up-line-or-history
                bindkey -M menuselect 'r' vi-forward-char
                bindkey -M menuselect '^[' send-break
                bindkey -M menuselect '^M' accept-and-infer-next-history
                bindkey -M menuselect 'u' undo


                # Vi mode for commands edition
                bindkey -v
                export KEYTIMEOUT=1
                # In zsh normal mode, hit v allows to edit command in nvim
                autoload -Uz edit-command-line
                zle -N edit-command-line
                bindkey -M vicmd v edit-command-line

                # Bepo vi cmdmod remaps
                bindkey -M vicmd 'c' vi-backward-char
                bindkey -M vicmd 't' vi-down-line-or-history
                bindkey -M vicmd 's' vi-up-line-or-history
                bindkey -M vicmd 'r' vi-forward-char
                bindkey -M vicmd 'l' vi-change
                bindkey -M vicmd 'L' vi-change-eol
                bindkey -M vicmd 'h' vi-replace-chars
                bindkey -M vicmd 'H' vi-replace
                bindkey -M vicmd 'K' vi-change-whole-line
                bindkey -M vicmd 'k' vi-substitute
                bindkey -M vicmd 'j' vi-find-next-char-skip
                bindkey -M vicmd 'J' vi-find-prev-char-skip
                bindkey -M vicmd 'T' vi-join

                # Allow pending operation to work with bracketed and quoted text objects
                autoload -Uz select-bracketed select-quoted
                zle -N select-quoted
                zle -N select-bracketed
                for km in viopp visual; do
                  bindkey -M $km -- '-' vi-up-line-or-history
                  for c in {a,i}''${(s..)^:-\'\"\`\|,./:;=+@}; do
                    bindkey -M $km $c select-quoted
                  done
                  for c in {a,i}''${(s..)^:-'()[]{}<>bB'}; do
                    bindkey -M $km $c select-bracketed
                  done
                done


                # Make normal mode cursor be like vim normal mode
                cursor_mode() {
                    # See https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html for cursor shapes
                    cursor_block='\e[2 q'
                    cursor_beam='\e[6 q'

                    function zle-keymap-select {
                        if [[ ''${KEYMAP} == vicmd ]] ||
                            [[ $1 = 'block' ]]; then
                            echo -ne $cursor_block
                        elif [[ ''${KEYMAP} == main ]] ||
                            [[ ''${KEYMAP} == viins ]] ||
                            [[ ''${KEYMAP} = \'\' ]] ||
                            [[ $1 = 'beam' ]]; then
                            echo -ne $cursor_beam
                        fi
                    }

                    zle-line-init() {
                        echo -ne $cursor_beam
                    }

                    zle -N zle-keymap-select
                    zle -N zle-line-init
                }

                cursor_mode
            '';
        };

        starship.enable = true;
    };
}
