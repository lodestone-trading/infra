#!/bin/bash

ARCH=$(uname -m)

# Determine if it's amd64 or arm64
case "$ARCH" in
    x86_64)
        aarch="amd64"
        ;;
    aarch64)
        aarch="arm64"
        ;;
    arm64)
        aarch="arm64"
        ;;
    *)
        echo "Unknown architecture: $ARCH"
        echo "This script only detects amd64 and arm64 architectures"
        exit 1
        ;;
esac

HOME_DIR="/home/ldstn"
WORKING_DIR="/home/ldstn/gitea"
mkdir -p $WORKING_DIR
cd $WORKING_DIR
sudo apt update && sudo apt upgrade

echo "[GiteaSetup] Creating encrypted directories..."
sudo mkdir -p /var/lib/gitea/{custom,data,log}
sudo chown -R git:git /var/lib/gitea/
sudo chmod -R 750 /var/lib/gitea/
sudo mkdir /etc/gitea
sudo chown root:git /etc/gitea
sudo chmod 770 /etc/gitea
sudo apt-get install ecryptfs-utils
sudo mount -t ecryptfs /etc/gitea/ /etc/gitea/
sudo mount -t ecryptfs /var/lib/gitea/ /var/lib/gitea/

echo "[GiteaSetup] Creating user `git`..."
sudo adduser    --system    --shell /bin/bash    --gecos 'Git Version Control'    --group    --disabled-password    --home /home/git    git
sudo -u git mkdir -p /home/git/.ssh/
sudo chown -R git:git /home/git/
sudo chown -R git:git /home/git/.ssh/

echo "[GiteaSetup] Installing dependencies..."
sudo apt install git postgresql postgresql-contrib prometheus

echo "[GiteaSetup] Downloading Gitea..."
wget https://dl.gitea.com/gitea/1.24-nightly/gitea-1.24-nightly-linux-$aarch
mv gitea-1.24-nightly-linux-$aarch gitea
chmod +x gitea
sudo cp gitea /usr/local/bin/gitea

echo "[GiteaSetup] Configuring Gitea..."
sudo cp ./etc/systemd/system/gitea.service /etc/systemd/system/gitea.service
read -p "Enter PostgreSQL password for user git: " passwd
sed -i -e "s/PASSWORD/$passwd/g" app.ini
sudo cp ./etc/gitea/app.ini /etc/gitea/app.ini
sudo chmod +x /usr/local/bin/gitea

echo "[GiteaSetup] Setting up SSL certificates..."
sudo update-ca-certificates

echo "[GiteaSetup] Configuring PostgreSQL..."
sudo cp postgresql.conf /etc/postgresql/15/main/postgresql.conf
sudo cp pg_hba.conf /etc/postgresql/15/main/pg_hba.conf
sudo systemctl enable postgresql
sudo systemctl restart postgresql

echo "[GiteaSetup] NOTES"
echo "Manually run `sudo systemctl start gitea` after mounting encrypted directories to start Gitea"
