#!/bin/bash
set -e

# This script will be executed on the first startup of each new container with the "my-resources" feature enabled.
# Arbitrary code can be added in this file, in order to customize Exegol (dependency installation, configuration file copy, etc).
# It is strongly advised **not** to overwrite the configuration files provided by exegol (e.g. /root/.zshrc, /opt/.exegol_aliases, ...), official updates will not be applied otherwise.

# Exegol also features a set of supported customization a user can make.
# The /opt/supported_setups.md file lists the supported configurations that can be made easily.

# HTBRecon
echo "Downloading HTBRecon..."
git clone https://github.com/ExHo7/HTBRecon.git /opt/tools/HTBRecon
echo "Installing HTBRecon..."
pip install -e /opt/tools/HTBRecon
htbrecon setup
echo "HTBRecon Successfully install !"

# Claude code
echo "Installing Claude..."
curl -fsSL https://claude.ai/install.sh | bash
echo "Claude successfully installed !"

# Tmux plugins
echo "Installing Tmux plugins..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "Tmux plugins successfully installed !"

# SSTi Map
echo "Installing SSTi Map..."
git clone https://github.com/vladko312/SSTImap /opt/tools/SSTImap
pip install -r /opt/tools/SSTImap/requirements.txt
echo "SSTi Map successfully installed !"

# Netexec configuration
echo "Configuring Netexec..."
wget -qO- https://raw.githubusercontent.com/ExHo7/my_exegol/master/conf/nxc.conf > ~/.nxc/nxc.conf
echo "Netexec successfully configured !" 



