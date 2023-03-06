eprofile(){
nano ~/.bash_profile
}

sprofile(){
source ~/.bash_profile
}

subfinder(){
subfinder -d $1 -all -cs
}

crtsh(){
curl -s https://crt.sh/\?q\=%.$1\&output\=json | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u
}
