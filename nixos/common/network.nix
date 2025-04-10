{ secrets, ... }:

{
  networking = {
    useDHCP = true;

    wireless = {
      enable = true;
      networks = secrets.networks;
    };
  };
}
