#!/usr/bin/env bash
set -e
echo "[1/4] Installing base system packages..."

sudo pacman -Syu --noconfirm

sudo pacman -S --noconfirm \
  base-devel git curl wget unzip \
  neofetch btop alacritty fish \
  noto-fonts noto-fonts-emoji \
  ttf-jetbrains-mono ttf-font-awesome \
  papirus-icon-theme nordic-theme-git qt5ct \
  xf86-video-amdgpu amd-ucode \
  vulkan-radeon lib32-vulkan-radeon \
  vulkan-icd-loader lib32-vulkan-icd-loader

echo "✅ Base packages installed."
