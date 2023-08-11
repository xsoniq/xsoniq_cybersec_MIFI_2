#!/bin/bash

# Backup HOME directory
tar cpf  /archive/home-backup-$(date  '+%d.%B.%Y_%H_%M').tar  /home

# Backup SSH Config File
tar cpf  /archive/ssh-backup-$(date  '+%d.%B.%Y_%H_%M').tar  /etc/ssh/sshd_config

# Backup RDP Config File
sudo tar cpf  /archive/xrdp-backup-$(date  '+%d.%B.%Y_%H_%M').tar  /etc/xrdp/xrdp.ini

# Backup FTP Config file
sudo tar cpf  /archive/vsftpd-backup-$(date  '+%d.%B.%Y_%H_%M').tar   /etc/vsftpd.conf

# Backup /var/log dir
sudo tar cpf  /archive/varlog-backup-$(date  '+%d.%B.%Y_%H_%M').tar   /var/log

# To delete files older than 30 days
find /archive/* -mtime +30 -delete