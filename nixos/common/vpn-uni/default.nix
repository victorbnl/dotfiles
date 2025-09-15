{ secrets, ... }:

{
  environment.shellAliases = {
    "vpn-start" = "systemctl start openvpn-uni";
    "vpn-stop" = "systemctl stop openvpn-uni";
  };

  services.openvpn.servers.uni = {
    inherit (secrets.uniVpn) authUserPass;
    autoStart = false;
    config = "config ${./config.ovpn}";
    updateResolvConf = true;
  };
}
