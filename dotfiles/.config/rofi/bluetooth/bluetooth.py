#!/usr/bin/env python3


from typing import Any
import subprocess


def get_devices() -> list[str]:
    """Return known devices' MAC addresses."""

    output = subprocess.run(
        ['bluetoothctl', 'devices'], capture_output=True
    ).stdout.decode()

    addresses = [line.split(' ')[1] for line in output.strip().split('\n')]

    return addresses


def get_device_props(addr: str) -> dict[str, str]:
    """Return a device's properties."""

    output = subprocess.run(
        ['bluetoothctl', 'info', addr], capture_output=True
    ).stdout.decode()

    props = {}
    props['addr'] = addr
    for line in output.strip().split('\n')[1:]:
        key, value, *_ = [*line.strip().split(': '), ""]
        key = key.lower()
        if key in ('name', 'icon', 'connected'):
            props[key.lower()] = value

    return props


def generate_rofi_input(devices: list[dict[str, Any]]):
    """Return generated rofi input from list of devices."""

    lines = []
    for device in devices:
        line = device['name']
        if device['connected'] == 'yes':
            line += " (connected)"
        icon = device['icon'] if 'icon' in device else 'bluetooth'
        line += f"\0icon\x1f{icon}"
        lines.append(line)

    return '\n'.join(lines)


if __name__ == '__main__':

    devices = [
        get_device_props(addr)
        for addr in get_devices()
    ]

    output = subprocess.run(
        ['rofi', '-dmenu', '-i', '-format', 'i'],
        input=generate_rofi_input(devices).encode(),
        capture_output=True
    ).stdout.decode().strip()

    if output in ('', '-1'):
        exit()
    else:
        choice = int(output)

    chosen_device = devices[choice]

    if chosen_device['connected'] == 'yes':
        subprocess.run(['bluetoothctl', 'disconnect', chosen_device['addr']])
    else:
        subprocess.run(['bluetoothctl', 'connect', chosen_device['addr']])
