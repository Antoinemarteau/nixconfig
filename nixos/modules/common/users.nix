{
    users = {
        mutableUsers = false;

        users = {

            root = {
                isSystemUser = true;

                hashedPassword = "$y$j9T$8yt.NtcXdzkujmlhYToTM1$7scJyo8o4OrOmRoARt1eUkUo91QmUOxWnhPOwi1msW2";
            };

            antoine = {
                uid = 1000;

                isNormalUser = true;

                extraGroups = [
                    "wheel"             # Enable ‘sudo’ for the user.
                    "networkmanager"    # Enable user to add and edit network connections
                ];

                group = "antoine";

                hashedPassword = "$y$j9T$8yt.NtcXdzkujmlhYToTM1$7scJyo8o4OrOmRoARt1eUkUo91QmUOxWnhPOwi1msW2";
            };
        };

        groups.antoine.gid = 1000;
    };

    # Members of group wheel can execute sudo commands without password.
    security.sudo.wheelNeedsPassword = false;
}

