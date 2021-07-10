#!/bin/bash

echo "Updating system" 
sudo apt-get update -y
echo "Installers"
sudo apt-get install curl wget -y
echo "Packages managers"
sudo apt-get install nodejs pip npm -y
echo "Support editors"
sudo apt-get install neovim -y
echo "Editor text"
sudo snap install --classic code
echo "Complements"
sudo apt-get install openssh-server -y

clear
 
echo -n "Do you use a laptop? [y/n]: "
read latop
if [[ "$laptop" == "y" ]];
then
	sudo apt install touchegg -y
fi

clear

echo -n "Don you want to use stack (L)inux (A)pache (M)ySQL (P)HP? [y/n]: "
read latop
if [[ "$laptop" == "y" ]];
then
	sudo apt update
	sudo apt install libapache2-mod-php apache2 mysql-server php php-cli php-mbstring -y
	curl -sS https://getcomposer.org/installer -o composer-setup.php
	echo "HASH=544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061" >> .bashrc
	echo "HASH=544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061" >> .zshrc
	sudo mysql_secure_installation
	sudo ufw app list
	echo -n "¿Usar Apache por defecto? [y/n]: "
	read apache
	if [[ "$apache" == "y" ]];
	then
		sudo ufw allow 'Apache'
	fi
fi

clear

echo -n "Do you want to change your shell? (Oh-my-zsh)[y/n]: "
read res
if [[ "$res" == "y" ]];
then
	# Installing fonts
	wget -P ~/.local/share/fonts https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
	wget -P ~/.local/share/fonts https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
	wget -P ~/.local/share/fonts https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
	wget -P ~/.local/share/fonts https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
	fc-cache -f -v
	
	# Installing oh-my-zsh
	sudo apt-get install zsh fzf -y
	rm -rf /home/$USER/.oh-my-zsh
	wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
	chsh -s `which zsh`

	# Installing powerlevel10k
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
	
	# Commands Highlighting
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	
	# Auto suggestions
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	
	# Auto complete for paths
	git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git
	cd zsh-autocomplete
	source zsh-autocomplete.plugin.zsh
	cd ..
	mv zsh-autocomplete ~/.oh-my-zsh/custom/plugins
	sudo apt-get install zsh-autosuggestions -y
	
	# Better ls
	wget mirrors.kernel.org/ubuntu/pool/universe/r/rust-exa/exa_0.9.0-4_amd64.deb
	sudo dpkg -i exa_0.9.0-4_amd64.deb
	rm -rf exa_0.9.0-4_amd64.deb
	git clone https://github.com/DarrinTisdale/zsh-aliases-exa ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-aliases-exa
	
	# Getting zsh configuration
	cat zsh_configuration > ~/.zshrc
fi

# Docker

clear

echo -n "Do you want to install docker?[y/n]: "
read docker

if [[ "$docker" == "y" ]];
	then
		echo "[1] Using docker repository (Recommended)"
		echo "[2] Using deb packages "
		read medio_de_instalacion
fi

if [[ "$medio_de_instalacion" == "1" ]];
	then
		sudo apt-get remove docker docker-engine docker.io containerd runc -y
		sudo apt-get update y && sudo apt update -y
		sudo apt install apt-transport-https ca-certificates software-properties-common -y
		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
		sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
		
		sudo apt update -y
		apt-cache policy docker-ce
		sudo apt install docker-ce -y

		sudo usermod -aG docker ${USER}
		su - ${USER}
else
	if [ $distro -eq "focal" ];
		then
			wget https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/docker-scan-plugin_0.8.0~ubuntu-focal_amd64.deb
			wget https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/docker-ce_20.10.7~3-0~ubuntu-focal_amd64.deb
			wget https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/docker-ce_19.03.15~3-0~ubuntu-focal_amd64.deb
			wget https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/docker-ce-rootless-extras_20.10.7~3-0~ubuntu-focal_amd64.deb
			wget https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/docker-ce-cli_20.10.7~3-0~ubuntu-focal_amd64.deb
			wget https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/docker-ce-cli_19.03.15~3-0~ubuntu-focal_amd64.deb
			wget https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/containerd.io_1.4.6-1_amd64.deb
	fi
	if [ $distro -eq "groovy" ];
		then
			wget https://download.docker.com/linux/ubuntu/dists/groovy/pool/stable/amd64/docker-scan-plugin_0.8.0~ubuntu-groovy_amd64.deb
			wget https://download.docker.com/linux/ubuntu/dists/groovy/pool/stable/amd64/docker-ce_20.10.7~3-0~ubuntu-groovy_amd64.deb
			wget https//download.docker.com/linux/ubuntu/dists/groovy/pool/stable/amd64/docker-ce-rootless-extras_20.10.7~3-0~ubuntu-groovy_amd64.deb
			wget https://download.docker.com/linux/ubuntu/dists/groovy/pool/stable/amd64/docker-ce-cli_20.10.7~3-0~ubuntu-groovy_amd64.deb
			wget https://download.docker.com/linux/ubuntu/dists/groovy/pool/stable/amd64/containerd.io_1.4.6-1_amd64.deb 
	fi
	if [ $distro -eq "bionic" ]; 
		then
			wget https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/containerd.io_1.4.6-1_amd64.deb
			wget https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/docker-ce-cli_20.10.7~3-0~ubuntu-bionic_amd64.deb
			wget https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/docker-ce-rootless-extras_20.10.7~3-0~ubuntu-bionic_amd64.deb
			wget https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/docker-ce_20.10.7~3-0~ubuntu-bionic_amd64.deb
			wget https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/docker-scan-plugin_0.8.0~ubuntu-bionic_amd64.deb
	fi
	sudo dpkg -i *.deb
fi

# Creating docker group
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

# Starting service
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

