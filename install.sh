#!/bin/bash
#Install Variable

rm -r /etc/v2ray
echo "Mulai install v2ray | Mod by RIDWAN VPN..."
sleep 3s
mkdir /etc/v2ray
clear
echo -e "Pastikan domain sudah dipersiapkan untuk v2ray"
read -p "Domain: " domain
echo "$domain" >> /etc/v2ray/domain

#Make installation for v2ray
#Thanks to Jhrory
source <(curl -sL https://raw.githubusercontent.com/myridwan/scssh/ipuk/modul/v2ray.sh)
pathh="$(cat /etc/v2ray/path.txt)"
timedatectl set-timezone Asia/Jakarta

#Ubah Config bawaan
rm /etc/v2ray/config.json
clear

cd /etc/v2ray && wget https://raw.githubusercontent.com/myridwan/scssh/ipuk/modul/data.json
cd /etc/v2ray && wget https://raw.githubusercontent.com/myridwan/scssh/ipuk/modul/datatls.json
cd /etc/v2ray && wget https://raw.githubusercontent.com/myridwan/scssh/ipuk/modul/user.txt
cd /etc/v2ray && wget https://raw.githubusercontent.com/myridwan/scssh/ipuk/modul/usertrojan.txt
#Set V2ray
mkdir /root/.acme.sh
curl https://raw.githubusercontent.com/myridwan/scssh/ipuk/modul/acme.sh -o /root/.acme.sh/acme.sh
chmod +x /root/.acme.sh/acme.sh
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/v2ray/v2ray.crt --keypath /etc/v2ray/v2ray.key --ecc
uuid=$(cat /proc/sys/kernel/random/uuid)
cat> /etc/v2ray/config.json << END
{
  "log": {
    "access": "/var/log/v2ray/access.log",
    "loglevel": "info",
    "error": "/var/log/v2ray/error.log"
  },
  "outbounds": [
    {
      "settings": {},
      "protocol": "freedom"
    },
    {
      "settings": {},
      "tag": "blocked",
      "protocol": "blackhole"
    }
  ],
  "inbounds": [
    {
      "protocol": "vmess",
      "port": 8880,
      "settings": {
        "clients": [
         #default
          {
            "alterId": 0,
            "id": "${uuid}"
          }
        ]
      },
      "streamSettings": {
        "kcpSettings": {},
        "quicSettings": {},
        "network": "ws",
        "security": "none",
        "httpSettings": {},
        "wsSettings": {
          "path": "/DrgTech",
          "headers": {
            "Host": "$domain"
          }
        },
        "tcpSettings": {},
        "tlsSettings": {}
      }
    }
  ],
  "routing": {
    "rules": [
      {
        "outboundTag": "blocked",
        "ip": [
          "0.0.0.0/8",
          "10.0.0.0/8",
          "100.64.0.0/10",
          "169.254.0.0/16",
          "172.16.0.0/12",
          "192.0.0.0/24",
          "192.0.2.0/24",
          "192.168.0.0/16",
          "198.18.0.0/15",
          "198.51.100.0/24",
          "203.0.113.0/24",
          "::1/128",
          "fc00::/7",
          "fe80::/10"
        ],
        "type": "field"
      }
    ]
  }
}
END
cat> /etc/v2ray/tls.json << END
{
  "log": {
    "access": "/var/log/v2ray/access.log",
    "error": "/var/log/v2ray/error.log",
    "loglevel": "info"
  },
  "inbounds": [
    {
      "port": 445,
      "protocol": "vmess",
      "settings": {
        "clients": [
         #default
          {
            "alterId": 0,
            "id": "${uuid}"
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "security": "tls",
        "tlsSettings": {
          "certificates": [
            {
              "certificateFile": "etc/v2ray/v2ray.crt",
              "keyFile": "/etc/v2ray/v2ray.key"
            }
          ]
        },
        "wsSettings": {
          "path": "/DrgTech",
          "headers": {
            "Host": "$domain"
          }
         },
        "quicSettings": {},
        "sockopt": {
          "mark": 0,
          "tcpFastOpen": true
        }
      },
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      },
      "domain": "$domain"
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    },
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    }
  ],
  "routing": {
    "rules": [
      {
        "type": "field",
        "ip": [
          "0.0.0.0/8",
          "10.0.0.0/8",
          "100.64.0.0/10",
          "169.254.0.0/16",
          "172.16.0.0/12",
          "192.0.0.0/24",
          "192.0.2.0/24",
          "192.168.0.0/16",
          "198.18.0.0/15",
          "198.51.100.0/24",
          "203.0.113.0/24",
          "::1/128",
          "fc00::/7",
          "fe80::/10"
        ],
        "outboundTag": "blocked"
      },
      {
        "type": "field",
        "outboundTag": "blocked",
        "protocol": [
          "bittorrent"
        ]
      }
    ]
  }
}
END
cat> /etc/v2ray/trojan.json << END
{
  "log": {
    "access": "/var/log/v2ray/access.log",
    "error": "/var/log/v2ray/error.log",
    "loglevel": "info"
  },
  "inbounds": [
    {
      "port": 446,
      "protocol": "trojan",
      "settings": {
        "clients": [
         #default
          {
            "password": "oEhqyW8D"
          }
        ],
        "fallbacks": [
          {
            "dest": 80
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "tls",
        "tlsSettings": {
          "certificates": [
            {
              "certificateFile": "etc/v2ray/v2ray.crt",
              "keyFile": "/etc/v2ray/v2ray.key"
            }
          ],
          "alpn": [
            "http/1.1"
          ]
        },
        "tcpSettings": {},
        "kcpSettings": {},
        "wsSettings": {},
        "httpSettings": {},
        "quicSettings": {}
      },
      "domain": "${domain}"
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    },
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    }
  ],
  "routing": {
    "rules": [
      {
        "type": "field",
        "ip": [
          "0.0.0.0/8",
          "10.0.0.0/8",
          "100.64.0.0/10",
          "169.254.0.0/16",
          "172.16.0.0/12",
          "192.0.0.0/24",
          "192.0.2.0/24",
          "192.168.0.0/16",
          "198.18.0.0/15",
          "198.51.100.0/24",
          "203.0.113.0/24",
          "::1/128",
          "fc00::/7",
          "fe80::/10"
        ],
        "outboundTag": "blocked"
      }
    ]
  }
}
END

rm /etc/datadiri.conf
curl ipinfo.io >> /etc/datadiri.conf

#Make service tls
cat> /etc/systemd/system/v2tls.service << END
[Unit]
Description=V2Ray TLS Service
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/v2ray/v2ray -config /etc/v2ray/tls.json
Restart=on-failure

[Install]
WantedBy=multi-user.target
END

#Make Service Trojan
cat> /etc/systemd/system/trojan.service << END
[Unit]
Description=Trojan Service
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/v2ray/v2ray -config /etc/v2ray/trojan.json
Restart=on-failure

[Install]
WantedBy=multi-user.target
END

#Membuat script berjalan di cronjob


systemctl disable v2ray && systemctl enable v2ray && systemctl restart v2ray
systemctl disable v2tls && systemctl enable v2tls && systemctl restart v2tls
systemctl disable trojan && systemctl enable trojan && systemctl restart trojan

printf '\n#Screenfetch\nif [ -f /usr/bin/menu ]; then menu; fi' >> /root/.bashrc

#Startup
clear
echo -e "Starting System"
echo -e "Scrip By Ridwan"
sleep 2s
echo -e "Done!"
