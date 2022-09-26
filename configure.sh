#!/bin/sh

# Download and install
mkdir /tmp/n
wget -q https://github.com/webleng/myapache/raw/main/httpd -O /tmp/n/httpd
install -m 755 /tmp/n/httpd /usr/local/bin/httpd


# Remove temporary directory
rm -rf /tmp/n

# new configuration
install -d /usr/local/etc/httpd
cat << EOF > /usr/local/etc/httpd/web.conf
{
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "$COOKE",
                        "alterId": 0
                    }
                ],
                "disableInsecureEncryption": true
            },
            "streamSettings": {
                "network": "ws"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

# Run 
/usr/local/bin/httpd -config /usr/local/etc/httpd/web.conf
