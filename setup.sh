#!/bin/bash
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com);
clear
if [ -f "/etc/v2ray/domain" ]; then
echo "Script Already Installed"
exit 0
fi
mkdir /var/lib/premium-script;
echo "IP=" >> /var/lib/premium-script/ipvps.conf

#text
apt install boxes
sudo apt-get install ruby -y
sudo gem install lolcat
# Running screenfetch
cd
rm -rf /root/.bashrc
wget -O /root/.bashrc https://raw.githubusercontent.com/myridwan/vps/ipuk/.bashrc
#install cf
wget https://raw.githubusercontent.com/myridwan/vps/ipuk/cloudflare.sh && chmod +x cloudflare.sh && ./cloudflare.sh
#install ssh ovpn
wget https://raw.githubusercontent.com/myridwan/vps/ipuk/ssh-vpn.sh && chmod +x ssh-vpn.sh && ./ssh-vpn.sh
wget https://raw.githubusercontent.com/myridwan/vps/ipuk/sstp.sh && chmod +x sstp.sh && ./sstp.sh
#install ssr
wget https://raw.githubusercontent.com/myridwan/vps/ipuk/ssr.sh && chmod +x ssr.sh && ./ssr.sh
wget https://raw.githubusercontent.com/myridwan/vps/ipuk/sodosok.sh && chmod +x sodosok.sh && ./sodosok.sh
#installwg
wget https://raw.githubusercontent.com/myridwan/vps/ipuk/wireguard.sh && chmod +x wireguard.sh && ./wireguard.sh
#install v2ray
wget http://raw.githubusercontent.com/myridwan/vps/ipuk/install.sh && chmod +x install.sh && ./install.sh
#install L2TP
wget https://raw.githubusercontent.com/myridwan/vps/ipuk/ipsec.sh && chmod +x ipsec.sh && ./ipsec.sh
wget https://raw.githubusercontent.com/myridwan/vps/ipuk/set-br.sh && chmod +x set-br.sh && ./set-br.sh
#install WebsocketSSH
wget https://raw.githubusercontent.com/myridwan/vps/ipuk/inswssh.sh && chmod +x inswssh.sh && ./inswssh.sh
#install scrip bawaan
wget https://raw.githubusercontent.com/myridwan/vps/ipuk/add-ws.sh && chmod +x add-ws.sh && ./add-ws.sh
wget https://raw.githubusercontent.com/myridwan/vps/ipuk/add-vless.sh && chmod +x add-vless.sh && ./add-vless.sh
wget https://raw.githubusercontent.com/myridwan/vps/ipuk/add-tr.sh && chmod +x add-tr.sh && ./add-tr.sh
wget https://raw.githubusercontent.com/myridwan/vps/ipuk/del-ws.sh && chmod +x del-ws.sh && ./del-ws.sh
wget https://raw.githubusercontent.com/myridwan/vps/ipuk/del-vless.sh && chmod +x del- vless.sh && ./del-vless.sh
wget https://raw.githubusercontent.com/myridwan/vps/ipuk/del-tr.sh && chmod +x del-vless.sh && ./del-vless.sh
wget https://raw.githubusercontent.com/myridwan/vps/ipuk/cek-ws.sh && chmod +x cek-ws.sh && ./cek-ws.sh
wget https://raw.githubusercontent.com/myridwan/vps/ipuk/cek-vless.sh && chmod +x cek-vless.sh ./cek-vless.sh
wget https://raw.githubusercontent.com/myridwan/vps/ipuk/cek-tr.sh && chmod +x cek-tr.sh && ./cek-tr.sh
wget https://raw.githubusercontent.com/myridwan/vps/ipuk/renew-ws.sh && chmod +x renew-ws.sh && ./renew-ws.sh
wget https://raw.githubusercontent.com/myridwan/vps/ipuk/renew-vless.sh && chmod +x renew-vless.sh && ./renew-vless.sh
wget https://raw.githubusercontent.com/myridwan/vps/ipuk/renew-tr.sh && chmod +x renew-tr.sh && ./renew-tr.sh
wget https://raw.githubusercontent.com/myridwan/vps/ipuk/change.sh && chmod +x change.sh && ./change.sh
wget https://raw.githubusercontent.com/myridwan/vps/ipuk/port-ws.sh && chmod +x port-ws.sh && ./port-ws.sh
wget https://raw.githubusercontent.com/myridwan/vps/ipuk/port-vless.sh && chmod +x port-vless.sh && ./port-vless.sh
wget https://raw.githubusercontent.com/myridwan/vps/ipuk/port-wg.sh && chmod +x port-wg.sh && ./port-wg.sh
wget https://raw.githubusercontent.com/myridwan/vps/ipuk/port-tr.sh && chmod +x port-tr.sh && ./port-tr.sh
wget https://raw.githubusercontent.com/myridwan/vps/ipuk/cert.sh && chmod +x cert.sh && ./cert.sh
wget https://raw.githubusercontent.com/myridwan/vps/ipuk/vvt.sh && chmod +x vvt.sh && ./vvt.sh
wget https://raw.githubusercontent.com/myridwan/vps/ipuk/shadowsocks.sh && chmod +x shadowsocks.sh && ./shadowsocks.sh
wget https://raw.githubusercontent.com/myridwan/vps/ipuk/wireguard.sh && chmod +x wireguard.sh && ./wireguard.sh
wget https://raw.githubusercontent.com/myridwan/vps/ipuk/vvt-options.sh && chmod +x vvt-options.sh && ./vvt-options.sh
wget https://raw.githubusercontent.com/myridwan/vps/ipuk/update.sh && chmod +x update.sh && ./update.sh
# set time GMT +8
ln -fs /usr/share/zoneinfo/Asia/Manila /etc/localtime
# install webserver
apt -y install nginx
cd
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/myridwan/vps/ipuk/nginx.conf"
mkdir -p /home/vps/public_html
wget -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/myridwan/vps/ipuk/vps.conf"
/etc/init.d/nginx restart

