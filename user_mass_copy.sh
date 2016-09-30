#!/bin/bash
for i in `cat hosts.list`; do
        scp /tmp/nagios_home.tar.gz skosztka@$i:/tmp/.
        ssh -tt $i<<EOF
        echo "###############################################"
        hostname
        echo "###############################################"
        echo "Creating group nagios"
        sudo groupadd -g 5000 nagios
        echo "Creating user nagios"
        sudo useradd -d /home/nagios -g nagios -c "Monitoring user for nagios" -m -s /bin/bash -u 5000 nagios
        sudo cp /etc/sudoers /tmp/sudoers_bckp
        sudo /bin/su -c 'echo "" >> /etc/sudoers'
        sudo /bin/su -c 'echo "## Allow monitoring commands and helpers for the nagios user" >> /etc/sudoers'
        sudo /bin/su -c 'echo "nagios ALL           = (root)    NOPASSWD: /usr/lib/nagios_sudo_helpers/*" >> /etc/sudoers'
        sudo /bin/su -c 'echo "nagios ALL           = (root)    NOPASSWD: /bin/netstat -nltp" >> /etc/sudoers'
        echo "Extracting nagios home files"
        sudo tar -pPxvf /tmp/nagios_home.tar.gz
EOF
done
