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
sudo apt-get install -y python-pip
sudo apt-get install -y python-dnspython
sudo apt-get install -y git
sudo apt-get install -y rename
sudo apt-get install -y xargs
sudo apt-get install unzip -y

#colors
Y='\e[1;33m'
G='\e[0;32m'
RST='\e[0m'



echo -e "${Y}installing bash_profile aliases ${RST}"
mkdir ~/tools
cd ~/tools
cat bash_profile >> ~/.bash_profile
source ~/.bash_profile
echo -e "${G}done${RST}"

echo -e "${Y}installing Dirsearch${RST}"
cd ~/tools
git clone https://github.com/maurosoria/dirsearch.git
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
sudo apt-get update
sudo apt-get install sublime-text
echo -e "${G}done${RST}"

echo -e "${Y}installing go${RST}"
sudo add-apt-repository ppa:longsleep/golang-backports -y
sudo apt-get update
sudo apt-get install golang-go -y
echo "export PATH=~/go/bin/:$PATH" >> ~/.bash_profile
source ~/.bash_profile
echo -e "${G}done${RST}"

echo -e "${Y}installing nano${RST}"
sudo apt-get install nano
echo -e "${G}done${RST}"

echo -e "${Y}installing httpx & subfinder${RST}"
sudo go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
sudo go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
echo -e "${G}done${RST}"

echo -e "${Y}installing feroxbuster${RST}"
curl -sL https://raw.githubusercontent.com/epi052/feroxbuster/master/install-nix.sh | bash
mv feroxbuster ~/go/bin/
echo -e "${G}done${RST}"

echo -e "${Y}installing Amass${RST}"
go install -v github.com/OWASP/Amass/v3/...@master
echo -e "${G}done${RST}"

echo -e "${Y}installing Assetfinder${RST}"
go get -u github.com/tomnomnom/assetfinder
echo -e "${G}done${RST}"

echo -e "${Y}installing ffuf${RST}"
cd ~/tools
git clone https://github.com/ffuf/ffuf ; cd ffuf ; go get ; go build
mv ffuf ~/go/bin/
echo -e "${G}done${RST}"

echo -e "${Y}installing Aquatone${RST}"
go get github.com/michenriksen/aquatone
echo -e "${G}done${RST}"

echo -e "${Y}downloading jhaddix content discovery wordlist${RST}"
cd ~/tools/SecLists/Discovery/Web-Content/
wget https://gist.githubusercontent.com/jhaddix/b80ea67d85c13206125806f0828f4d10/raw/c81a34fe84731430741e0463eb6076129c20c4c0/content_discovery_all.txt -O all_jhaddix.txt
echo -e "${G}done${RST}"

echo -e "${Y}installing nmap${RST}"
sudo apt-get install nmap -y
echo -e "${G}done${RST}"

echo -e "\n\n\n\n\n\n\n\n\n\n\n ${G}Done! All tools are set up in ~/tools${RST}"
ls -la
