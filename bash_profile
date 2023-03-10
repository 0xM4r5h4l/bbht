eprofile(){
nano ~/.bash_profile
}

sprofile(){
source ~/.bash_profile
}

subf(){
if [[ $# -eq 3 ]];then
subfinder -d "$1" -o "$2" -silent -all -cs
else
echo "ex: subf test.example.com subf-out.txt"
fi
}


crtsh(){
curl -s https://crt.sh/\?q\=%.$1\&output\=json | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u
}
