# Scripts Repository

This repository contains various setup and maintenance scripts for Linux environments, with a focus on WSL (Windows Subsystem for Linux) installations.

## Available Scripts


- `setup_arch.sh` - Initial Arch Linux WSL setup
- `setup.sh` - General system setup and configuration
- `git_update.sh` - Git version management and update script
- `nvim_install.sh` - Neovim installation with dependencies

## Installation and Setup

### Prerequisites
- Windows 10 or 11 with WSL enabled
- Arch Linux distribution installed via WSL

### Running the Arch Linux Setup Script

```bash
cd
curl -O https://raw.githubusercontent.com/bigdru/scripts/refs/heads/develop/setup_arch.sh
chmod +x setup_arch.sh
./setup_arch.sh
rm ./setup_arch.sh
```

This script will:
- Update the system and install essential packages (sudo, vi)
- Configure locale settings (en_CA.UTF-8 and en_US.UTF-8)
- Create a new user with sudo privileges (you will be prompted for the username)
- Configure WSL to start with the new user by default

After running the script, shutdown WSL from Windows:
```powershell
wsl --shutdown
```

Then set Arch Linux as the default distribution (if not already):
```powershell
wsl --set-default Arch
```

And restart WSL:
```powershell
wsl
```

You will now be logged in as the new user.


## Additional Setup

After the initial Arch Linux setup, you may want to run the `setup.sh` script to configure your dotfiles and install additional software.

## Script Details

- `git_update.sh`: Manages Git installation and updates, building from source if needed

- `nvim_install.sh`: Installs Neovim with fzf dependency from system packages
- `setup.sh`: Configures dotfiles and sets up development environment

## Contributing

Feel free to submit issues and enhancement requests for additional distribution support or improvements to the setup process.
