{ lib, pkgs, appimageTools, fetchurl, ...}: #with lib;
let
  name = "ankama-launcher";
  src = fetchurl {
    url = "https://launcher.cdn.ankama.com/installers/production/Dofus-Setup-x86_64.AppImage";
    hash = "sha256-u0u8L85Mmf9un9mhngg8hlRJNnmwg5HynXYlcqaxnLA="; # Change for the sha256 you get after running nix-prefetch-url https://download.ankama.com/launcher/full/linux
    name = "ankama-launcher.AppImage";
 };

  appimageContents = appimageTools.extractType2 { inherit name src; };
in
  appimageTools.wrapType2 {
    inherit name src;

    extraInstallCommands = ''
      install -m 444 -D ${appimageContents}/zaap.desktop $out/share/applications/ankama-launcher.desktop
      sed -i 's/.*Exec.*/Exec=ankama-launcher/' $out/share/applications/ankama-launcher.desktop
      install -m 444 -D ${appimageContents}/zaap.png $out/share/icons/hicolor/256x256/apps/zaap.png
    '';
}

