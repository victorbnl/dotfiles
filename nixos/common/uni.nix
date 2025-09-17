{ root, secrets, ... }:

{
  environment.shellAliases = {
    "vpn-start" = "systemctl start openvpn-uni";
    "vpn-stop" = "systemctl stop openvpn-uni";
  };

  services.openvpn.servers.uni = {
    inherit (secrets.uni.vpn) authUserPass;
    autoStart = false;
    config = "config ${root + /assets/uni/vpn.ovpn}";
    updateResolvConf = true;
  };

  networking.wireless.networks."eduroam".auth = ''
    key_mgmt=WPA-EAP
    pairwise=CCMP
    group=CCMP TKIP
    eap=PEAP
    ca_cert="${root + /assets/uni/ca.pem}"
    identity="${secrets.uni.eduroam.identity}"
    altsubject_match="DNS:radius-test.univ-lille.fr;DNS:radius.univ-lille.fr;DNS:radius1.univ-lille.fr;DNS:radius2.univ-lille.fr"
    phase2="auth=MSCHAPV2"
    password="${secrets.uni.eduroam.password}"
  '';
}
