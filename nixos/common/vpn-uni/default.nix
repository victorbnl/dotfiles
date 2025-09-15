{ secrets, ... }:

{
  environment.shellAliases = {
    "vpn-start" = "systemctl start openvpn-uni";
    "vpn-stop" = "systemctl stop openvpn-uni";
  };

  services.openvpn.servers.uni = {
    authUserPass = secrets.uniVpnAuthUserPass;
    config = "config ${./config.ovpn}";
    updateResolvConf = true;
  };
}
