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
