#!/usr/bin/env bash

# Title: CachyOS SwayFX Gaming Setup
# Author: CrowdRocker
# Description: Full SwayFX gaming setup w/ TokyoNight, ZRAM, CPU tuning, Waybar, Wofi, Steam launchers, MangoHud

set -e

# Colors
bold=$(tput bold)
normal=$(tput sgr0)
blue="\033[1;34m"
green="\033[1;32m"
reset="\033[0m"

echo -e "${blue}${bold}▶️ Starting Gaming Setup for CachyOS + SwayFX...${reset}"

# Update and install base tools
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm git base-devel wget curl unzip

# Clone dotfiles from GitHub
echo -e "${green}📦 Cloning dotfiles from GitHub...${reset}"
git clone https://github.com/CrowdRocker/cachyos-swayfx-gaming ~/dotfiles || true

# Copy config files
echo -e "${green}🛠 Applying configs...${reset}"
cp -r ~/dotfiles/.config/* ~/.config/
cp -r ~/dotfiles/.local/* ~/.local/ 2>/dev/null || true
cp ~/dotfiles/.bashrc ~ 2>/dev/null || true

# Install AUR helper (yay)
if ! command -v yay &>/dev/null; then
echo -e "${green}⚙️ Installing yay AUR helper...${reset}"
cd ~
git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -si --noconfirm
cd ~ && rm -rf yay
fi

# Install essential packages
echo -e "${green}🎮 Installing gaming and desktop packages...${reset}"
yay -S --noconfirm swayfx waybar wofi swaybg \
gamemode mangohud goverlay \
steam heroic-games-launcher lutris \
zram-generator cpupower lib32-gamemode \
ttf-jetbrains-mono-nerd noto-fonts ttf-font-awesome \
swaylock swayidle brightnessctl playerctl

# Enable ZRAM
echo -e "${green}🧠 Enabling ZRAM (compressed RAM swap)...${reset}"
sudo tee /etc/systemd/zram-generator.conf >/dev/null <<EOF
[zram0]
zram-size = ram / 2
compression-algorithm = zstd
EOF
sudo systemctl daemon-reexec
sudo systemctl start /dev/zram0 || true

# Enable SSD TRIM
echo -e "${green}💾 Enabling SSD TRIM...${reset}"
sudo systemctl enable fstrim.timer

# Set CPU governor to performance
echo -e "${green}⚡ Setting CPU governor...${reset}"
echo "governor='performance'" | sudo tee /etc/default/cpupower
sudo systemctl enable cpupower.service
sudo systemctl start cpupower.service

# Auto-tiling for SwayFX
echo -e "${green}🧱 Enabling auto-tiling...${reset}"
yay -S --noconfirm autotiling-rs
mkdir -p ~/.config/autostart
echo "autotiling-rs &" >> ~/.config/sway/config

# Steam Launch Options (via Desktop Entry override)
echo -e "${green}🛠 Configuring Steam game launch with MangoHud and Gamemode...${reset}"
mkdir -p ~/.local/share/applications
cat > ~/.local/share/applications/steam-gaming.desktop <<EOF
[Desktop Entry]
Name=Steam (Gaming Mode)
Exec=gamemoderun mangohud steam
Icon=steam
Type=Application
Categories=Game;
EOF
update-desktop-database ~/.local/share/applications

# Done
echo -e "${blue}${bold}✅ Setup complete! You can now reboot and log into your optimized SwayFX gaming desktop.${reset}"
