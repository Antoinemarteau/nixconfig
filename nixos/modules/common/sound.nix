{ pkgs, ... }:
{
    environment.systemPackages = with pkgs; [

        pavucontrol
        playerctl

        # Even though using Pipewire, pulseaudio provides `pactl`
        pulseaudio
    ];

    #sound.enable = true;
    #hardware.pulseaudio.enable = true;
    hardware.pulseaudio.enable = false;

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

    # Enable sound. Set to `false` if using PipeWire
    sound.enable = false;

    nixpkgs.config.pulseaudio = true;
}
