#!/bin/bash

# Check if user is running script with root privileges
if [ "$(id -u)" != "0" ]; then
  echo "This script must be run as root" >&2
  exit 1
fi

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install git -y

sudo apt-get install -y libcurl4-openssl-dev
sudo apt-get install -y libssl-dev
sudo apt-get install -y jq
sudo apt-get install -y ruby-full
sudo apt-get install -y libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev build-essential libgmp-dev zlib1g-dev
sudo apt-get install -y build-essential libssl-dev libffi-dev python-dev
sudo apt-get install -y python-setuptools
sudo apt-get install -y libldns-dev
sudo apt-get install -y python3-pip
sudo apt-get install -y git
sudo apt-get install -y rename
sudo apt-get install unzip -y

#colors
# Define Bash color variables
RST='\033[0m'          # Reset all attributes
BOLD='\033[1m'           # Bold
UNDERLINE='\033[4m'      # Underline
R='\033[31m'           # Red
G='\033[32m'         # Green
Y='\033[33m'        # Yellow
B='\033[34m'          # Blue
M='\033[35m'       # Magenta
C='\033[36m'          # Cyan
WHITE='\033[37m'         # White
GRAY='\033[90m'          # Gray




echo -e "${Y}(+) Installing Bash Profile${RST}"
cat bash_profile >> ~/.bash_profile
source ~/.bash_profile
mkdir ~/tools
echo -e "${G}Done.${RST}"

echo -e "${Y}(+) Downloading Seclists${RST}"
cd ~/tools/
git clone https://github.com/danielmiessler/SecLists.git
cd ~/tools/SecLists/Discovery/DNS/
##THIS FILE BREAKS MASSDNS AND NEEDS TO BE CLEANED
cat dns-Jhaddix.txt | head -n -14 > clean-jhaddix-dns.txt
cd ~/tools/
echo -e "${G}Done.${RST}"

echo -e "${Y}(+) Installing Sublime${RST}"
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update -y
sudo apt-get install sublime-text -y
echo -e "${G}Done.${RST}"

#GO install
# Check if Go is installed
if ! command -v go &> /dev/null
then
    echo -e "${R}(-) Go is not installed. Installing now...${RST}"
    # Install Go
    apt-get update
    apt-get install -y golang
    # Add Go to the system path
    echo "echo export GOPATH=$HOME/go" >> ~/.bash_profile
    echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.bash_profile
    echo "export GO111MODULE=on" >> ~/.bash_profile
    source ~/.bash_profile
    echo -e "${G}(+) Go has been successfully installed.${RST}"
else
    echo "${Y}Note: Go is already installed.${RST}"
fi



echo -e "${Y}(+) Installing Nano${RST}"
sudo apt-get install nano -y
echo -e "${G}Done.${RST}"

echo -e "${Y}(+) Installing Httpx & Subfinder${RST}"
#install httpx
go install github.com/projectdiscovery/httpx/cmd/httpx@latest
#install subfinder
go install github.com/projectdiscovery/subfinder/cmd/subfinder@latest
echo -e "${G}Done.${RST}"


echo -e "${Y}(+) Installing Amass${RST}"
go install github.com/OWASP/Amass/v3/...@master
echo -e "${G}Done.${RST}"


echo -e "${Y}(+) Installing FFUF${RST}"
go install github.com/ffuf/ffuf@latest
echo -e "${G}Done.${RST}"


echo -e "${Y}Downloading jhaddix content discovery wordlist${RST}"
cd ~/tools/SecLists/Discovery/Web-Content/
wget https://gist.githubusercontent.com/jhaddix/b80ea67d85c13206125806f0828f4d10/raw/c81a34fe84731430741e0463eb6076129c20c4c0/content_discovery_all.txt -O all_jhaddix.txt
echo -e "${G}Done.${RST}"

echo -e "${Y}Installing nmap${RST}"
sudo apt-get install nmap -y
echo -e "${G}Done.${RST}"

echo -e "${Y}Git Configrations${RST}"
echo -e "${G}[Git Config]${RST} user.email: "
read git_email
echo -e "${G}[Git Config]${RST} user.name: "
read git_name
git config --global user.email "${git_email}"
git config --global user.name "${git_name}"
echo -e "${G}done${RST}"

trap 'echo "Error: Script failed at line $LINENO" >&2' ERR

echo -e "\n\n\n\n\n\n\n\n\n\n\n ${G}Done! All tools are set up in ~/tools${RST}"
ls -la
