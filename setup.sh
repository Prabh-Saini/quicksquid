sudo apt update
sudo apt install squid -y
wget https://raw.githubusercontent.com/Prabh-Saini/quicksquid/main/squidconfexample.txt
cp squidconfexample.txt /etc/squid/squid.conf
rm squidconfexample.txt
sudo ufw allow 3128
sudo systemctl restart squid.service
echo "make sure you allow 36542 for inbound traffic, and 80, 443 for outbound traffic"
