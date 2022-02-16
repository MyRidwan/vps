#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com);
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
echo "Silahkan Hubungi Admin"
exit 0
fi
clear
echo "Checking VPS"
clear
echo "-------------------------------";
echo "---=[ SS - OBFS User Login ]=---";
echo "-------------------------------";
echo ""
data=( `cat /etc/shadowsocks-libev/akun.conf | grep '^###' | cut -d ' ' -f 2`);
x=1
echo "-------------------------------";
echo " User | TLS"
echo "-------------------------------";
for akun in "${data[@]}"
do
port=$(cat /etc/shadowsocks-libev/akun.conf | grep '^port_tls' | cut -d ' ' -f 2 | tr '\n' ' ' | awk '{print $'"$x"'}')
jum=$(netstat -anp | grep ESTABLISHED | grep obfs-server | cut -d ':' -f 2 | grep -w $port | awk '{print $2}' | sort | uniq | nl)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
echo " $akun - $port"
echo "$jum";
echo "-------------------------------"
fi
x=$(( "$x" + 1 ))
done
data=( `cat /etc/shadowsocks-libev/akun.conf | grep '^###' | cut -d ' ' -f 2`);
x=1
echo ""
echo "-------------------------------";
echo " User |  HTTP"
echo "-------------------------------";
for akun in "${data[@]}"
do
port=$(cat /etc/shadowsocks-libev/akun.conf | grep '^port_http' | cut -d ' ' -f 2 | tr '\n' ' ' | awk '{print $'"$x"'}')
jum=$(netstat -anp | grep ESTABLISHED | grep obfs-server | cut -d ':' -f 2 | grep -w $port | awk '{print $2}' | sort | uniq | nl)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
echo " $akun - $port"
echo "$jum";
echo "-------------------------------"
fi
x=$(( "$x" + 1 ))
done
