#!/bin/bash


# Check if user is running script with root privileges
if [ "$(id -u)" != "0" ]; then
  echo "This script must be run as root" >&2
  exit 1
fi



#COLORS
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



sudo apt-get update -y
sudo apt-get upgrade -y
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
sudo apt-get install -y unzip



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
    # Determine the latest version of Go
    VERSION=$(curl -s -L https://golang.org/VERSION?m=text)

    # Download the latest version of the Go binary distribution for Linux
    wget https://dl.google.com/go/$VERSION.linux-amd64.tar.gz

    # Extract the downloaded archive to ~/go
    tar -C ~/ -xzf $VERSION.linux-amd64.tar.gz

    # Add the Go binary directory to the PATH environment variable
    echo 'export PATH=$PATH:~/go/bin' >> ~/.bashrc
    echo 'export PATH=$PATH:~/go/bin' >> ~/.profile
    source ~/.bashrc

    # Verify that Go has been installed correctly
    go version
    # Remove the downloaded archive
    rm $VERSION.linux-amd64.tar.gz
    echo -e "${G}(+) Go has been successfully installed.${RST}"
else
    echo -e "${Y} Note: Go is already installed. ${RST}"
fi



echo -e "${Y}(+) Installing Nano${RST}"
sudo apt-get install nano -y
echo -e "${G}Done.${RST}"



echo -e "${Y}(+) Installing Httpx & Subfinder${RST}"
#install httpx
go install github.com/projectdiscovery/httpx/cmd/httpx@latest
#install subfinder
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
echo -e "${G}Done.${RST}"



echo -e "${Y}(+) Installing Amass${RST}"
go install github.com/OWASP/Amass/v3/...@master
echo -e "${G}Done.${RST}"



echo -e "${Y}(+) Installing FFUF${RST}"
go install github.com/ffuf/ffuf@latest
echo -e "${G}Done.${RST}"



echo -e "${Y}(+) Downloading Jhaddix content discovery wordlist${RST}"
cd ~/tools/SecLists/Discovery/Web-Content/
wget https://gist.githubusercontent.com/jhaddix/b80ea67d85c13206125806f0828f4d10/raw/c81a34fe84731430741e0463eb6076129c20c4c0/content_discovery_all.txt -O all_jhaddix.txt
echo -e "${G}Done.${RST}"



echo -e "${Y}(+) Downloading leaky-paths wordlist${RST}"
cd ~/tools/SecLists/Discovery/Web-Content/
wget https://raw.githubusercontent.com/ayoubfathi/leaky-paths/main/leaky-paths.txt -O leaky-paths.txt
echo -e "${G}Done.${RST}"

echo -e "${Y}(+) Downloading assetnote wordlists /ext ${$RST}"
mkdir ~/tools/SecLists/Discovery/Web-Content/ext
cd ~/tools/SecLists/Discovery/Web-Content/ext
wget https://wordlists-cdn.assetnote.io/data/manual/jsp.txt -O jsp.txt
wget https://wordlists-cdn.assetnote.io/data/manual/cfm.txt -O cfm.txt
wget https://wordlists-cdn.assetnote.io/data/manual/html.txt -O html.txt
wget https://wordlists-cdn.assetnote.io/data/manual/bak.txt -O bak.txt
wget https://wordlists-cdn.assetnote.io/data/manual/dot_filenames.txt -O dot_filenames.txt
wget https://wordlists-cdn.assetnote.io/data/manual/do.txt -O do.txt
wget https://wordlists-cdn.assetnote.io/data/manual/aspx_lowercase.txt -O aspx_lowercase.txt
wget https://wordlists-cdn.assetnote.io/data/manual/asp_lowercase.txt -O asp_lowercase.txt
wget https://wordlists-cdn.assetnote.io/data/manual/php.txt -O php.txt
wget https://wordlists-cdn.assetnote.io/data/manual/phpmillion.txt -O phpmillion.txt
wget https://wordlists-cdn.assetnote.io/data/manual/pl.txt -O pl.txt
wget https://wordlists-cdn.assetnote.io/data/manual/xml_filenames.txt -O xml_filenames.txt
echo -e "${G}Done.${RST}"

echo -e "${Y}(+) Installing nmap${RST}"
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



echo -e "\n\n\n\n\n\n\n\n\n\n\n ${G}Done! All tools are set up in ~/tools${RST}"
ls -la
