#!/bin/bash
set -e
# Update and install required packages
sudo apt-get update
sudo apt-get install -y \
    wget \
    xz-utils \
    libncursesw6 \
    software-properties-common \
    cmake \
    make \
    git
# Add deadsnakes PPA and install python3.8 + distutils
sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt-get update
sudo apt-get install -y python3.8 python3.8-distutils
# Set python3.8 as default python3
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1
# Download and extract arm-none-eabi-gcc toolchain
wget -O arm-gnu-toolchain.tar.xz "https://developer.arm.com/-/media/Files/downloads/gnu/13.2.rel1/binrel/arm-gnu-toolchain-13.2.rel1-x86_64-arm-none-eabi.tar.xz?rev=e434b9ea4afc4ed7998329566b764309&hash=CA590209F5774EE1C96E6450E14A3E26"
sudo tar -xf arm-gnu-toolchain.tar.xz -C /opt/
rm arm-gnu-toolchain.tar.xz
# Download and extract Renode
wget https://github.com/renode/renode/releases/download/v1.15.0/renode-1.15.0.linux-portable.tar.gz
sudo tar -xzvf renode-1.15.0.linux-portable.tar.gz -C /opt/
rm renode-1.15.0.linux-portable.tar.gz
# Add toolchain and Renode to PATH (add to ~/.bashrc for persistence)
echo 'export PATH=/opt/arm-gnu-toolchain-13.2.Rel1-x86_64-arm-none-eabi/bin:/opt/renode_1.15.0_portable:$PATH' >> ~/.bashrc
export PATH=/opt/arm-gnu-toolchain-13.2.Rel1-x86_64-arm-none-eabi/bin:/opt/renode_1.15.0_portable:$PATH
# Install Bazelisk (renamed bazel)
wget https://github.com/bazelbuild/bazelisk/releases/download/v1.25.0/bazelisk-linux-amd64
chmod +x bazelisk-linux-amd64
sudo mv bazelisk-linux-amd64 /usr/local/bin/bazel

echo "Setup completed. Please restart your terminal or run 'source ~/.bashrc' to update PATH."
