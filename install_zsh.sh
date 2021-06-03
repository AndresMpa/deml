#!/bin/bash

sudo apt-get update
sudo apt-get install curl

sh -c '$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)'

# Mejor ls
wget mirrors.kernel.org/ubuntu/pool/universe/r/rust-exa/exa_0.9.0-4_amd64.deb
sudo dpkg -i exa_0.9.0-4_amd64.deb
cd .oh-my-zsh/custom/plugins
git clone https://github.com/DarrinTisdale/zsh-aliases-exa

# Resalto de comandos
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


# Sugenrecias automaticas
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions


# Completado inteligente de rutas
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git
cd zsh-autocomplete
source zsh-autocomplete.plugin.zsh
cd ..
mv zsh-autocomplete ~/.oh-my-zsh/custom/plugins
sudo apt-get install zsh-autosuggestions -y

cat zsh_configuration > ~/.zshrc
