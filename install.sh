#!/bin/bash

if [ "$EUID" -ne 0 ]
then
  echo "Please run as root"
  exit
fi

echo "WARNING: This will overwrite any configuration in /etc/nixos you may have."
echo -n "Are you sure you want to continue? [y/N] "
read confirmation
[ "$confirmation" == "y" ] || exit

cp -r nixos /etc
nixos-rebuild switch