# ArchLinux Laptop

### Prerequisites
- A USB drive (8GB or larger).
- A computer with UEFI firmware.
- An existing Linux system or a live Linux environment to prepare the USB.
- Arch Linux ISO (download from [archlinux.org](https://archlinux.org/download/)).
- Basic familiarity with Linux terminal commands.

### Step-by-Step Guide

1. **Download and Verify Arch Linux ISO**
   - Download the latest Arch Linux ISO from [archlinux.org](https://archlinux.org/download/).
   - Verify the ISO's integrity using the provided checksum:
     ```bash
     sha256sum archlinux-<version>-x86_64.iso
     ```
     Compare the output with the checksum on the website.

2. **Create a Bootable USB**
   - Identify your USB drive (e.g., `/dev/sdX`) using:
     ```bash
     lsblk
     ```
     Replace `sdX` with your USB device (e.g., `sdb`). **Be careful** to select the correct device to avoid data loss.
   - Write the ISO to the USB:
     ```bash
     sudo dd bs=4M if=archlinux-<version>-x86_64.iso of=/dev/sdX status=progress oflag=sync
     ```
   - Wait for the process to complete (it may take a few minutes).

3. **Boot from the USB**
   - Insert the USB into the target computer.
   - Enter the UEFI/BIOS settings (usually by pressing a key like F2, F12, or Del during boot).
   - Set the USB as the first boot device and ensure UEFI mode is enabled.
   - Boot into the Arch Linux live environment.

4. **Prepare the USB Drive for Installation**
   - In the live environment, identify the USB drive again with `lsblk`. It’s typically `/dev/sdX`.
   - Use `cfdisk` to partition the USB:
     ```bash
     sudo cfdisk /dev/sdX
     ```
     - Create a 512MB EFI System Partition (type: `EFI System`).
     - Create a root partition (e.g., 7GB or more, type: `Linux filesystem`).
     - (Optional) Create a swap partition (e.g., 1GB, type: `Linux swap`) if needed.
     - Write the partition table and exit.
   - Format the partitions:
     ```bash
     sudo mkfs.fat -F32 /dev/sdX1  # EFI partition
     sudo mkfs.ext4 /dev/sdX2      # Root partition
     sudo mkswap /dev/sdX3         # Swap (if created)
     sudo swapon /dev/sdX3
     ```
   - Mount the partitions:
     ```bash
     sudo mount /dev/sdX2 /mnt
     sudo mkdir /mnt/boot
     sudo mount /dev/sdX1 /mnt/boot
     ```

5. **Install the Base System**
   - Install the base system and necessary packages:
     ```bash
     sudo pacstrap /mnt base linux linux-firmware
     ```
   - Generate the fstab file:
     ```bash
     genfstab -U /mnt >> /mnt/etc/fstab
     ```
   - Check `/mnt/etc/fstab` to ensure the partitions are correctly listed.

6. **Configure the System**
   - Chroot into the new system:
     ```bash
     arch-chroot /mnt
     ```
   - Set the timezone:
     ```bash
     ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
     hwclock --systohc
     ```
   - Configure locale:
     - Edit `/etc/locale.gen`, uncomment your desired locale (e.g., `en_US.UTF-8 UTF-8`).
     - Run:
       ```bash
       locale-gen
       echo "LANG=en_US.UTF-8" > /etc/locale.conf
       ```
   - Set the hostname:
     ```bash
     echo "arch-usb" > /etc/hostname
     ```
     Add to `/etc/hosts`:
     ```bash
     echo "127.0.0.1 localhost" >> /etc/hosts
     echo "::1       localhost" >> /etc/hosts
     echo "127.0.1.1 arch-usb.localdomain arch-usb" >> /etc/hosts
     ```
   - Set the root password:
     ```bash
     passwd
     ```

7. **Install and Configure the rEFInd Bootloader **
   - Install rEFInd:
     ```bash
     pacman -S refind
     ```
   - Setup rEFInd for UEFI on boot device:
     ```bash
     refind-install --root /mnt
     ```
     ```

8. **Install Additional Tools (Optional)**
   - Install a network manager for connectivity:
     ```bash
     pacman -S networkmanager
     systemctl enable NetworkManager
     ```
   - Install tools
   ```sh
     pacman -S vim nano btop htop lm_sensors
   ```

9. **Exit and Unmount**
   - Exit the chroot:
     ```bash
     exit
     ```
   - Unmount partitions:
     ```bash
     umount -R /mnt
     swapoff /dev/sdX3  # If swap was used
     ```
   - Remove the USB and reboot.

10. **Boot and Test**
    - Boot from the USB on the target machine, ensuring UEFI mode is enabled.
    - Log in as root and verify the system works.
    - Connect to the internet (e.g., `nmcli` for NetworkManager) and update the system:
      ```bash
      pacman -Syu
      ```

## Post-Installation

1. Firewall
```bash
pacman -S ufw
systemctl enable --now ufw
ufw enable
```

2. SSH client
```bash
pacman -S openssh
systemctl disable sshd
systemctl mask sshd
```

3. Desktop environment
```bash
pacman -S base-devel \
  git \
  libx11 \
  libxft \
  libxinerama \
  xorg-server \
  xorg-xinit \
  xorg-xdm \
  xorg-xrandr \
  xorg-xwininfo \
  xorg-xsetroot

mkdir /projects
cd /projects

git clone git://git.suckless.org/st
cd st
cp -v config.def.h config.h
make
make clean install

cd /projects
git clone git://git.suckless.org/dmenu
cd dmenu
cp -v config.def.h config.h
make
make clean install

cd /projects
git clone git://git.suckless.org/dwm
cd dwm
cp -v config.def.h config.h
make
make clean install

systemctl enable --now xdm
```

4. Shell
```bash
export PATH=$PATH:~/.local/bin
export TERM=xterm-256color
pacman -S fish
usermod -s /usr/bin/fish randolph

# login my account
su -l randolph

# import completions
curl -LsSf https://raw.githubusercontent.com/zx2c4/password-store/refs/heads/master/src/completion/pass.fish-completion > ~/.config/fish/completions/pass.fish-completion
echo 'uv generate-shell-completion fish | source' > ~/.config/fish/completions/uv.fish
echo 'pnpm completion fish | source' > ~/.config/fish/completions/pnpm.fish
```

