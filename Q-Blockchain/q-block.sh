#!/bin/bash

clear

echo -e "\033[0;35m"
echo '_____   __                                           '
echo '___  | / /_____ ______ _____________ ______________ _'
echo '__   |/ /_  __ `/  __ `/_  __ \  __ `/_  __ \_  __ `/'
echo '_  /|  / / /_/ // /_/ /_  / / / /_/ /_  / / /  /_/ / '
echo '/_/ |_/  \__,_/ \__,_/ /_/ /_/\__,_/ /_/ /_/_\__, /  '
echo '                                            /____/   '
echo '___       ____________                               '
echo '__ |     / /__(_)__  /__________      _______        '
echo '__ | /| / /__  /__  __ \  __ \_ | /| / /  __ \       '
echo '__ |/ |/ / _  / _  /_/ / /_/ /_ |/ |/ // /_/ /       '
echo '____/|__/  /_/  /_.___/\____/____/|__/ \____/        '
echo '                                                     '
echo -e "\e[0m"

echo -e "\033[0;35m"
echo "-:::::::::::::-  -:::::::::::::-  -:::::::::::::-  -:::::::::::::-  -:::::::::::::-"
echo -e "\e[0m"

echo -e "\e[95mProject = Q-Blockchain Testnet\e[0m"
echo -e "\e[95mTelegram Channel = https://t.me/Nanangwibowo\e[0m"
echo -e "\e[95mTwitter = https://twitter.com/Nanangwibow0\e[0m"

echo -e "\033[0;35m"
echo "-:::::::::::::-  -:::::::::::::-  -:::::::::::::-  -:::::::::::::-  -:::::::::::::-"
echo -e "\e[0m"

sleep 2

echo -e "\e[1m\e[32m1. Install docker... \e[0m" && sleep 1
sudo apt-get update && sudo apt install jq && sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/trusted.gpg.d/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

echo -e "\e[1m\e[32m2. Clone repo... \e[0m" && sleep 1
git clone https://gitlab.com/q-dev/testnet-public-tools.git

echo -e "\e[1m\e[32m3. Create directory... \e[0m" && sleep 1
mkdir -p /root/testnet-public-tools/testnet-validator/keystore

echo '-:::::::::::::-  -:::::::::::::-  DONE  -:::::::::::::-  -:::::::::::::-'
