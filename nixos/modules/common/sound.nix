{ pkgs, ... }:
{
    environment.systemPackages = with pkgs; [

        pavucontrol
        playerctl

        # Even though using Pipewire, pulseaudio provides `pactl`
        pulseaudio
    ];

    #sound.enable = true;
    #services.pulseaudio.enable = false;
    services.pulseaudio.enable = false;

    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;

        pulse.enable = true;
        jack.enable = true;

        alsa = {
            enable = true;
            support32Bit = true;
        };
    };

    nixpkgs.config.pulseaudio = true;
}
