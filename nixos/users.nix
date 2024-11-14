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
        gcc
        gimp
        pcmanfm
        python3
        vim
      ];
    };
  };
}
