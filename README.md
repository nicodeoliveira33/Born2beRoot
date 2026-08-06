# Born2beRoot - 42 School

## 📌 Overview
Born2beRoot is a system administration project from the 42 Common Core curriculum. The goal is to set up a secure, headless Debian server running inside a Virtual Machine with LVM partitioning, strict sudo security policies, SSH, firewall configurations, and automated system monitoring scripts.

## 🛠️ System Specifications
* **OS:** Debian 12 (Bookworm) 64-bit (Netinst)
* **Partitioning:** Encrypted / Standard LVM scheme (`/`, `/home`, `/var`, `/boot`, `/tmp`, `/var/log`, `swap`)
* **Services:** SSH (Port 4242), UFW Firewall, Cron Daemon
* **Security:** Password policy enforcement (`pam_pwquality`), Sudoers restrictions, Root SSH login disabled

## 📊 Monitoring Script
The `monitoring.sh` script runs every 10 minutes via `cron` to display system telemetry across all logged-in terminals.
