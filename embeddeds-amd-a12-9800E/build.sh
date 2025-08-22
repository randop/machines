#!/bin/bash
# Script to set up and build a Linux system for AMD Ryzen Embedded V1000 using Yocto Project (whinlatter branch)

# Step 1: Install required packages (Ubuntu/Debian-based systems)
echo "Installing required packages..."
sudo apt-get update
sudo apt-get install -y gawk wget git diffstat unzip texinfo gcc build-essential chrpath socat cpio \
  python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-git python3-jinja2 \
  libegl1-mesa libsdl1.2-dev pylint xterm python3-subunit mesa-common-dev zstd liblz4-tool

# Step 2: Set up Yocto branch
YOCTO_BRANCH="whinlatter"
echo "Using Yocto branch: $YOCTO_BRANCH"

# Step 3: Clone necessary repositories
echo "Cloning Poky and required layers..."
git clone --single-branch --branch "$YOCTO_BRANCH" git://git.yoctoproject.org/poky poky-amd-$YOCTO_BRANCH
cd poky-amd-$YOCTO_BRANCH
git clone --single-branch --branch "$YOCTO_BRANCH" git://git.openembedded.org/meta-openembedded
git clone --single-branch --branch "$YOCTO_BRANCH" git://git.yoctoproject.org/meta-amd

# Step 4: Initialize build environment
echo "Initializing build environment..."
source oe-init-build-env build-amd-v1000-$YOCTO_BRANCH

# Step 5: Configure local.conf for AMD Ryzen Embedded V1000
echo "Configuring local.conf..."
cat <<EOF >conf/local.conf
MACHINE = "v1000"
DISTRO = "poky-amd"
DL_DIR ?= "\${TOPDIR}/../downloads"
SSTATE_DIR ?= "\${TOPDIR}/../sstate-cache"
BB_HASHSERVE_UPSTREAM = "wss://hashserv.yoctoproject.org/ws"
SSTATE_MIRRORS ?= "file://.* http://sstate.yoctoproject.org/all/PATH;downloadfilename=PATH"
BB_HASHSERVE = "auto"
BB_SIGNATURE_HANDLER = "OEEquivHash"
EOF

# Step 6: Add layers to bblayers.conf
echo "Adding layers to bblayers.conf..."
bitbake-layers add-layer ../meta-openembedded/meta-oe
bitbake-layers add-layer ../meta-openembedded/meta-python
bitbake-layers add-layer ../meta-openembedded/meta-networking
bitbake-layers add-layer ../meta-amd/meta-amd-distro
bitbake-layers add-layer ../meta-amd/meta-amd-bsp

# Step 7: Start the build
echo "Starting build for core-image-sato..."
bitbake core-image-sato -k

# Step 8: Instructions for deployment
echo "Build complete! Images are located in tmp/deploy/images/v1000/"
echo "To create a bootable USB, use: sudo bmaptool copy tmp/deploy/images/v1000/core-image-sato-v1000.wic /dev/<usb-device>"
echo "To simulate using QEMU: runqemu qemux86-64"
