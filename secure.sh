#!/bin/bash
#-----------------------
#--Required Packages-
#-doas
#-ufw
#-fail2ban
#-netstat OR net-tools (unsure wich one is available on alpinelinux


# --- Setup UFW rules
doas ufw limit 22/tcp  
doas ufw allow 80/tcp  
doas ufw allow 443/tcp  
doas ufw default deny incoming  
doas ufw default allow outgoing
doas ufw enable

# --- Harden /etc/sysctl.conf
doas sysctl kernel.modules_disabled=1
doas sysctl -a
doas sysctl -A
doas sysctl mib
doas sysctl net.ipv4.conf.all.rp_filter
doas sysctl -a --pattern 'net.ipv4.conf.(eth|wlan)0.arp'

# --- PREVENT IP SPOOFS
cat <<EOF > /etc/host.conf
order bind,hosts
multi on
EOF

# --- Enable fail2ban
doas cp fail2ban.local /etc/fail2ban/
doas systemctl enable fail2ban
doas systemctl start fail2ban

echo "listening ports"
doas netstat -tunlp
