{
  users.users = {
    victor = {
      isNormalUser = true;
      description = "Victor";
      extraGroups = [ "networkmanager" "wheel" "vboxusers" "input" ];
    };
  };

  nix.settings.trusted-users = [
    "victor"
  ];
}
