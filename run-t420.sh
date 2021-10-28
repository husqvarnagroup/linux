#!/usr/bin/env bash

set -eu -o pipefail

scp drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.ko t420:rtl8xxxu-qt-creator.ko
ssh t420 "sudo rmmod rtl8xxxu rtl8192cu rtl8192c_common rtl_usb rtlwifi 8192c 2>&- | true"
ssh t420 "echo -n 'module rtl8xxxu +p' | sudo tee /sys/kernel/debug/dynamic_debug/control >/dev/null"
ssh t420 "sudo insmod rtl8xxxu-qt-creator.ko debug=0xF8000; echo -n 'module rtl8xxxu +p' | sudo tee /sys/kernel/debug/dynamic_debug/control >/dev/null"
