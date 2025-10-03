{ names, secrets, ... }:

{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  networking = {
    hostName = names.host;
    useDHCP = true;

    wireless = {
      enable = true;
      inherit (secrets) networks;
    };
  };
}
