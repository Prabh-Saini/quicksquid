# install and prepare system
sudo apt update
sudo apt install squid -y
sudo apt install sed -y
sudo apt install ufw -y

# set port 
echo What port would you like to use? If unsure use 3128
read port
sudo sed -i -e 's/http_port 3128/http_port $port/g' /etc/squid/squid.conf
sudo ufw allow $port

# http_access all
echo Would you like to allow ALL IPs to access your proxy? This is UNSAFE, however if you do not want to use IP or username/password authentication, enable this. [y/n] 
read httpaccess
if [ "$httpaccess" != "${answer#[Yy]}" ] ;then 
    sudo sed -i -e 's/http_access deny all/http_access allow all/g' /etc/squid/squid.conf
else
    echo Make sure to enable IP or username/password authenitcation as all IP access has been enabled
fi

# IP authentication
echo Would you like to enable IP authentication? [y/n] 
read ipauth
if [ "$httpaccess" != "${answer#[Yy]}" ] ;then 
    echo Which IP would you like to authenticate? 
    read useripauth
    sudo sed -i '1s/^/http_access allow ipauthentication\n/' /etc/squid/squid.conf
    sudo sed -i '1s/^/acl ipauthentication src $useripauth\n/' /etc/squid/squid.conf
else
    echo IP Authentication not enabled
fi

# Restart Squid to apply changes
sudo systemctl restart squid.service

# call it a day
echo "make sure you allow 36542 for inbound traffic, and 80, 443 for outbound traffic"
