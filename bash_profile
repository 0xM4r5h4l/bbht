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

kata(){
        if [[ $# -eq 1 ]];then
                katana -list "$1" -depth 5 -ct 3600 -mrs 10485760 -timeout 30 -retry 3 -jc -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
        else
                echo "Usage: katacrawl <urls>"
                echo "Ex: katacrawl https://example.com,https://test.com"
                echo "Ex: katacrawl https://example.com"
        fi
}

asnscan(){
        if [[ $# -eq 3 ]];then
                amass intel -asn "$1"
        else
		echo "ex: asnscan 19604"
        fi
}


common10='80,443,8080,8000,8443,8888,8008,9000,8010,8090,8009' # 10 most common ports for web http service
