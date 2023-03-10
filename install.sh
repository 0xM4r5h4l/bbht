#!/bin/bash
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
Y='\e[1;33m'
G='\e[0;32m'
RST='\e[0m'



echo -e "${Y}installing bash_profile aliases ${RST}"
cat bash_profile >> ~/.bash_profile
source ~/.bash_profile
mkdir ~/tools
echo -e "${G}done${RST}"

echo -e "${Y}downloading Seclists${RST}"
cd ~/tools/
git clone https://github.com/danielmiessler/SecLists.git
cd ~/tools/SecLists/Discovery/DNS/
##THIS FILE BREAKS MASSDNS AND NEEDS TO BE CLEANED
cat dns-Jhaddix.txt | head -n -14 > clean-jhaddix-dns.txt
cd ~/tools/
echo -e "${G}done${RST}"

echo -e "${Y}installing sublime-text${RST}"
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update -y
sudo apt-get install sublime-text -y
echo -e "${G}done${RST}"

echo -e "${Y}installing go${RST}"
sudo add-apt-repository ppa:longsleep/golang-backports -y
sudo apt-get update -y
sudo apt-get install golang-go -y
echo "export PATH=~/go/bin/:$PATH" >> ~/.bash_profile
source ~/.bash_profile
echo -e "${G}done${RST}"

echo -e "${Y}installing nano${RST}"
sudo apt-get install nano -y
echo -e "${G}done${RST}"

echo -e "${Y}installing httpx & subfinder${RST}"
#install subfinder
cd ~/tools
git clone https://github.com/projectdiscovery/subfinder; cd ~/tools/subfinder/v2/cmd/subfinder/ ; go build -v .
sudo mv ~/tools/subfinder/v2/cmd/subfinder/subfinder ~/go/bin/
#install httpx
cd ~/tools
git clone https://github.com/projectdiscovery/httpx; cd ~/tools/httpx/cmd/httpx/ ; go build -v .
sudo mv ~/tools/httpx/cmd/httpx/httpx ~/go/bin/
echo -e "${G}done${RST}"


echo -e "${Y}installing Amass${RST}"
go install -v github.com/OWASP/Amass/v3/...@master
echo -e "${G}done${RST}"


echo -e "${Y}installing ffuf${RST}"
cd ~/tools
git clone https://github.com/ffuf/ffuf ; cd ffuf ; go get ; go build
sudo mv ffuf ~/go/bin/
echo -e "${G}done${RST}"


echo -e "${Y}downloading jhaddix content discovery wordlist${RST}"
cd ~/tools/SecLists/Discovery/Web-Content/
wget https://gist.githubusercontent.com/jhaddix/b80ea67d85c13206125806f0828f4d10/raw/c81a34fe84731430741e0463eb6076129c20c4c0/content_discovery_all.txt -O all_jhaddix.txt
echo -e "${G}done${RST}"

echo -e "${Y}installing nmap${RST}"
sudo apt-get install nmap -y
echo -e "${G}done${RST}"

echo -e "${Y}Git Configrations${RST}"
echo -e "${G}[Git Config]${RST} user.email: "
read git_email
echo -e "${G}[Git Config]${RST} user.name: "
read git_name
git config --global user.email "${git_email}"
git config --global user.name "${git_name}"
echo -e "${G}done${RST}"

echo -e "\n\n\n\n\n\n\n\n\n\n\n ${G}Done! All tools are set up in ~/tools${RST}"
ls -la
