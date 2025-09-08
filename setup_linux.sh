#!/bin/bash

if [ "$EUID" -ne 0 ]; then

    echo "This script must be run as root. Use 'sudo -i' first."
    exit 1
fi

echo "Arch Linux WSL Initial Setup"

while true; do
    read -p "Enter username to create: " username
    if [ -n "$username" ]; then
        break
    fi
    echo "Username cannot be empty. Please try again."

done

passwd


pacman -Syu --noconfirm
pacman -S sudo vi --noconfirm

# Ask about wheel group sudo permissions
echo "Configure sudo permissions for wheel group:"
echo "1) With password (default)"
echo "2) Without password"
read -p "Select option (1 or 2): " sudo_option

if [ "$sudo_option" = "2" ]; then
    sed -i 's/^# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/' /etc/sudoers
else
    sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers
fi

sed -i 's/^#en_CA.UTF-8 UTF-8/en_CA.UTF-8 UTF-8/' /etc/locale.gen
sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen

locale-gen
localectl set-locale LANG=en_CA.UTF-8
ln -sf /etc/locale.conf /etc/default/locale

useradd -m -G wheel -s /bin/bash "$username"

echo "Setting password for user '$username':"
passwd "$username"


cat > /etc/wsl.conf << EOF
[user]
default=$username
EOF

echo "Setup complete. Run 'wsl --shutdown' from Windows, then:"
echo "wsl -s archlinux"
echo "wsl"
