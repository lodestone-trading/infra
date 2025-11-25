#!/bin/bash

sudo pip3 install mlflow
sudo cp ./etc/systemd/system/mlflow.service /etc/systemd/system/mlflow.service
sudo systemctl enable mlflow
sudo systemctl start mlflow
