#!/bin/bash
cd /usr/bin
wget -O limit-speed "https://raw.githubusercontent.com/myridwan/vps/ipuk/limit-speed.sh"
chmod +x limit-speed
cd
rm -f /root/set-br.sh

