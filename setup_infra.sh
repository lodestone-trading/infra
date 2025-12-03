#!/bin/bash

# This software is developed by Lodestone Trading LLC and made freely available under the MIT License. All rights reserved.

# Assuming python3 install
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

cd ../influxdb
chmod +x setup.sh
bash setup.sh

cd ../airflow
chmod +x setup.sh
bash setup.sh
