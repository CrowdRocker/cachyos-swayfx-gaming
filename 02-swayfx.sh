#!/usr/bin/env bash
set -e
echo "[2/4] Installing SwayFX and theming..."

# enable flatpaks
sudo pacman -S --noconfirm --needed flatpak

###### Firewall installs ####
sudo ufw enable
sudo ufw status verbose
sudo systemctl enable ufw.service
sudo systemctl enable fstrim.timer
sudo systemctl start fstrim.timer
du -sh /var/cache/pacman/pkg/
sudo pacman -S -y pacman-contrib
sudo systemctl enable paccache.timer

###### yay ########
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd

### chaotic-aur
# Add chaotic AUR keys and repository if not added, else skip
echo "Adding chaotic AUR keys and repository"
if ! pacman-key --list-keys chaotic-aur &> /dev/null; then
  echo "Adding chaotic AUR keys and repository"
  sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
  sudo pacman-key --lsign-key 3056513887B78AEB
  sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
  sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
  echo "Chaotic AUR keys added successfully"
else
  echo "Chaotic AUR keys and repository already added. Skipping..."
fi

# Add chaotic AUR
if ! grep -q "^\[chaotic-aur\]" /etc/pacman.conf; then
  echo "[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf
  sudo pacman -Sy
  echo "Chaotic AUR repository added/updated successfully"
fi

