#!/usr/bin/env bash
set -e
echo "[2/4] Installing SwayFX and theming..."

sudo pacman -S --noconfirm swayfx waybar wofi sddm autotiling

sudo systemctl enable sddm
sudo mkdir -p /etc/sddm.conf.d
echo -e "[Theme]\nCurrent=nordic" | sudo tee /etc/sddm.conf.d/theme.conf

mkdir -p ~/.config/sway
cat > ~/.config/sway/config <<EOF
include /etc/sway/config.d/*
exec_always --no-startup-id autotiling
exec_always --no-startup-id waybar
exec_always --no-startup-id gamemoded -r
exec_always --no-startup-id swayidle -w timeout 300 'swaylock -f' timeout 600 'swaymsg "output * dpms off"' resume 'swaymsg "output * dpms on"'
output * bg ~/Pictures/wallpapers/tokyonight.jpg fill
EOF

mkdir -p ~/.config/waybar
cat > ~/.config/waybar/style.css <<EOF
@import url("https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/waybar/tokyonight.css");
EOF

cat > ~/.config/waybar/config <<EOF
{
  "layer": "top",
  "position": "top",
  "modules-left": ["sway/workspaces", "sway/mode"],
  "modules-center": ["clock"],
  "modules-right": ["pulseaudio", "network", "cpu", "memory", "battery"],
  "clock": {
    "format": "{:%A, %b %d  %I:%M %p}"
  }
}
EOF

echo "✅ SwayFX + themes configured."
