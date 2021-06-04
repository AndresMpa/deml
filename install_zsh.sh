#!/bin/bash

sudo apt-get update
sudo apt-get install curl

sh -c '$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)'


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

# Mejor ls
wget mirrors.kernel.org/ubuntu/pool/universe/r/rust-exa/exa_0.9.0-4_amd64.deb
sudo dpkg -i exa_0.9.0-4_amd64.deb
cd .oh-my-zsh/custom/plugins
git clone https://github.com/DarrinTisdale/zsh-aliases-exa

cat zsh_configuration > ~/.zshrc

# Docker

clear

medio_de_instalacion=2

echo "¿Como quieres instalar docker?: "
echo "\n1) Mediante respositorio \n2) Mediante paquete "

read medio_de_instalacion

if [ medio_de_instalacion == 1 ];
	then
		sudo apt-get remove docker docker-engine docker.io containerd runc
		sudo apt-get update
		sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release docker-ce docker-ce-cli containerd.io
		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
		echo \
		  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
		  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
		
		apt-cache madison docker-ce
		
		sudo apt-get install docker-ce=${lsb_release -cs} docker-ce-cli=${lsb_release -cs} containerd.io
else;

	if [ ${lsb_release -cs} == 'focal' ];
	then
		wget https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/docker-scan-plugin_0.8.0~ubuntu-focal_amd64.deb
		wget https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/docker-ce_20.10.7~3-0~ubuntu-focal_amd64.deb
		wget https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/docker-ce_19.03.15~3-0~ubuntu-focal_amd64.deb
		wget https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/docker-ce-rootless-extras_20.10.7~3-0~ubuntu-focal_amd64.deb
		wget https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/docker-ce-cli_20.10.7~3-0~ubuntu-focal_amd64.deb
		wget https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/docker-ce-cli_19.03.15~3-0~ubuntu-focal_amd64.deb
		wget https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/containerd.io_1.4.6-1_amd64.deb
	fi
	if [ ${lsb_release -cs} == 'groovy' ];
	then
		wget https://download.docker.com/linux/ubuntu/dists/groovy/pool/stable/amd64/docker-scan-plugin_0.8.0~ubuntu-groovy_amd64.deb
		wget https://download.docker.com/linux/ubuntu/dists/groovy/pool/stable/amd64/docker-ce_20.10.7~3-0~ubuntu-groovy_amd64.deb
		wget https://download.docker.com/linux/ubuntu/dists/groovy/pool/stable/amd64/docker-ce-rootless-extras_20.10.7~3-0~ubuntu-groovy_amd64.deb
		wget https://download.docker.com/linux/ubuntu/dists/groovy/pool/stable/amd64/docker-ce-cli_20.10.7~3-0~ubuntu-groovy_amd64.deb
		wget https://download.docker.com/linux/ubuntu/dists/groovy/pool/stable/amd64/containerd.io_1.4.6-1_amd64.deb 
	fi
	if [ ${lsb_release -cs} == 'bionic' ]; 
	then
		wget https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/containerd.io_1.4.6-1_amd64.deb
		wget https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/docker-ce-cli_20.10.7~3-0~ubuntu-bionic_amd64.deb
		wget https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/docker-ce-rootless-extras_20.10.7~3-0~ubuntu-bionic_amd64.deb
		wget https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/docker-ce_20.10.7~3-0~ubuntu-bionic_amd64.deb
		wget https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/docker-scan-plugin_0.8.0~ubuntu-bionic_amd64.deb
	fi
	sudo dpkg -i *.deb
fi

# Creando grupo docker
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

# Iniciando servicio
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

echo "Listo, si todo salio bien ahora debes tener un ambiante completo con el servicio de docker puede interesar este link: https://docs.docker.com/engine/install/linux-postinstall/#configuring-remote-access-with-systemd-unit-file"
		
# Probando la instalación de docerk
sudo docker run hello-world

help = "
ZSH

# Syntax
https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md

# Autosuggestion
https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh

Autocomplete
https://github.com/marlonrichert/zsh-autocomplete

Completions
https://github.com/zsh-users/zsh-completions

Docker
https://www.linux.com/topic/desktop/how-install-and-use-docker-linux/
https://docs.docker.com/engine/install/ubuntu/
"
