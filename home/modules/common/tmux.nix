{ pkgs, ... }:
{
    programs.tmux = {
        enable = true;

        keyMode = "vi";
        customPaneNavigationAndResize = true;

        prefix = "C-t";

        # neovim comdatibility https://github.com/neovim/neovim/wiki/FAQ
        escapeTime = 10;

        plugins = with pkgs; [
            tmuxPlugins.cpu
            tmuxPlugins.gruvbox
            {
                plugin = tmuxPlugins.resurrect;
                extraConfig = "set -g @resurrect-strategy-nvim 'session'";
            }
            {
                plugin = tmuxPlugins.continuum;
                extraConfig = ''
                    set -g @continuum-restore 'on'
                    set -g @continuum-save-interval '5' # minutes
                '';
            }
        ];

        extraConfig = ''
            set -g mouse on

            # 2x C-t goes back and fourth between most recent windows
            bind-key C-t last-window

            # neovim comdatibility https://github.com/neovim/neovim/wiki/FAQ
            set -g focus-events on

            # Update the status line every seconds
            set -g status-interval 1

            # Create new window and name it directly
            bind C command-prompt -p "Name of new window: " "new-window -n '%%'"

            # vim-like pane switching and edditing
            bind -r ^ last-window
            bind -T copy-mode-vi v send-keys -X begin-selection
            bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
            bind -T copy-mode-vi s send-keys -X cursor-up
            bind -T copy-mode-vi t send-keys -X cursor-down
            bind -T copy-mode-vi c send-keys -X cursor-left
            bind -T copy-mode-vi r send-keys -X cursor-right
            bind -r s select-pane -U
            bind -r t select-pane -D
            bind -r c select-pane -L
            bind -r r select-pane -R

        '';
    };

    home.shellAliases = {
        tm  = "tmux";
        tms = "tmux new -s";
        tml = "tmux list-sessions";
        tma = "tmux attach -t";
        tmk = "tmux kill-session -t";
        tmd = "tmux detach";
    };
}
