{
    users = {
        mutableUsers = false;

        users = {

            root = {
                isSystemUser = true;

                hashedPassword = "$y$j9T$8yt.NtcXdzkujmlhYToTM1$7scJyo8o4OrOmRoARt1eUkUo91QmUOxWnhPOwi1msW2";
            };

            antoine = {
                isNormalUser = true;

                extraGroups = [
                    "wheel"             # Enable ‘sudo’ for the user.
                    "networkmanager"    # Enable user to add and edit network connections
                ];

                hashedPassword = "$y$j9T$8yt.NtcXdzkujmlhYToTM1$7scJyo8o4OrOmRoARt1eUkUo91QmUOxWnhPOwi1msW2";
            };
        };
    };

    # Members of group wheel can execute sudo commands without password.
    security.sudo.wheelNeedsPassword = false;
}

