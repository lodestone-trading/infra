#!/bin/bash

# Get Grafana GPG, and update APT sources
sudo apt install gnupg2 apt-transport-https software-properties-common wget
cat grafana.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/grafana.gpg > /dev/null
echo 'deb [signed-by=/etc/apt/trusted.gpg.d/grafana.gpg] https://apt.grafana.com stable main' | sudo tee /etc/apt/sources.list.d/grafana.list
sudo apt update

# Install Grafana server, Prometheus on root node; install prometheus on client nodes
sudo apt-get install prometheus grafana

# On Loki instance, install Loki + promtail
sudo apt-get install loki promtail