yay -S --noconfirm --needed 7zip adobe-source-code-pro-fonts adobe-source-sans-fonts adobe-source-serif-fonts alacritty alsa-firmware alsa-plugins alsa-utils amd-ucode antimicrox appimagelauncher ardour arj audacious audacity auto-cpufreq autotiling awesome-terminal-fonts azote b43-fwcutter base base-devel bash-completion battop bemenu-wayland bind blender bottles bottom boxtron brave-bin bridge-utils brightnessctl btrfs-assistant calcurse catfish celluloid chaotic-keyring chaotic-mirrorlist cliphist corectrl cpupower curlftpfs darktable dex dialog dmidecode dmraid dosfstools downgrade dracut dua-cli dvgrab dxvk-mingw-git earlyoom easyeffects ecryptfs-utils efibootmgr eog ethtool exfatprogs f2fs-tools fastfetch fatresize ffmpegthumbnailer ffmpegthumbs file-roller firefox flatpak font-manager foot frei0r-plugins fscrypt fuse2fs fuzzel fwupd galculator gamemode gamescope gamescope-session-git garcon gedit gimp git gnome-disk-utility gnome-firmware gnome-keyring gnu-netcat goverlay gparted grim grub grub-btrfs gst-libav gst-plugin-pipewire gst-plugins-bad gst-plugins-ugly gstreamer-vaapi gtklock gtklock-powerbar-module gtklock-userinfo-module gvfs gvfs-afc gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb heroic-games-launcher-bin htop inetutils inkscape intel-media-driver intel-ucode inxi iwd jfsutils joystickwake jq kanshi kate kdenlive kitty konsole krita krita-plugin-gmic kvantum kvantum-qt5 lact lhasa lib32-gamemode lib32-mangohud lib32-mesa lib32-pipewire-jack lib32-vulkan-radeon libdvdcss libgsf libmythes libopenraw libpulse libreoffice-fresh libva-intel-driver lmms logrotate lrzip lsb-release lutris lvm2 lzip lzop mako man-db man-pages mangohud mcfly meld memtest86+ micro mixxx mousepad movit mtools nano net-tools network-manager-applet networkmanager nfs-utils nilfs-utils nmap nordic-darker-theme noto-fonts noto-fonts-cjk noto-fonts-emoji nss-mdns ntfs-3g nwg-displays nwg-drawer nwg-hello nwg-look nwg-menu octopi opus-tools os-prober otf-aurulent-nerd otf-codenewroman-nerd otf-comicshanns-nerd otf-commit-mono-nerd otf-droid-nerd otf-firamono-nerd otf-font-awesome otf-font-awesome-4 otf-geist-mono-nerd otf-hasklig-nerd otf-hermit-nerd otf-monaspace-nerd otf-opendyslexic-nerd otf-overpass-nerd pacman-contrib pacseek pamixer parole paru pavucontrol perl-file-mimeinfo picom pipewire pipewire-alsa pipewire-jack pipewire-pulse plocate polkit-gnome popsicle power-profiles-daemon powerline-fonts powertop proton-ge-custom-bin qbittorrent rebuild-detector ristretto rocm-hip-runtime rocm-opencl-runtime rsync s-tui sassc sddm slurp smartmontools snapper-support snapper-tools sof-firmware sox sshfs starship steam swappy sway-contrib swaybg swayfx swayidle swayimg swaylock swayr tela-circle-icon-theme-nord terminus-font thunar thunar-archive-plugin thunar-media-tags-plugin thunar-shares-plugin thunar-volman thunderbird traceroute ttf-0xproto-nerd ttf-3270-nerd ttf-agave-nerd ttf-anonymouspro-nerd ttf-arimo-nerd ttf-bigblueterminal-nerd ttf-bitstream-vera-mono-nerd ttf-cascadia-code-nerd ttf-cascadia-mono-nerd ttf-cousine-nerd ttf-d2coding-nerd ttf-daddytime-mono-nerd ttf-dejavu ttf-dejavu-nerd ttf-droid ttf-envycoder-nerd ttf-fantasque-nerd ttf-fantasque-sans-mono ttf-fira-sans ttf-firacode-nerd ttf-go-nerd ttf-gohu-nerd ttf-hack-nerd ttf-heavydata-nerd ttf-iawriter-nerd ttf-ibmplex-mono-nerd ttf-inconsolata-go-nerd ttf-inconsolata-lgc-nerd ttf-inconsolata-nerd ttf-intone-nerd ttf-iosevka-nerd ttf-iosevkaterm-nerd ttf-iosevkatermslab-nerd ttf-jetbrains-mono ttf-jetbrains-mono-nerd ttf-lekton-nerd ttf-liberation ttf-liberation-mono-nerd ttf-lilex-nerd ttf-martian-mono-nerd ttf-meslo-nerd ttf-monofur-nerd ttf-monoid-nerd ttf-mononoki-nerd ttf-mplus-nerd ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-common ttf-nerd-fonts-symbols-mono ttf-noto-nerd ttf-opensans ttf-profont-nerd ttf-proggyclean-nerd ttf-recursive-nerd ttf-roboto-mono-nerd ttf-sharetech-mono-nerd ttf-sourcecodepro-nerd ttf-space-mono-nerd ttf-terminus-nerd ttf-tinos-nerd ttf-ubuntu-font-family ttf-ubuntu-mono-nerd ttf-ubuntu-nerd ttf-victor-mono-nerd ttf-zed-mono-nerd tumbler ufw ugrep unace unarchiver unarj unrar vi vim visual-studio-code-bin vivaldi vivaldi-ffmpeg-codecs vkbasalt vlc vulkan-intel vulkan-mesa-layers vulkan-nouveau vulkan-radeon waybar waybar-module-pacman-updates-git wdisplays wf-recorder wget whois wireless-regdb wireless_tools wireplumber wmenu wofi wqy-zenhei wtype xdg-desktop-portal xdg-desktop-portal-wlr xdg-user-dirs xdg-utils xfsprogs xorg-xhost xorg-xwayland xpadneo-dkms xpadneo-dkms-git xsel xz yad zip zram-generator zsh zsh-autocomplete zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting

sudo systemctl enable sddm
sudo mkdir -p /etc/sddm.conf.d
echo -e "[Theme]\nCurrent=nordic" | sudo tee /etc/sddm.conf.d/theme.conf

