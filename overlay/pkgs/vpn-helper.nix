{
  writeShellScriptBin,
}:

writeShellScriptBin "vpn" ''
  systemctl $1 openvpn-$2
''
