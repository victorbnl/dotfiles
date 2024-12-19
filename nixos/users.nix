{
  users.users = {
    victor = {
      isNormalUser = true;
      description = "Victor";
      extraGroups = [ "networkmanager" "wheel" "vboxusers" ];
    };
  };

  nix.settings.trusted-users = [
    "victor"
  ];
}
