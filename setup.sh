#!/bin/bash
RED=`tput setaf 1`
GREEN=`tput setaf 2`
YELLOW=`tput setaf 3`
BLUE=`tput setaf 6`
RESET=`tput sgr0`

echo "${BLUE}══════════════════════════║Welcome to My script installer║═══════════════════════════${RESET}"

read -p "${GREEN}Do you want to ${RED}Update Your System?${GREEN}:${YELLOW} [y/N]${RESET}" update
read -p "${GREEN}Do you want to ${RED}Install git?${GREEN}:${YELLOW} [y/N]${RESET}" git

read -p "${GREEN}Do you want to ${RED}Install vim?${GREEN}:${YELLOW} [y/N]${RESET}" vim
read -p "${GREEN}Do you want to ${RED}Install openssh?${GREEN}:${YELLOW} [y/N]${RESET}" openssh

read -p "${GREEN}Do you want to ${RED}Install curl?${GREEN}:${YELLOW} [y/N]${RESET}" curl
read -p "${GREEN}Do you want to ${RED}Install lsb-release?${GREEN}:${YELLOW} [y/N]${RESET}" lsb
read -p "${GREEN}Do you want to ${RED}Install Docker?${GREEN}:${YELLOW} [y/N]${RESET}" docker
read -p "${GREEN}Do you want to Make docker run Without ${RED}sudo${GREEN}:${YELLOW} [y/N]${RESET}" makesudo
read -p "${GREEN}Do you want to ${RED}Install Docker Compose?${GREEN}:${YELLOW} [y/N]${RESET}" dockercomp

sleep 2

if [ "$update" == "y" ]
then
	echo "${RED} Updating System${RESET}"
	sudo apt-get update -y
	sudo apt-get upgrade -y
fi
if [ "$git" == "y" ]
then
	if ! [ -x "$(command -v git)" ]
	then
		echo "${GREEN} Installing ${BLUE}git${RESET}"
		sudo apt-get install git -y
	else
		echo "${BLUE}git${RED} already Installed${RESET}"
	fi
fi

if [ "$vim" == "y" ]
then
	if ! [ -x "$(command -v vim)" ]
	then
		echo "${GREEN} Installing ${BLUE}vim${RESET}"
		sudo apt-get install vim -y
	else
		echo "${BLUE}vim${RED} already Installed${RESET}"
	fi
fi

if [ "$openssh" == "y" ]
then
	if ! [ -x "$(systemctl status ssh)" ]
	then
		echo "${GREEN} Installing ${BLUE}openssh${RESET}"
		sudo apt-get install openssh-server -y
	else
		echo "${BLUE}openssh${RED} already Installed${RESET}"
	fi
		
fi

if [ "$curl" == "y" ]
then
	if ! [ -x "$(command -v curl)" ]
	then
		echo "${GREEN} Installing ${BLUE}curl${RESET}"
		sudo apt-get install ca-certificates  gnupg lsb-release curl -y
	else
		echo "${BLUE}curl${RED} already Installed${RESET}"
	fi
fi

if [ "$lsb" == "y" ]
then
	if ! [ -x "$(command -v lsb_release)" ]
	then
		echo "${GREEN} Installing ${BLUE}lsb${RESET}"
		sudo apt-get install lsb-release -y
	else
		echo "${BLUE}lsb${RED} already Installed${RESET}"
	fi
fi

if [ "$docker" == "y" ]
then
	if ! [ -x "$(command -v docker)" ]
	then
		echo "${GREEN} Installing ${BLUE}docker${RESET}"
		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
		echo "${GREEN}setting up the stable repository${RESET}"
    echo   "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    echo "${GREEN}Re-update The System${RESET}"
    sudo apt-get update -y
    echo "${GREEN}Installing ${BLUE}docker${RESET}"
    sudo apt-get install docker-ce docker-ce-cli containerd.io -y
    else
      echo "${BLUE}docker${RED} already Installed${RESET}"
    fi

fi

if [ "$makesudo" == "y" ]
then
	echo "${GREEN} Make docker run as ${BLUE} user${RESET}"
	if grep -q docker /etc/group
	then
		echo "${GREEN} The ${BLUE} Docker ${GREEN} Group already exists ${RESET}"
	else
		sudo groupadd docker
	fi
	sudo usermod -aG docker $USER
	sudo service docker restart
	echo "Please restart your machine to apply those changes"
fi

if [ "$dockercomp" == "y" ]
then
	if ! [ -x "$(command -v docker-compose)"]
	then
		echo "${GREEN}Downloading the current stable release of Docker Compose${RESET}"
		sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
		echo "${GREEN}Apply executable permissions to the binary${RESET}"
		sudo chmod +x /usr/local/bin/docker-compose
	else
		echo "${BLUE} docker-compose${RED} already installed ${RESET}"
	fi
fi

echo "${BLUE}Creating files for volumes${RESET}"
sudo -S mkdir -p ${HOME}/data/wp
sudo -S mkdir -p ${HOME}/data/db

#sudo -S systemctl restart docker
sudo -S hostnamectl

