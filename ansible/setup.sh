#!/bin/bash

# REPLACE amd64 with the machine's CPU arch if not amd64
sudo apt install ansible
wget https://github.com/semaphoreui/semaphore/releases/download/v2.12.14/semaphore_2.12.14_linux_amd64.deb
sudo dpkg -i semaphore_2.12.14_linux_amd64.deb

semaphore setup
sudo mkdir -p /var/lib/semaphore/
sudo cp config.json /var/lib/semaphore/semaphore_config.json
sudo chown -R ldstn:ldstn /var/lib/semaphore/

sudo cp semaphore.service /etc/systemd/system/semaphore.service
sudo systemctl daemon-reload
sudo systemctl enable semaphore
sudo systemctl start semaphore
