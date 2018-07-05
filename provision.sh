#!/bin/bash
sleep 30

sudo apt-get update -y
sudo apt-get install python-pip python-dev build-essential -y

sudo mkdir -p /home/opt/todo
sudo chown ubuntu /home/opt/todo
git clone https://github.com/manthan787/packer-python /home/opt/todo
pip install -r /home/opt/todo/requirements.txt