{ pkgs, ... }:

{
  users.users = {
    victor = {
      isNormalUser = true;
      description = "Victor";
      extraGroups = [ "adbusers" "networkmanager" "wheel" ];

      packages = with pkgs; [
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
