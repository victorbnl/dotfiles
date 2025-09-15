{ root, secrets, ... }:

{
  networking = {
    useDHCP = true;

    wireless = {
      enable = true;
      inherit (secrets) networks;
    };
  };

  environment.shellAliases = {
    "vpn-start" = "systemctl start openvpn-uni";
    "vpn-stop" = "systemctl stop openvpn-uni";
  };

  services.openvpn.servers.uni = {
    inherit (secrets.uniVpn) authUserPass;
    autoStart = false;
    config = "config ${root + /assets/uni/vpn.ovpn}";
    updateResolvConf = true;
  };
}
