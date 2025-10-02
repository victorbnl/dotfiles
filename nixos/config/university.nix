{ pkgs, root, secrets, ... }:

{
  environment.systemPackages = [(pkgs.writeShellScriptBin "vpn" ''
    systemctl $1 openvpn-$2
  '')];

  services.openvpn.servers.uni = {
    inherit (secrets.uni.vpn) authUserPass;
    config = "config ${root + /assets/uni/vpn.ovpn}";

    autoStart = false;
    updateResolvConf = true;

    up = "echo University > /run/current-vpn";
    down = "rm /run/current-vpn";
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
