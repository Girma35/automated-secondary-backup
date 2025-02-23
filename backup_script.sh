#!/bin/bash

# Configuration Variables
OVH_SERVER_IP="172.31.25.12"
BACKUP_SERVER_IP="171.225.102"
ARCHIVE_FOLDERS_PATH="/home/girma/Desktop/project/automated-secondary-backup/archive/folders/"
BACKUP_DESTINATION="/home/debian/backup/"
LOG_FILE="/home/girma/Desktop/project/automated-secondary-backup/backup.log" # Or a path on the EC2 instance

backup_archive_folders() {
    rsync -avz -e "ssh -i ~/.ssh/MyBackupServerKeyPair.pem" \
        --include="archive_folder1/" --include="archive_folder2/" --include="archive_folder3/" \
        --exclude="*" \
        debian@${OVH_SERVER_IP}:${ARCHIVE_FOLDERS_PATH} debian@${BACKUP_SERVER_IP}:${BACKUP_DESTINATION}

    if [ $? -eq 0 ]; then
        echo "$(date): Backup successful" >> ${LOG_FILE}
    else
        echo "$(date): Backup failed" >> ${LOG_FILE}
    fi
}


