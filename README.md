# Automated Secondary Backup System

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## About the Author

Hi, I'm Girma Wakeyo. I'm passionate about system automation and cloud technologies, and enjoy creating tools that enhance data security and reliability.

This project provides a reliable and automated solution for backing up specific archive folders from an OVH server to a secondary backup server hosted on AWS. The system uses `rsync` over SSH for secure and efficient file transfer, and `cron` for automated scheduling.

## Features

* **Selective Backup:** Backs up only designated "archive folders" from the OVH server.
* **Secure Transfer:** Uses SSH with key-based authentication for secure data transfer.
* **Automated Scheduling:** Backups are automated using `cron`.
* **Robust Logging:** Logs the backup process and any errors encountered.
* **Easy Configuration:** Simple configuration variables for customization.

## Architecture

The system utilizes two EC2 instances on AWS:

* **OVH Server Replacement:** Simulates the OVH server and hosts the archive folders.
* **Secondary Backup Server:** Stores the backup copies of the archive folders.

The backup process is initiated from a local machine, which connects to the EC2 instances via SSH to execute the `rsync` command.

## Prerequisites

* An AWS account with two EC2 instances running a Linux distribution (e.g., Ubuntu, Amazon Linux).
* SSH access to both EC2 instances.
* An SSH key pair generated on your local machine.
* `rsync` installed on both EC2 instances.

## Setup

1.  **Configure AWS Environment:**
    * Launch two EC2 instances as described above.
    * Create security groups to allow SSH access (port 22) to the instances.
    * Note the private IP addresses of both instances.

2.  **Generate SSH Key Pair:**
    * On your local machine, generate an SSH key pair:
        ```bash
        ssh-keygen -t rsa -b 4096 -C "yourgmail@.com"
        ```
    * Add the public key to the `~/.ssh/authorized_keys` file on both EC2 instances.

3.  **Set up Archive Folders (on the "OVH Server" EC2 instance):**
    * Create the directories for your archive folders:
        ```bash
        mkdir -p /path/to/archive/folders/archive_folder1
        mkdir -p /path/to/archive/folders/archive_folder2
        #... more archive folders
        ```
    * Populate these folders with your data.

4.  **Configure the Backup Script (`backup_script.sh`):**
    * Update the following variables in the script:
        * `OVH_SERVER_IP`: Private IP address of the "OVH Server" EC2 instance.
        * `BACKUP_SERVER_IP`: Private IP address of the "Secondary Backup Server" EC2 instance.
        * `ARCHIVE_FOLDERS_PATH`: Path to the archive folders on the "OVH Server" instance.
        * `BACKUP_DESTINATION`: Path to the backup destination on the "Secondary Backup Server" instance.
        * `LOG_FILE`: Path to the log file on your local machine.
    * Modify the `rsync` command to include/exclude the desired archive folders.
    * **The script is provided within the instructions of part 4 of the setup section.**

5.  **Schedule the Backup with Cron:**
    * Open your crontab: `crontab -e`
    * Add a line to schedule the backup script. For example, to run the backup daily at 2:00 AM:
        ```
        0 2 * * * /path/to/backup_script.sh
        ```

## Usage

1.  **Configure the script** as described in the Setup section.
2.  **Make the script executable:** `chmod +x backup_script.sh`
3.  **Run the script manually:** `./backup_script.sh`
4.  **Monitor the log file (`backup.log`)** for backup status and any errors.

## Security

* **Restrict SSH access:** Configure security groups to allow SSH access only from trusted IP addresses.
* **Use strong passwords or SSH keys:** Avoid using weak passwords for your EC2 instances.
* **Regularly review security settings:** Ensure your AWS security settings are up-to-date.

## Technologies Used

[![Bash](https://img.shields.io/badge/-Bash-black?style=flat-square&logo=gnu-bash)](https://www.gnu.org/software/bash/)
[![rsync](https://img.shields.io/badge/-rsync-black?style=flat-square&logo=rsync)](https://rsync.samba.org/)
[![SSH](https://img.shields.io/badge/-SSH-black?style=flat-square&logo=openssh)](https://www.openssh.com/)
[![Cron](https://img.shields.io/badge/-Cron-black?style=flat-square&logo=cron)](https://en.wikipedia.org/wiki/Cron)
[![AWS](https://img.shields.io/badge/Amazon%20AWS-232F3E?style=flat-square&logo=amazon-aws)](https://aws.amazon.com/)
[![Linux](https://img.shields.io/badge/-Linux-black?style=flat-square&logo=linux)](https://www.linux.org/)

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License

[MIT](https://www.google.com/url?sa=E&source=gmail&q=https://choosealicense.com/licenses/mit/)