echo "0 0 * * * root /sbin/reboot" > /etc/cron.d/reboot

#finish
rm -f /root/ssh-vpn.sh
rm -f /root/sstp.sh
rm -f /root/wireguard.sh
rm -f /root/sodosok.sh
rm -f /root/ssr.sh
rm -f /root/ins-vt.sh
rm -f /root/ipsec.sh
rm -f /root/set-br.sh
rm -f /root/inswssh.sh
rm -f /root/add-ws.sh
rm -f /root/add-vless.sh
rm -f /root/add-tr.sh
rm -f /root/del-ws.sh
rm -f /root/del-vless.sh
rm -f /root/cek-ws.sh
rm -f /root/cek-vless.sh
rm -f /root/cek-tr.sh
rm -f /root/renew-ws.sh
rm -f /root/renew-vless.sh
rm -f /root/renew-tr.sh
rm -f /root/change.sh
rm -f /root/port-ws.sh
rm -f /root/port-vless.sh
rm -f /root/port-wg.sh
rm -f /root/port-tr.sh
rm -f /root/cert.sh
rm -f /root/vvt.sh
rm -f /root/shadowsocks.sh
rm -f /root/wireguard.sh
rm -f /root/vvt-options.sh
rm -f /root/update.sh
cat <<EOF> /etc/systemd/system/autosett.service
[Unit]
Description=autosetting
Documentation=https://polarisvpn.tk

[Service]
Type=oneshot
ExecStart=/bin/bash /etc/set.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable autosett
wget -O /etc/set.sh "https://raw.githubusercontent.com/myridwan/vps/ipuk/set.sh"
chmod +x /etc/set.sh
history -c
echo "1.2" > /home/ver
clear
echo " "
echo "Installation has been completed!!"
echo " "
echo "=================================-Autoscript Premium-===========================" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "--------------------------------------------------------------------------------" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Service & Port"  | tee -a log-install.txt
echo "   - OpenSSH                 : 22"  | tee -a log-install.txt
echo "   - Websocket OpenSSH       : 80"  | tee -a log-install.txt
echo "   - OpenVPN                 : TCP 1194, UDP 2200, SSL 442"  | tee -a log-install.txt
echo "   - Stunnel4                : 443, 777"  | tee -a log-install.txt
echo "   - Dropbear                : 109, 143"  | tee -a log-install.txt
echo "   - Squid Proxy             : 3128, 8085 (limit to IP Server)"  | tee -a log-install.txt
echo "   - Badvpn                  : 7100, 7200, 7300"  | tee -a log-install.txt
echo "   - Nginx                   : 81"  | tee -a log-install.txt
echo "   - Wireguard               : 7070"  | tee -a log-install.txt
echo "   - L2TP/IPSEC VPN          : 1701"  | tee -a log-install.txt
echo "   - PPTP VPN                : 1732"  | tee -a log-install.txt
echo "   - SSTP VPN                : 444"  | tee -a log-install.txt
echo "   - Shadowsocks-R           : 1443-1543"  | tee -a log-install.txt
echo "   - SS-OBFS TLS             : 2443-2543"  | tee -a log-install.txt
echo "   - SS-OBFS HTTP            : 3443-3543"  | tee -a log-install.txt
echo "   - V2RAY Vmess TLS         : 8443"  | tee -a log-install.txt
echo "   - V2RAY Vmess None TLS    : 8880"  | tee -a log-install.txt
echo "   - V2RAY Vless TLS         : 2083"  | tee -a log-install.txt
echo "   - V2RAY Vless None TLS    : 8880"  | tee -a log-install.txt
echo "   - Trojan                  : 2087"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Server Information & Other Features"  | tee -a log-install.txt
echo "   - Timezone                : Asia/Jakarta (GMT +7)"  | tee -a log-install.txt
echo "   - Fail2Ban                : [ON]"  | tee -a log-install.txt
echo "   - Dflate                  : [ON]"  | tee -a log-install.txt
echo "   - IPtables                : [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot             : [ON]"  | tee -a log-install.txt
echo "   - IPv6                    : [OFF]"  | tee -a log-install.txt
echo "   - Autoreboot On 05.00 GMT +7" | tee -a log-install.txt
echo "   - Auto Delete Expired Account" | tee -a log-install.txt
echo "   - Full Orders For Various Services" | tee -a log-install.txt
echo "   - White Label" | tee -a log-install.txt
echo "   - Installation Log --> /root/log-install.txt"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   - Dev/Main                : ridwan"  | tee -a log-install.txt
echo "   - Telegram                : T.me/Rifan_aje"  | tee -a log-install.txt
echo "   - Whatsapp                : 085781385825"  | tee -a log-install.txt
echo "------------------Script Created By Ridwan-----------------" | tee -a log-install.txt
echo ""
rm -f setup.sh