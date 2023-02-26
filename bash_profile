eprofile(){
nano ~/.bash_profile
}

sprofile(){
source ~/.bash_profile
}

dirsearch(){
cd ~/tools/dirsearch
if [ -n "$3" ];then
python3 dirsearch.py -u $1 -e $2 -w $3 -t 200 -H 'X-FORWARDED-FOR: 127.0.0.1'
else
python3 dirsearch.py -u $1 -e $2 -t 200 -H 'X-FORWARDED-FOR: 127.0.0.1'
fi
}

httpx(){
#-p 9000,9300,8443,8000,8080,443
httpx -follow-redirects -title -content-length -status-code -ports $1
}

subfinder(){
subfinder -d $1 -all -cs
}

amass(){
amass enum -brute -d $1 -o $2 -v
}

crtsh(){
curl -s https://crt.sh/\?q\=%.$1\&output\=json | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u
}
