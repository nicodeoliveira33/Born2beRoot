#!/bin/bash

arch=$(uname -a)

pcpu=$(grep "physical id" /proc/cpuinfo | sort -u | wc -l)

vcpu=$(grep -c ^processor /proc/cpuinfo)

ram_total=$(free -m | grep Mem | awk '{print $2}')
ram_use=$(free -m | grep Mem | awk '{print $3}')
ram_percent=$(free -m | grep Mem | awk '{printf("%.2f"), $3/$2*100}')

disk_total=$(df -Bg | grep '^/dev/' | grep -v '/boot$' | awk '{ft += $2} END {print ft}')
disk_use=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{ut += $3} END {print ut}')
disk_percent=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{ut += $3} {ft += $2} END {printf("%d"), ut/ft*100}')

cpul=$(top -bn1 | grep Cpu | awk '{printf("%.1f%%"), $2 + $4}')

lb=$(who -b | awk '{print $3 " " $4}')

lvmu=$(if [ $(lsblk | grep "lvm" | wc -l) -eq 0 ]; then echo "no"; else echo "yes"; fi)

tcpc=$(ss -ta | grep ESTAB | wc -l)

ulog=$(users | wc -w)

ip=$(hostname -I | awk '{print $1}')
mac=$(ip link show | grep ether | awk '{print $2}')

cmnd=$(journalctl _COMM=sudo | grep COMMAND | wc -l)

wall "	#Architecture: $arch
	#CPU physical : $pcpu
	#vCPU : $vcpu
	#Memory Usage: $ram_use/${ram_total}MB ($ram_percent%)
	#Disk Usage: $disk_use/${disk_total}Gb ($disk_percent%)
	#CPU load: $cpul
	#Last boot: $lb
	#LVM use: $lvmu
	#Connections TCP : $tcpc ESTABLISHED
	#User log: $ulog
	#Network: IP $ip ($mac)
	#Sudo : $cmnd cmd"
