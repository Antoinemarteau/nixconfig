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

            initExtra = ''
                # Run the ssh-agent
                eval `gnome-keyring-daemon --start --components=ssh --daemonize 2> /dev/null`
                export SSH_AUTH_SOCK
            '';
        };

        starship.enable = true;
    };
}
