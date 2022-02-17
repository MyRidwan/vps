##upgrade
clear
echo Installing Websocket-SSH Python
sleep 1
echo Check Access Rights...
sleep 0.5
apt-get update
apt-get upgrade -y
cd
cd /etc/systemd/system/
wget -O /etc/systemd/system/ws-openssh.service https://raw.githubusercontent.com/myridwan/vps/ipuk/ws-openssh.service
cd
cd /etc/systemd/system/
wget -O /etc/systemd/system/ws-openssh.service https://raw.githubusercontent.com/myridwan/vps/ipuk/ws-dropbear.service
cd
cd /etc/systemd/system/
wget -O /etc/systemd/system/ws-openssh.service https://raw.githubusercontent.com/myridwan/vps/ipuk/ws-tls.service
cd
cd /usr/local/bin/
#Install Script Websocket-SSH Python
wget -O /usr/local/bin/ws-openssh https://raw.githubusercontent.com/myridwan/vps/ipuk/ws-openssh.py
chmod +x /usr/local/bin/ws-openssh
wget -O /etc/systemd/system/ws-openssh.service https://raw.githubusercontent.com/myridwan/vps/ipuk/ws-dropbear.py
chmod +x /usr/local/bin/ws-dropbear
wget -O /etc/systemd/system/ws-openssh.service https://raw.githubusercontent.com/myridwan/vps/ipuk/ws-tls.py
chmod +x /usr/local/bin/ws-tls
##Screen
apt-get install screen -y
##python install
apt-get install python -y

cd
systemctl daemon-reload
#Enable & Start & Restart ws-openssh service
systemctl enable ws-openssh.service
systemctl enable ws-dropbear.service
systemctl enable ws-tls.service
systemctl start ws-openssh.service
systemctl start ws-dropbear.service
systemctl start ws-tls.service
systemctl restart ws-openssh.service
systemctl restart ws-dropbear.service
systemctl restart ws-tls.service