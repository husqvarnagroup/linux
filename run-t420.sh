#!/usr/bin/env bash
# shellcheck disable=SC2029

set -eu -o pipefail

readonly iface="wlx74da3826ba27"

scp drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.ko t420:rtl8xxxu.ko
ssh t420 "sudo dhclient -r ${iface} && sudo systemctl stop wpa_supplicant@${iface}; sudo rmmod rtl8xxxu rtl8192cu rtl8192c_common rtl_usb rtlwifi 8192cu 2>/dev/null || true"
ssh t420 "sudo insmod rtl8xxxu.ko debug=0xF8000; echo -n 'module rtl8xxxu +p' | sudo tee /sys/kernel/debug/dynamic_debug/control >/dev/null && sudo systemctl start wpa_supplicant@${iface} && sudo dhclient -i ${iface}"
