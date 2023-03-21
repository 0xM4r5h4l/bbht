eprofile(){
nano ~/.bash_profile
}

sprofile(){
source ~/.bash_profile
}

scan(){
if [[ $# -eq 2 ]];then
httpx -l "$1" -cl -sc -title -server -t 60 -p "$2"
else
echo "ex: scan domain-list.txt 80,443"
fi
}

subf(){
subfinder -d "$1" -silent -all -cs
}

crtsh(){
curl -s https://crt.sh/\?q\=%.$1\&output\=json | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u
}

common10="80,443,8080,8000,8443,8888,8008,9000,8010,8090,8009" # 10 most common ports for web http service
