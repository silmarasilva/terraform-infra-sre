#!/bin/bash
sudo apt-get update
cd /home/ubuntu/
sudo echo ${lb_endpoint} > lb.txt
sudo apt -y update
sudo apt -y upgrade -y
sudo apt install python3-pip -y
sudo apt install git -y  
sudo apt install python3 
sudo pip install flask-mysql
sudo pip install flask_cors 
sudo pip install pymysql
sudo pip install flask_basicauth
sudo pip install flask_debug 
sudo apt-get install mysql-client -y
sudo pip install mysql-connector-python
git clone https://github.com/silmarasilva/apiVENDAS.git
cp lb.txt ./apiVENDAS
cd apiVENDAS
sudo chmod 777 main_vendas
sudo python3 main_vendas.py