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
apt-get install -y software-properties-common
add-apt-repository universe
apt-get update
sudo apt-get install -y python3-pip python-setuptools git rename unzip curl tor whois docker.io libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev build-essential libgmp-dev zlib1g-dev build-essential libssl-dev libffi-dev libldns-dev libcurl4-openssl-dev libssl-dev ruby-full jq 


# Function to print error message and exit
print_error() {
    echo -e "${R}Error: $1${RST}" >&2
    exit 1
}

# Function to print success message
print_success() {
    echo -e "${G}Success: $1${RST}"
}

echo -e "${B}[*]${RST} Installing Bash Profile${RST}"
cat bash_profile >> ~/.bash_profile
source ~/.bash_profile
mkdir ~/tools
echo -e "${G}Done.${RST}"


echo -e "${B}[*]${RST} Downloading Seclists${RST}"
cd ~/tools/
git clone https://github.com/danielmiessler/SecLists.git
cd ~/tools/SecLists/Discovery/DNS/
##THIS FILE BREAKS MASSDNS AND NEEDS TO BE CLEANED
cat dns-Jhaddix.txt | head -n -14 > clean-jhaddix-dns.txt
cd ~/tools/
echo -e "${G}Done.${RST}"


echo -e "${B}[*]${RST} Installing Sublime${RST}"
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
    VERSION=$(curl -s -L https://golang.org/VERSION?m=text | head -n 1)

    # Download the latest version of the Go binary distribution for Linux
    wget https://dl.google.com/go/$VERSION.linux-amd64.tar.gz

    # Extract the downloaded archive to ~/go
    tar -C /usr/local -xzf $VERSION.linux-amd64.tar.gz

    # Add the Go binary directory to the PATH environment variable
    echo 'export PATH=$PATH:/usr/local/go/bin' >> /etc/profile
    export PATH=$PATH:/usr/local/go/bin

    # Verify that Go has been installed correctly
    go version
    # Remove the downloaded archive
    rm $VERSION.linux-amd64.tar.gz
    echo -e "${G}(+) Go has been successfully installed.${RST}"
else
    echo -e "${Y} Note: Go is already installed. ${RST}"
fi

# Install Python packages
echo -e "$BLUE[*]$RESET Installing Python packages...$RESET"
pip3 install --user -U requests requests[socks] || print_error "Failed to install Python packages"
pip3 install --user -U webtech || print_error "Failed to install webtech"
pip3 install --user shodan || print_error "Failed to install shodan"
print_success "[+] Python packages have been successfully installed"

echo -e "${B}[*]${RST} Installing Nano${RST}"
sudo apt-get install nano -y
echo -e "${G}Done.${RST}"

# Install theHarvester
echo -e "$BLUE[*]$RESET Installing TheHarvester...$RESET"
git clone https://github.com/laramies/theHarvester.git /tmp/theharvester || print_error "Failed to clone theHarvester repository"
cd /tmp/theharvester || print_error "Failed to change directory to theharvester"
python3 -m pip install --user -r requirements.txt || print_error "Failed to install theHarvester dependencies"
mv theHarvester.py /usr/local/bin/theharvester || print_error "Failed to move theHarvester executable"
chmod +x /usr/local/bin/theharvester || print_error "Failed to set execute permissions for theharvester"
print_success "[+] TheHarvester has been successfully installed"

echo -e "${B}[*]${RST} Installing Amass${RST}"
go install -v github.com/owasp-amass/amass/v4/...@master
echo -e "${G}Done.${RST}"

echo -e "${B}[*]${RST} Downloading Jhaddix content discovery wordlist${RST}"
cd ~/tools/SecLists/Discovery/Web-Content/
wget https://gist.githubusercontent.com/jhaddix/b80ea67d85c13206125806f0828f4d10/raw/c81a34fe84731430741e0463eb6076129c20c4c0/content_discovery_all.txt -O all_jhaddix.txt
echo -e "${G}Done.${RST}"

echo -e "${B}[*]${RST} Downloading leaky-paths wordlist${RST}"
cd ~/tools/SecLists/Discovery/Web-Content/
wget https://raw.githubusercontent.com/ayoubfathi/leaky-paths/main/leaky-paths.txt -O leaky-paths.txt
echo -e "${G}Done.${RST}"

echo -e "${B}[*]${RST} Downloading assetnote wordlists /ext ${$RST}"
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

# Install Go packages
echo -e "$B[*]$RST Installing Go packages...$RST"
GO111MODULE=on go install "github.com/lc/gau@latest" || print_error "Failed to install gau"
go install -v "github.com/projectdiscovery/katana/cmd/katana@latest" || print_error "Failed to install katana"
go install -v "github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest" || print_error "Failed to install subfinder"
go install -v "github.com/projectdiscovery/dnsx/cmd/dnsx@latest" || print_error "Failed to install dnsx"
go install -v "github.com/projectdiscovery/tlsx/cmd/tlsx@latest" || print_error "Failed to install tlsx"
go install -v "github.com/ffuf/ffuf/v2@latest" || print_error "Failed to install ffuf"
go install -v "github.com/projectdiscovery/httpx/cmd/httpx@latest" || print_error "Failed to install httpx"
go install -v "github.com/owasp-amass/amass/v4/...@master"
ln -fs /root/go/bin/katana /usr/bin/katana || print_error "Failed to link katana"
ln -fs /root/go/bin/subfinder /usr/bin/subfinder || print_error "Failed to link subfinder"
ln -fs /root/go/bin/dnsx /usr/bin/dnsx || print_error "Failed to link dnsx"
ln -fs /root/go/bin/tlsx /usr/bin/tlsx || print_error "Failed to link tlsx"
ln -fs /root/go/bin/ffuf /usr/bin/ffuf || print_error "Failed to link ffuf"
ln -fs /root/go/bin/httpx /usr/bin/httpx || print_error "Failed to link httpx"
ln -fs /root/go/bin/amass /usr/bin/amass || print_error "Failed to link amass"
print_success "[+] Go packages have been successfully installed"

echo -e "${B}[*]${RST} Installing nmap${RST}"
sudo apt-get install nmap -y || print_error "Failed to install nmap"
echo -e "${G}Done.${RST}"


echo -e "${B}[*]${RST} Installing nuclei & templates${RST}"
cd ~/tools
git clone https://github.com/projectdiscovery/nuclei-templates || print_error "Failed to install Nuclei-templates"
go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest || print_error "Failed to install Nuclei"
echo -e "${G}Done.${RST}"

echo -e "${B}[*]${RST} Installing BBOT X_X"
cd ~/tools
git clone https://github.com/blacklanternsecurity/bbot || print_error "Failed to install BBOT"



echo -e "${Y}Git Configrations${RST}"
echo -e "${G}[Git Config]${RST} user.email: "
read git_email
echo -e "${G}[Git Config]${RST} user.name: "
read git_name
git config --global user.email "${git_email}"
git config --global user.name "${git_name}"
echo -e "${G}done${RST}"



echo -e "$G[*]$RST Success! [$G✓$RST]"
echo -e "$G[*]$RST All components have been successfully installed and configured [$G✓$RST]"
ls -la
