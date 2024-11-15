{ pkgs, ... }:

{
  users.users = {
    victor = {
      isNormalUser = true;
      description = "Victor";
      extraGroups = [ "networkmanager" "wheel" ];

      packages = with pkgs; [
        android-tools
        ferdium
        gimp
        lutris
        pcmanfm
        protonup-qt
        qbittorrent
        yt-dlp
      ];
    };
  };
}
