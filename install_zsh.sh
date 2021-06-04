#!/bin/bash

sudo apt-get update
sudo apt-get zsh install curl wget

# Instalar oh-my-zsh
rm -rf /home/andresmpa/.oh-my-zsh
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
chsh -s `which zsh`

# Instalar powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k


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
rm -rf exa_0.9.0-4_amd64.deb
git clone https://github.com/DarrinTisdale/zsh-aliases-exa
mv zsh-aliases-exa .oh-my-zsh/custom/plugins

cat zsh_configuration > ~/.zshrc

# Docker

clear

medio_de_instalacion=2

echo "¿Como quieres instalar docker?:"
echo "1) Mediante respositorio"
echo "2) Mediante paquete"

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
		
		distro="lsb_release -cs"
		sudo apt-get install docker-ce=$distro docker-ce-cli=$distro containerd.io
else

	if [ $distro == "focal" ];
	then
		wget https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/docker-scan-plugin_0.8.0~ubuntu-focal_amd64.deb
		wget https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/docker-ce_20.10.7~3-0~ubuntu-focal_amd64.deb
		wget https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/docker-ce_19.03.15~3-0~ubuntu-focal_amd64.deb
		wget https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/docker-ce-rootless-extras_20.10.7~3-0~ubuntu-focal_amd64.deb
		wget https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/docker-ce-cli_20.10.7~3-0~ubuntu-focal_amd64.deb
		wget https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/docker-ce-cli_19.03.15~3-0~ubuntu-focal_amd64.deb
		wget https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/containerd.io_1.4.6-1_amd64.deb
	fi
	if [ $distro == "groovy" ];
	then
		wget https://download.docker.com/linux/ubuntu/dists/groovy/pool/stable/amd64/docker-scan-plugin_0.8.0~ubuntu-groovy_amd64.deb
		wget https://download.docker.com/linux/ubuntu/dists/groovy/pool/stable/amd64/docker-ce_20.10.7~3-0~ubuntu-groovy_amd64.deb
		wget https://download.docker.com/linux/ubuntu/dists/groovy/pool/stable/amd64/docker-ce-rootless-extras_20.10.7~3-0~ubuntu-groovy_amd64.deb
		wget https://download.docker.com/linux/ubuntu/dists/groovy/pool/stable/amd64/docker-ce-cli_20.10.7~3-0~ubuntu-groovy_amd64.deb
		wget https://download.docker.com/linux/ubuntu/dists/groovy/pool/stable/amd64/containerd.io_1.4.6-1_amd64.deb 
	fi
	if [ $distro == "bionic" ]; 
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

echo "Listo, si todo salio bien ahora debes tener un ambiante completo con el servicio de docker. Puedes modificar los plugins de zsh en esta ruta: 'code ~/.zshrc' \nPuede interesar estos links:"

# Probando la instalación de docerk
sudo docker run hello-world

help_after_install="
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
https://docs.docker.com/engine/install/linux-postinstall/#configuring-remote-access-with-systemd-unit-file
"
