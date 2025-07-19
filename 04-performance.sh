#!/usr/bin/env bash
set -e
echo "[4/4] Applying performance and kernel tweaks..."

sudo sed -i 's/GRUB_CMDLINE_LINUX="/GRUB_CMDLINE_LINUX="amd_pstate=active mitigations=off /' /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

echo "export MANGOHUD=1" >> ~/.bashrc
echo "export GAMEMODERUNEXEC=1" >> ~/.bashrc

echo "✅ Kernel params and MangoHud/Gamemode configured."

