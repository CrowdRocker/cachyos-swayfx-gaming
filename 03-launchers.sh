#!/usr/bin/env bash
set -e
echo "[3/4] Installing game launchers and GUI..."

sudo pacman -S --noconfirm \
  steam lutris heroic-games-launcher-bin \
  gamescope mangohud gamemode lib32-gamemode

mkdir -p ~/.local/bin
cat > ~/.local/bin/gamescope-launcher.sh <<EOF
#!/bin/bash
choice=\$(wofi --dmenu -p "Launch Game with Gamescope" <<EOF2
Steam (Big Picture)
Lutris
Heroic Games
EOF2
)

case "\$choice" in
  "Steam (Big Picture)")
    gamescope -f -- steam -bigpicture
    ;;
  "Lutris")
    gamescope -f -- lutris
    ;;
  "Heroic Games")
    gamescope -f -- heroic
    ;;
esac
EOF

chmod +x ~/.local/bin/gamescope-launcher.sh
echo 'bindsym $mod+g exec ~/.local/bin/gamescope-launcher.sh' >> ~/.config/sway/config

echo "✅ Game launchers installed with Wofi GUI."
