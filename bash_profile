eprofile(){
nano ~/.bash_profile
}

sprofile(){
source ~/.bash_profile
}

subf(){
subfinder -d "$1" -silent -all -cs
}


crtsh(){
curl -s https://crt.sh/\?q\=%.$1\&output\=json | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u
}
