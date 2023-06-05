{
    services.openssh = {
        enable = true;

        settings.PasswordAuthentication = false;
    };

    users.users.antoine.openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDHoG8p0Q2ZmDkGirhsndHQIR4l/HoSrqzKro9p3ac9HOjuZqwAEKD00B/N/J4f3GocANEx//pjTS6CF2hvIQqRZpCJeWVsdsoVsgVQyA1oVOSmV928XCvDDALs2qiqgCJUpHWronsOPjZhmTgecHTy+yCw7kx0Dv2YPChnCboREHeCCw9UbtMhl33Lsnx4tII2oCTkmMZUY5ZJEUqb9X0MVmOZNoyO0XfAYowxJ4AU31xDeJ3HC/MTng4eySckujdUEjNQdLE/GquEEFCvCfC2E0mLnu44y11JOn4pXD51onTcRU/khU+OOY+sJtDeLy8+btK5vaj9RPH3Io9vPC1kYsdG1X7F1fB2lPmU78vEouQkBYpTE8L+1gSqt99Srjpv1lKkiKTzvObB4DTf6WRqVyw5NQPqD221QS+F34TxEmC4NC6vPURlqo07cC6BTZQZwoqD7IknP5971O50jjluaXdDo2dvdlhfakq41i2Ns4Y/E5itmDqdZMsKX/w3fWc= antoine@framework"
    ];
}
