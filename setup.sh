sudo apt update
sudo apt install squid -y
wget https://github.com/Prabh-Saini/quicksquid/blob/36542/squidconfexample.txt
cp squidconfexample.txt /etc/squid/squid.conf
rm squidconfexample.txt
sudo ufw allow 36542
sudo systemctl restart squid.service
echo "make sure you allow 36542 for inbound traffic, and 80, 443 for outbound traffic"
