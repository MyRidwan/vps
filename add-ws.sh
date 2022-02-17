#!/bin/bash
grey='\x1b[90m'
red='\x1b[91m'
green='\x1b[92m'
yellow='\x1b[93m'
blue='\x1b[94m'
purple='\x1b[95m'
cyan='\x1b[96m'
white='\x1b[37m'
bold='\033[1m'
off='\x1b[m'
flag='\x1b[47;41m'

ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
COUNTRY=$(curl -s ipinfo.io/country )

MYIP=$(wget -qO- ipinfo.io/ip);
IZIN=$( curl https://myridwan.github.io/izin | grep $MYIP )
echo "Memeriksa Hak Akses VPS..."
if [ $MYIP = $IZIN ]; then
clear
echo -e "${green}Akses Diizinkan...${off}"
sleep 1
else
clear
echo -e "${red}Akses Diblokir!${off}"
echo "Hanya Untuk Pengguna Berbayar!"
echo "Silahkan Hubungi Admin wa.me/6285781385825"
exit 0
fi
clear
echo ""
read -p "Username: " user
read -p "Exp: " exp

if grep -qc "${user}" /etc/v2ray/config.json
then
        echo "Checking..."
        sleep 0.5
        echo -e "User Sudah Ada!"
        exit
else
        echo "Checking"
        echo -e "Oke lanjut"
fi
uuid="$(cat /proc/sys/kernel/random/uuid)"
client='"clients":'
clients='"clients"'
users='"$user"'
id='"id"'
aid='"alterId"'
uuids='"$uuid"'
ler='"'
aids='0'
path="$(grep -oP '(?<="path": ")[^"]*' /etc/v2ray/config.json)"
#domain="$(grep -oP '(?<="Host": ")[^"]*' /etc/v2ray/config.json)"
domain="$(cat /etc/v2ray/domain)"
MYIP=$(wget -qO- ipv4.icanhazip.com)
expp=$(date -d "$exp days" +"%d-%m-%Y")

#V2RAY NON TLS
sed -i "s/#default.*/#default\n\t #${user} $expp\n\t  {\n\t    $aid: $aids,\n\t    $id: $ler$uuid$ler\n\t  },\n\t #${user} $expp/" /etc/v2ray/config.json
sed -i "s/user/$user/" /etc/v2ray/data.json
sed -i "s/uuid/$uuid/" /etc/v2ray/data.json
sed -i "s+pathh+$path+" /etc/v2ray/data.json
sed -i "s/domain/$domain/" /etc/v2ray/data.json

#V2RAY TLS
sed -i "s/#default.*/#default\n\t #${user} $expp\n\t  {\n\t    $aid: $aids,\n\t    $id: $ler$uuid$ler\n\t  },\n\t #${user} $expp/" /etc/v2ray/tls.json
sed -i "s/user/$user/" /etc/v2ray/datatls.json
sed -i "s/uuid/$uuid/" /etc/v2ray/datatls.json
sed -i "s+pathh+$path+" /etc/v2ray/datatls.json
sed -i "s/domain/$domain/" /etc/v2ray/datatls.json
hasil=$(base64 /etc/v2ray/data.json | tr -d "\n")
hasil2=$(base64 /etc/v2ray/datatls.json | tr -d "\n")
echo -e "Processing..."
sleep 1
clear
echo -e "Success!"
echo -e "=========================="
echo -e "Ridwan VPN Configuration"
echo -e "=========================="
echo -e "Username : ${user}"
echo -e "Domain   : $domain"
echo -e "IP       : $MYIP"
echo -e "None TLS : 8880"
echo -e "TLS      : 445"
echo -e "UUID     : $uuid"
echo -e "AlterId  : 0"
echo -e "Security : Auto"
echo -e "TLS      : None & TLS"
echo -e "Path     : $path"
echo -e "Host     : None"
echo -e "Expired  : $expp"
echo -e "=========================="
echo -e "[NON TLS PORT 8880]"
echo -e "vmess://$hasil"
echo -e "=========================="
echo -e "[TLS PORT 445]"
echo -e "vmess://$hasil2"
echo -e "=========================="
echo -e "Terima Kasih Banyak"
echo -e "Premium Script Make by Ridwan"
figlet -f slant RIDWAN - STORE | lolcat
echo ""
#Pengulangan data.json
sed -i "s/$user/user/" /etc/v2ray/data.json
sed -i "s/$uuid/uuid/" /etc/v2ray/data.json
sed -i "s+$path+pathh+" /etc/v2ray/data.json
sed -i "s/$domain/domain/" /etc/v2ray/data.json
#Pengulangan tls.json
sed -i "s/$user/user/" /etc/v2ray/datatls.json
sed -i "s/$uuid/uuid/" /etc/v2ray/datatls.json
sed -i "s+$path+pathh+" /etc/v2ray/datatls.json
sed -i "s/$domain/domain/" /etc/v2ray/datatls.json

#Penambahan user v2ray
sed -i "s/#Username/#${user} $expp\n#Username/" /etc/v2ray/user.txt

systemctl restart v2ray
systemctl restart v2tls
