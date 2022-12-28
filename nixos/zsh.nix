{ pkgs, ... }:
{
    users.users.antoine.shell = pkgs.zsh;

    environment.pathsToLink = [ "/share/zsh" ];

    programs.zsh.enable = true;
}