mkdir -p ~/.config/sway
cat > ~/.config/sway/config <<EOF
include /etc/sway/config.d/*
exec_always --no-startup-id autotiling
exec_always --no-startup-id waybar
exec_always --no-startup-id gamemoded -r
# Auth with polkit-gnome:
exec /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1

# Import environment variables for user systemd service manager
exec systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK

# Update dbus environments with display variables
exec hash dbus-update-activation-environment 2>/dev/null && \
    dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK

# Idle configuration
exec swayidle idlehint 1
exec_always swayidle -w before-sleep "gtklock -d"

# Desktop notifications
exec mako

# Start foot server
exec_always --no-startup-id foot --server

# Autotiling
exec autotiling

# Launch all Sway applications in autostart directories
exec dex -a -e sway

# cliphist
exec wl-paste --type text --watch cliphist store
exec wl-paste --type image --watch cliphist store

# Outputs
exec kanshi

# nwg-drawer
exec_always nwg-drawer -r -c 7 -is 90 -mb 10 -ml 50 -mr 50 -mt 10

# swayrd
exec_always swayrd

# Sway Fader
exec python3 ~/.config/sway/scripts/swayfader.py     
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
    "position": "top", // Waybar position (top|bottom|left|right)
    //"height": 30, // Uncomment to set a custom height
    //"output": "DP-1", // Uncomment to specify a display
    //"width": 1850, // Uncomment to set a custom width

// Configuration - modules-left

    "modules-left": [
        "custom/launcher",
        "sway/workspaces",
        "sway/window"
    ],

    "custom/launcher": {
        "format":"<span size='x-large'></span>",
        "on-click": "exec nwg-drawer",
        "tooltip": false
    },

    "sway/workspaces": {
        "disable-scroll": true,
        "all-outputs": true,
        "format": "{icon}",
        "format-icons": {
            "3": "3",
            "4": "4",
            "5": "5",
            "6": "6",
            "7": "7",
            "8": "8",
            "9": "9",
            "10": "10"
        }
    },

    "sway/window": {
        "format": "{}",
        //"all-outputs": true, // Active window shows only on active display when commented
        "max-length": 120,
        "on-click": "swayr merge-config ~/.config/swayr/waybar_config.toml; swayr switch-workspace-or-window; swayr reload-config",
    },

// Configuration - modules-center
    
    "modules-center": [
        "network"
    ],

    "network": {
        "format-disabled": " Disabled",
        "format-wifi": " {bandwidthDownBits:>} 󰶡 {bandwidthUpBits:>} 󰶣",
        "tooltip-format-wifi": "ESSID: {essid}",
        "format-ethernet": "󰈀 {bandwidthDownBits:>} 󰶡 {bandwidthUpBits:>} 󰶣",
        "tooltip-format-ethernet": "{ifname}: {ipaddr}/{cidr}",
        "format-disconnected": " Disconnected",
        "on-click": "footclient -T waybar_nmtui -e nmtui",
        "interval": 2
    },

// Configuration - modules-right

    "modules-right": [
        "privacy",
        "group/updates",
        "custom/keyboard-layout",
        "group/resources",
        "memory",
        "wireplumber",
        "battery",
        "group/settings",
        "clock",
        "group/power",
    ],

    "privacy": {
    	"icon-spacing": 4,
    	"icon-size": 18,
    	"transition-duration": 250,
    	"modules": [
    		{
    			"type": "screenshare",
    			"tooltip": true,
    			"tooltip-icon-size": 24
    		},
    		{
    			"type": "audio-out",
    			"tooltip": true,
    			"tooltip-icon-size": 24
    		},
    		{
    			"type": "audio-in",
    			"tooltip": true,
    			"tooltip-icon-size": 24
    		}
    	]
    },

    "group/updates": {
        "orientation": "inherit",
        "drawer": {
            "transition-duration": 500,
            "children-class": "updates-drawer",
            "transition-left-to-right": false,
            "click-to-reveal": false,
        },
        "modules": [
            "custom/updates",
            "custom/pacman",
        ]
    },
    "custom/updates": {
        "format": "{icon}{0}",
        "return-type": "json",
        "format-icons": {
            "has-updates": " ",
            "updated": ""
        },
        "exec-if": "which waybar-module-pacman-updates",
        "exec": "waybar-module-pacman-updates --no-zero-output --interval-seconds 5 --network-interval-seconds 300 --tooltip-align-columns",
        "on-click": "footclient -T waybar_pacseek -e pacseek -ui",
    },

    "custom/pacman": {
        "format": "󰮯",
        "tooltip-format": "L󰍽: Pacseek\nR󰍽: Upgrade",
        "on-click": "footclient -T waybar_pacseek -e pacseek",
        "on-click-right": "footclient -T waybar_garuda-update -e bash -c 'garuda-update && (read -p \"Update complete. Press Enter to exit.\" && exit 0) || (read -p \"Update failed. Press Enter to exit.\" && exit 1)'",
    },

    "custom/keyboard-layout": {
      	"exec": "i=$(swaymsg -t get_inputs); echo \"$i\" | grep -m1 'xkb_active_layout_name' | cut -d '\"' -f4",
        "format": "",
        "tooltip-format": "󰍽: cheatsheet\nLayout: {0}",
        // Interval set only as a fallback; use signal to update the module more immediately
        "interval": 30,
        // See example config for sending signal to Waybar in ~/.config/sway/config.d/input
        "signal": 1,
        "on-click": "~/.config/waybar/scripts/keyhint.sh",
    },
    
    "group/resources": {
        "orientation": "inherit",
        "drawer": {
            "transition-duration": 500,
            "children-class": "resources-drawer",
            "transition-left-to-right": true,
            "click-to-reveal": true,
        },
        "modules": [
            "cpu",
            "temperature",
            "disk",
        ]
    },

    "cpu": {
        "interval": 5,
        "format": " {usage}%",
        "states": {
            "warning": 70,
            "critical": 90,
        },
    },
    
    "temperature": {
        "critical-threshold": 80,
        "format-critical": " {temperatureC}°C",
        "format": " {temperatureC}°C",
        "tooltip-format": "  󰍽: s-tui\n {temperatureC}° Celsius\n{temperatureF}° Fahrenheit\n{temperatureK}° Kelvin",
        "on-click": "footclient -T waybar_s-tui -e s-tui"
    },

    "disk": {
        "interval": 600,
        "format": "󰋊 {percentage_used}%",
        "path": "/",
        "on-click": "footclient -T waybar_dua -e dua i /",
        "tooltip-format": "    󰍽: dua\nTotal: {total}\n Used: {used} ({percentage_used}%)\n Free: {free} ({percentage_free}%)",
    },

    "memory": {
        "interval": 5,
        "format": " {}%",
        "on-click": "footclient -T waybar_btm -e btm", 
        "states": {
            "warning": 70,
            "critical": 90
        },
        "tooltip-format": "        󰍽: btm\n   Memory: {total} GiB\n   In use: {used} GiB ({percentage}%)\nAvailable: {avail} GiB\n     Swap: {swapTotal} GiB\n   In use: {swapUsed} GiB ({swapPercentage}%)\nAvailable: {swapAvail} GiB",
    },

    "wireplumber": {
        "format": "{icon} {volume}%",
        "format-muted": "󰝟 muted",
        "on-click": "pavucontrol",
        "on-click-right": "pamixer --toggle-mute",
        "format-icons": ["󰕿", "󰖀", "󰕾"],
        "tooltip-format": "L󰍽: pavucontrol\nR󰍽: Toggle mute\nNode: {node_name}",
    },

    "battery": {
        "states": {
            "warning": 20,
            "critical": 10
        },
        "format": "{icon} {capacity}%",
        "format-charging": "{icon} {capacity}% ",
        "format-plugged": "{icon} {capacity}% ",
        "format-full": "{icon} {capacity}% ",
        "format-icons": ["", "", "", "", ""],
        "tooltip-format": "󰍽: battop\n{timeTo}",
        "on-click": "footclient -T waybar_battop -e battop",
    },

    "group/settings": {
        "orientation": "inherit",
        "drawer": {
            "transition-duration": 500,
            "children-class": "settings-drawer",
            "transition-left-to-right": true,
            "click-to-reveal": true,
        },
        "modules": [
            "custom/settings",
            "idle_inhibitor",
            "backlight",
            "bluetooth",
            "tray",
        ]
    },
    "custom/settings": {
        "format":"",
        "tooltip-format": "Settings"
    },

    "idle_inhibitor": {
        "format": "{icon}",
        "format-icons": {
            "activated": " ",
            "deactivated": " "
        },
        "tooltip-format-activated": "Idle Inhibitor Activated",
        "tooltip-format-deactivated": "Idle Inhibitor Deactivated"
    },

    "backlight": {
        "format": "{icon} {percent}%",
        "format-icons": ["󰄰", "󰪞", "󰪟", "󰪠", "󰪡", "󰪢", "󰪣", "󰪤", "󰪥"],
        "tooltip-format": "Backlight (Scroll): {percent:}%",
        "on-scroll-down": "brightnessctl -c backlight set 5%-",
        "on-scroll-up": "brightnessctl -c backlight set +5%"
    },

    "bluetooth": {
    	"format": "󰂯 {status}:{num_connections}",
    	"format-on": "󰂯",
    	"format-off": "󰂲",
    	"format-disabled": "", // an empty format will hide the module
    	"format-icons": ["󰤾", "󰤿", "󰥀", "󰥁", "󰥂", "󰥃", "󰥄", "󰥅", "󰥆", "󰥈"],
    	"tooltip-format": "L󰍽: bluetui\nR󰍽: bluetoothctl power on/off\nController: {controller_alias}\t{controller_address}\nConnected devices: {num_connections}",
    	"tooltip-format-connected": "L󰍽: bluetui\nR󰍽: bluetoothctl power on/off\nController: {controller_alias}\t{controller_address}\nConnected devices: {num_connections}\nDevice---------------Address------------Battery\n{device_enumerate}",
    	"tooltip-format-enumerate-connected": "{device_alias:<20} {device_address:<18}",
    	"tooltip-format-enumerate-connected-battery": "{device_alias:<20.20} {device_address:<18.18} {icon} {device_battery_percentage}%",
       	"on-click": "footclient -T waybar_bluetui -e bluetui",
       	"on-click-right": "~/.config/sway/scripts/bluetooth_toggle.sh"
    },

    "tray": {
        "icon-size": 16,
        "spacing":10
    },

    "clock": {
        "format": "󰅐 {:%OI:%M %p}",
        "on-click": "footclient -T waybar_calcurse -e calcurse",
        // Uncomment to enable right-click calcurse-caldav sync (you need to set it up in calcurse config)
        //"on-click-right": "notify-send \"Running calcurse-caldav...\" \"$(calcurse-caldav)\"",
        "tooltip-format": " {:%A %m/%d}\n\n<tt><small>{calendar}</small></tt>",
        "calendar": {
            "on-scroll": 1,
            "format": {
                "months":     "<span color='#ffead3'><b>{}</b></span>",
                "days":       "<span color='#ecc6d9'><b>{}</b></span>",
                "weeks":      "<span color='#99ffdd'><b>W{}</b></span>",
                "weekdays":   "<span color='#ffcc66'><b>{}</b></span>",
                "today":      "<span color='#ff6699'><b><u>{}</u></b></span>"
            },
        },
        "actions": {
            "on-scroll-up": "shift_up",
            "on-scroll-down": "shift_down"
        },
    },

    "group/power": {
        "orientation": "inherit",
        "drawer": {
            "transition-duration": 500,
            "children-class": "power-drawer",
            "transition-left-to-right": true,
        },
        "modules": [
            "custom/power",
            "custom/reboot",
            "custom/reboot-uefi",
            "custom/log-off",
            "custom/suspend",
            "custom/lock",
        ]
    },
    "custom/power": {
        "format":"⏻",
        "on-click": "systemctl poweroff",
        "tooltip-format": "Shutdown"
    },
    "custom/reboot": {
        "format":"",
        "on-click": "systemctl reboot",
        "tooltip-format": "Reboot"
    },
    "custom/reboot-uefi": {
        "format":"",
        "on-click": "systemctl reboot --firmware-setup",
        "tooltip-format": "Reboot to UEFI"
    },
    "custom/log-off": {
        "format":"󰍃",
        "on-click": "swaymsg exit",
        "tooltip-format": "Log out"
    },
    "custom/suspend": {
        "format":"󰤄",
        "on-click": "systemctl suspend",
        "tooltip-format": "Suspend"
    },
    "custom/lock": {
        "format":"󰌾",
        "on-click": "gtklock",
        "tooltip-format": "Lock"
    },
}
EOF

echo "✅ SwayFX + themes configured."
