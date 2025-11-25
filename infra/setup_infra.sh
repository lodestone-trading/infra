#!/bin/bash

# Assuming python3.11 install
sudo pip3 install torch torchvision --index-url https://download.pytorch.org/whl/cu130

cd ./mlflow
chmod +x setup.sh
bash setup.sh

cd ../ansible
chmod +x setup.sh
bash setup.sh

cd ../gitea
chmod +x setup.sh
bash setup.sh

cd ../grafana
chmod +x setup.sh
bash setup.sh

cd ../wireguard
chmod +x setup.sh
bash setup.sh