{ secrets, ... }:

{
  networking = {
    wireless = {
      enable = true;
      networks = secrets.networks;
    };
  };
}
