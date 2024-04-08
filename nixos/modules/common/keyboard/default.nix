{ pkgs, ... }:
{
    services.xserver = {
        xkb = {
          options = "caps:swapescape";
          layout = "bepo_antoine";
          extraLayouts.bepo_antoine = {
              description = "bepo antoine";
              languages = [ "fr" ];
              symbolsFile = ./layout.xkb;
          };
        };
    };

    console.useXkbConfig = true;

    # to help manually activate bepo (see shell/default.nix)
    environment.systemPackages = with pkgs; [
        xorg.xkbcomp
    ];
}
