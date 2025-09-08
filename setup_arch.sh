#!/bin/bash

echo "Arch Linux WSL Initial Setup"
echo "============================"
echo

if [ "$EUID" -ne 0 ]; then
    echo "This script must be run as root. Use 'sudo -i' first."
    exit 1
fi

echo "Installing prereqs"
echo "------------------"
pacman -Syu --noconfirm
pacman -S sudo vi git openssh --noconfirm
echo
echo

echo "Change root password"
echo "--------------------"
passwd
echo
echo

echo "Sudo configuration"
echo "------------------"
echo "1) Use password (default)"
echo "2) No password"
read -p "Select option (1 or 2): " sudo_option

if [ "$sudo_option" = "2" ]; then
    sed -i 's/^# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/' /etc/sudoers
else
    sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers
fi
echo
echo

echo "Setting up CA locale"
echo "--------------------"
sed -i 's/^#en_CA.UTF-8 UTF-8/en_CA.UTF-8 UTF-8/' /etc/locale.gen
sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen

locale-gen
localectl set-locale LANG=en_CA.UTF-8
ln -sf /etc/locale.conf /etc/default/locale
echo
echo

echo "Setup main account"
echo "------------------"
while true; do
    read -p "Enter main account username: " username
    if [ -n "$username" ]; then
        break
    fi
    echo "Username cannot be empty. Please try again."
done

useradd -m -G wheel -s /bin/bash "$username"

cat > /etc/wsl.conf << EOF
[user]
default=$username
EOF

repos=/home/$username/repos
mkdir $repos
git clone https://github.com/bigdru/dotfiles $repos/dotfiles
pushd $repos/dotfiles
git remote set-url origin git@github.com:bigdru/dotfiles
popd

git clone https://github.com/bigdru/scripts $repos/scripts
pushd $repos/dotfiles
git remote set-url origin git@github.com:bigdru/scripts
popd

mkdir /home/$username/.ssh
chmod 700 /home/$username/.ssh
chown --recursive $username:$username /home/$username/

echo
echo

echo "Set main user password"
echo "----------------------"
passwd "$username"
echo
echo

echo "Setup complete"
echo "=============="
echo "From windows run:"
echo "wsl --shutdown"
echo "wsl -s archlinux"
echo "wsl"
echo
echo "It is recommended to copy your id_rsa to the .ssh directory and chmod it to 600"
echo "Then the following in linux:"
echo "cd ~/repos/scripts"
echo "./setup.sh"
