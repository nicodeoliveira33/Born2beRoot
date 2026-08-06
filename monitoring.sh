#!/bin/bash

# 1. Arquitetura do SO e versão do Kernel
arch=$(uname -a)

# 2. CPUs Físicas
pcpu=$(grep "physical id" /proc/cpuinfo | sort -u | wc -l)

# 3. vCPUs (Processadores Virtuais)
vcpu=$(grep -c ^processor /proc/cpuinfo)

# 4. Memória RAM (Uso, Total e Percentagem)
ram_total=$(free -m | grep Mem | awk '{print $2}')
ram_use=$(free -m | grep Mem | awk '{print $3}')
ram_percent=$(free -m | grep Mem | awk '{printf("%.2f"), $3/$2*100}')

# 5. Disco Rígido (Uso, Total e Percentagem)
disk_total=$(df -Bg | grep '^/dev/' | grep -v '/boot$' | awk '{ft += $2} END {print ft}')
disk_use=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{ut += $3} END {print ut}')
disk_percent=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{ut += $3} {ft += $2} END {printf("%d"), ut/ft*100}')

# 6. Carga do CPU
cpul=$(top -bn1 | grep Cpu | awk '{printf("%.1f%%"), $2 + $4}')

# 7. Último Reboot
lb=$(who -b | awk '{print $3 " " $4}')

# 8. Estado do LVM
lvmu=$(if [ $(lsblk | grep "lvm" | wc -l) -eq 0 ]; then echo "no"; else echo "yes"; fi)

# 9. Conexões TCP Ativas
tcpc=$(ss -ta | grep ESTAB | wc -l)

# 10. Número de Utilizadores Logados
ulog=$(users | wc -w)

# 11. Endereço IP e MAC
ip=$(hostname -I | awk '{print $1}')
mac=$(ip link show | grep ether | awk '{print $2}')

# 12. Comandos executados com Sudo
cmnd=$(journalctl _COMM=sudo | grep COMMAND | wc -l)

# Impressão na tela via 'wall'
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