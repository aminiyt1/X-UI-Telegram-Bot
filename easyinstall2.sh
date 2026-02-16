#!/bin/bash

# Written By: 30j

if [ "$(id -u)" -ne 0 ]; then
    echo -e "\033[33mPlease run as root\033[0m"
    exit
fi

wait
echo -e "\e[32m
:::::::::::::::'########::::'###:::::'######::'##:::'##:::::::::::::   
::::::::::::::: ##.....::::'## ##:::'##... ##:. ##:'##::::::::::::::   
::::::::::::::: ##::::::::'##:. ##:: ##:::..:::. ####:::::::::::::::   
::::::::::::::: ######:::'##:::. ##:. ######::::. ##::::::::::::::::   
::::::::::::::: ##...:::: #########::..... ##:::: ##::::::::::::::::   
::::::::::::::: ##::::::: ##.... ##:'##::: ##:::: ##::::::::::::::::   
::::::::::::::: ########: ##:::: ##:. ######::::: ##::::::::::::::::   
:::::::::::::::........::..:::::..:::......::::::..:::::::::::::::::   
:::'####:'##::: ##::'######::'########::::'###::::'##:::::::'##::::::: 
:::. ##:: ###:: ##:'##... ##:... ##..::::'## ##::: ##::::::: ##::::::: 
:::: ##:: ####: ##: ##:::..::::: ##:::::'##:. ##:: ##::::::: ##::::::: 
:::: ##:: ## ## ##:. ######::::: ##::::'##:::. ##: ##::::::: ##::::::: 
:::: ##:: ##. ####::..... ##:::: ##:::: #########: ##::::::: ##::::::: 
:::: ##:: ##:. ###:'##::: ##:::: ##:::: ##.... ##: ##::::::: ##::::::: 
:::'####: ##::. ##:. ######::::: ##:::: ##:::: ##: ########: ########: 
:::....::..::::..:::......::::::..:::::..:::::..::........::........:: \e[33m
:::::::::'########::'##:::'##:::::'#######::::'#####:::::::::'##:::::::
::::::::: ##.... ##:. ##:'##:::::'##.... ##::'##.. ##:::::::: ##:::::::
::::::::: ##:::: ##::. ####::::::..::::: ##:'##:::: ##::::::: ##:::::::
::::::::: ########::::. ##::::::::'#######:: ##:::: ##::::::: ##:::::::
::::::::: ##.... ##:::: ##::::::::...... ##: ##:::: ##:'##::: ##:::::::
::::::::: ##:::: ##:::: ##:::::::'##:::: ##:. ##:: ##:: ##::: ##:::::::
::::::::: ########::::: ##:::::::. #######:::. #####:::. ######::::::::
:::::::::........::::::..:::::::::.......:::::.....:::::......:::::::::
\033[0m"


sleep 3
echo -e "\e[0m"
echo -e "   \e[1;33mX-UI Telegram Bot Installer\e[0m"
echo -e "   \e[90mMaintained by:\e[0m \e[1;36m@asrnovin_ir\e[0m"
echo -e "   \e[90mGitHub:\e[0m https://github.com/aminiyt1/X-UI-Telegram-Bot"
echo -e ""
sleep 2
echo -e "   \e[1mInstaller script by:\e[0m \e[1;32ms-30j\e[0m"
echo -e "   \e[90mTelegram:\e[0m @s_30j"
echo -e ""
sleep 2

echo
read -p "Did you install WizWiz, Zanboor or any other Telegram bot panel? [y/N] " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "\n\e[1;31mInstallation aborted!\e[0m"
    echo -e "   This script will most likely conflict with:"
    echo -e "     • WizWiz"
    echo -e "     • Zanbor"
    echo -e "     • other similar Telegram bot panels"
    echo -e "\nYour bot panel will encounter problems or deleted."
    echo
    exit 1
fi

echo
read -p "Did you install Mysql, Mariadb or any other Database? [y/N] " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "\n\e[1;31mInstallation aborted!\e[0m"
    echo -e "   This script will most likely conflict with:"
    echo -e "     • Mysql-server"
    echo -e "     • Mariadb"
    echo -e "     • ......"
    echo -e "\nYour database will encounter problems or deleted."
    echo
    exit 1
fi



sudo apt update && apt upgrade -y
echo -e "\e[92mThe server was successfully updated ...\033[0m\n"

echo -e "\e[32mChecking If Mysql Is Installed ... \033[0m\n"
sudo systemctl stop mysql
echo -e "\e[32mDeleting ... \033[0m\n"
sudo apt purge mysql-server mysql-client mysql-common mysql-server-core-* mysql-client-core-* -y
sudo apt purge mysql-server mysql-server-8.0 mysql-server-core-8.0 mysql-client-8.0 mysql-client-core-8.0 mysql-common dbconfig-mysql php-mysql php8.3-mysql php-mariadb-mysql-kbs -y
sudo apt autoremove -y 
sudo apt autoclean
sudo rm -rf /etc/mysql /var/lib/mysql /var/log/mysql /tmp/mysql*


clear

echo -e "\e[32m
:::::::::::::::'########::::'###:::::'######::'##:::'##:::::::::::::   
::::::::::::::: ##.....::::'## ##:::'##... ##:. ##:'##::::::::::::::   
::::::::::::::: ##::::::::'##:. ##:: ##:::..:::. ####:::::::::::::::   
::::::::::::::: ######:::'##:::. ##:. ######::::. ##::::::::::::::::   
::::::::::::::: ##...:::: #########::..... ##:::: ##::::::::::::::::   
::::::::::::::: ##::::::: ##.... ##:'##::: ##:::: ##::::::::::::::::   
::::::::::::::: ########: ##:::: ##:. ######::::: ##::::::::::::::::   
:::::::::::::::........::..:::::..:::......::::::..:::::::::::::::::   
:::'####:'##::: ##::'######::'########::::'###::::'##:::::::'##::::::: 
:::. ##:: ###:: ##:'##... ##:... ##..::::'## ##::: ##::::::: ##::::::: 
:::: ##:: ####: ##: ##:::..::::: ##:::::'##:. ##:: ##::::::: ##::::::: 
:::: ##:: ## ## ##:. ######::::: ##::::'##:::. ##: ##::::::: ##::::::: 
:::: ##:: ##. ####::..... ##:::: ##:::: #########: ##::::::: ##::::::: 
:::: ##:: ##:. ###:'##::: ##:::: ##:::: ##.... ##: ##::::::: ##::::::: 
:::'####: ##::. ##:. ######::::: ##:::: ##:::: ##: ########: ########: 
:::....::..::::..:::......::::::..:::::..:::::..::........::........:: \e[33m
:::::::::'########::'##:::'##:::::'#######::::'#####:::::::::'##:::::::
::::::::: ##.... ##:. ##:'##:::::'##.... ##::'##.. ##:::::::: ##:::::::
::::::::: ##:::: ##::. ####::::::..::::: ##:'##:::: ##::::::: ##:::::::
::::::::: ########::::. ##::::::::'#######:: ##:::: ##::::::: ##:::::::
::::::::: ##.... ##:::: ##::::::::...... ##: ##:::: ##:'##::: ##:::::::
::::::::: ##:::: ##:::: ##:::::::'##:::: ##:. ##:: ##:: ##::: ##:::::::
::::::::: ########::::: ##:::::::. #######:::. #####:::. ######::::::::
:::::::::........::::::..:::::::::.......:::::.....:::::......:::::::::
\033[0m"


echo -e "\e[32mInstalling BOT script ... \033[0m\n"
sleep 5


PKG=(
    lamp-server^
    libapache2-mod-php 
    mysql-server 
    apache2 
    php-mbstring 
    php-zip 
    php-gd 
    php-json 
    php-curl 
)

for i in "${PKG[@]}"
do
    dpkg -s $i &> /dev/null
    if [ $? -eq 0 ]; then
        echo "$i is already installed"
    else
        apt install $i -y
        if [ $? -ne 0 ]; then
            echo "Error installing $i"
            exit 1
        fi
    fi
done

echo -e "\n\e[92mPackages Installed Continuing ...\033[0m\n"

randomdbpasstxt69=$(openssl rand -base64 10 | tr -dc 'a-zA-Z0-9' | cut -c1-20)

echo 'phpmyadmin phpmyadmin/dbconfig-install boolean true' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/app-password-confirm password $randomdbpasstxt69' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/admin-pass password $randomdbpasstxt69' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/app-pass password $randomdbpasstxt69' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2' | debconf-set-selections
sudo apt-get install phpmyadmin -y
sudo ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf-available/phpmyadmin.conf
sudo a2enconf phpmyadmin.conf
sudo systemctl restart apache2

wait

sudo apt-get install -y php-soap
sudo apt-get install libapache2-mod-php

sudo systemctl enable mysql.service
sudo systemctl start mysql.service
sudo systemctl enable apache2
sudo systemctl start apache2

echo -e "\n\e[92m Setting Up UFW...\033[0m\n"

ufw allow 'Apache'

sudo systemctl restart apache2

echo -e "\n\e[92mInstalling ...\033[0m\n"

sleep 1

sudo apt-get install -y git
sudo apt-get install -y wget
sudo apt-get install -y unzip
sudo apt install curl -y
sudo apt-get install -y php-ssh2
sudo apt-get install -y libssh2-1-dev libssh2-1

sudo systemctl restart apache2.service

wait

# To Install/Extract Orginal Github Repo

git clone https://github.com/s-30j/X-UI-Telegram-Bot-EasyInstall.git /var/www/html/xuiinfobot
git clone https://github.com/s-30j/X-UI-Telegram-Bot-EasyInstall.git /root/xuiinfobot
sudo chown -R www-data:www-data /var/www/html/xuiinfobot/
sudo chmod -R 755 /var/www/html/xuiinfobot/
sudo rm -rf /root/configxuiinfobot/*
echo "Folder created successfully!"

wait
    

# if [ ! -d "/root/configxuiinfobot" ]; then

if [ ! -d "/root/configxuiinfobot" ]; then
    sudo mkdir /root/configxuiinfobot
fi


sudo rm -rf /root/configxuiinfobot/*
sleep 1
touch /root/configxuiinfobot/dbrootbot.txt
sudo chmod -R 777 /root/configxuiinfobot/dbrootbot.txt
sleep 1

randomdbpasstxt=$(openssl rand -base64 10 | tr -dc 'a-zA-Z0-9' | cut -c1-30)

ASAS="$"

echo "${ASAS}user = 'root';" >> /root/configxuiinfobot/dbrootbot.txt
echo "${ASAS}pass = '${randomdbpasstxt}';" >> /root/configxuiinfobot/dbrootbot.txt
#echo "${ASAS}paths = '${RANDOM_CODE}';" >> /root/configxuiinfobot/dbrootbot.txt

sleep 1

passs=$(cat /root/configxuiinfobot/dbrootbot.txt | grep '$pass' | cut -d"'" -f2)
userrr=$(cat /root/configxuiinfobot/dbrootbot.txt | grep '$user' | cut -d"'" -f2)

sudo mysql -u $userrr -p$passs -e "alter user '$userrr'@'localhost' identified with mysql_native_password by '$passs';FLUSH PRIVILEGES;"

echo "SELECT 1" | mysql -u$userrr -p$passs 2>/dev/null

echo "Folder created successfully!"
# else
#     echo "Folder already exists."
# fi

clear

echo " "
echo -e "\e[35m
'########:'####:'##::: ##::::'###::::'##:::::::
 ##.....::. ##:: ###:: ##:::'## ##::: ##:::::::
 ##:::::::: ##:: ####: ##::'##:. ##:: ##:::::::
 ######:::: ##:: ## ## ##:'##:::. ##: ##:::::::
 ##...::::: ##:: ##. ####: #########: ##:::::::
 ##:::::::: ##:: ##:. ###: ##.... ##: ##:::::::
 ##:::::::'####: ##::. ##: ##:::: ##: ########:
..::::::::....::..::::..::..:::::..::........::
\033[0m\n"


is_valid_host() {
    local input="$1"
    if [[ $input =~ ^([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})$ ]]; then
        local a=${BASH_REMATCH[1]} b=${BASH_REMATCH[2]} c=${BASH_REMATCH[3]} d=${BASH_REMATCH[4]}
        if [[ $a -le 255 && $b -le 255 && $c -le 255 && $d -le 255 &&
              $a -ge 0 && $b -ge 0 && $c -ge 0 && $d -ge 0 ]]; then
            [[ $a =~ ^0[0-9]+$ || $b =~ ^0[0-9]+$ || $c =~ ^0[0-9]+$ || $d =~ ^0[0-9]+$ ]] && return 1
            return 0
        fi
        return 1
    fi
    if [[ $input =~ ^([a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,}$ ]]; then
        [[ ${#input} -gt 253 ]] && return 1
        return 0
    fi
    return 1
}


while true; do
    read -p "Enter the server IP or domain (without http/https): " host

    if [ -z "$host" ]; then
        echo -e "\e[1;33mError: You must enter something!\e[0m"
        continue
    fi

    if is_valid_host "$host"; then
        echo -e "\e[1;32mFormat looks valid: $host\e[0m"

        while true; do
            read -p "Is this correct? ($host) [Y/n]: " -n 1 -r confirm
            echo

            if [[ $confirm =~ ^[Yy]$ || -z $confirm ]]; then
                echo -e "\e[1;32mConfirmed. Proceeding...\e[0m"
                echo
                SERVER_HOST="$host"
                break 2 
            elif [[ $confirm =~ ^[Nn]$ ]]; then
                echo -e "\e[1;33mLet's try again...\e[0m"
                echo
                break
            else
                echo "Please answer y or n (or just press Enter for Yes)"
            fi
        done
    else
        echo -e "\e[1;31mInvalid format! Please enter a valid IPv4 or domain (e.g. 192.168.1.1 or example.com)\e[0m"
        echo
    fi
done


echo "Server host set to: $SERVER_HOST"


# Allow HTTP and HTTPS traffic
echo -e "\n\033[1;7;31mAllowing HTTP and HTTPS traffic...\033[0m\n"
sudo ufw allow 80
sudo ufw allow 443


echo -e "\e[32m======================================"
echo -e "IP connection is done!"
echo -e "======================================\033[0m"


wait

echo " "

ROOT_PASSWORD=$(cat /root/configxuiinfobot/dbrootbot.txt | grep '$pass' | cut -d"'" -f2)
ROOT_USER="root"
echo "SELECT 1" | mysql -u$ROOT_USER -p$ROOT_PASSWORD 2>/dev/null


if [ $? -eq 0 ]; then

wait

    randomdbpass=$(openssl rand -base64 10 | tr -dc 'a-zA-Z0-9' | cut -c1-22)

    randomdbdb=$(openssl rand -base64 10 | tr -dc 'a-zA-Z0-9' | cut -c1-22)

    if [[ $(mysql -u root -p$ROOT_PASSWORD -e "SHOW DATABASES LIKE 'xuiinfobot'") ]]; then
        clear
        echo -e "\n\e[91mYou have already created the database\033[0m\n"
    else
        dbname=xuiinfobot
        clear

        dbuser=$randomdbdb

        dbpass=$randomdbpass

        mysql -u root -p$ROOT_PASSWORD -e "CREATE DATABASE $dbname;" -e "CREATE USER '$dbuser'@'%' IDENTIFIED WITH mysql_native_password BY '$dbpass';GRANT ALL PRIVILEGES ON * . * TO '$dbuser'@'%';FLUSH PRIVILEGES;" -e "CREATE USER '$dbuser'@'localhost' IDENTIFIED WITH mysql_native_password BY '$dbpass';GRANT ALL PRIVILEGES ON * . * TO '$dbuser'@'localhost';FLUSH PRIVILEGES;"
        
        echo -e "\n\e[95mDatabase Created.\033[0m"
        
        wait
        


        printf "\n\e[33m[+] \e[36mBot Token: \033[0m"
        read YOUR_BOT_TOKEN
        printf "\e[33m[+] \e[36mAdmin id: \033[0m"
        read YOUR_CHAT_ID
        echo " "
        if [ "$YOUR_BOT_TOKEN" = "" ] || [ "$YOUR_CHAT_ID" = "" ]; then
           exit
        fi

        ASAS="$"
	
        wait

        sleep 1
        
        file_path="/var/www/html/xuiinfobot/config.php"
        
        if [ -f "$file_path" ]; then
          rm "$file_path"
          echo -e "File deleted successfully."
        else
          echo -e "File not found."
        fi
        
        sleep 2
        
        # print file
        echo -e "<?php" >> /var/www/html/xuiinfobot/config.php
        echo -e "error_reporting(0);" >> /var/www/html/xuiinfobot/config.php
        echo -e "${ASAS}botToken = '${YOUR_BOT_TOKEN}';" >> /var/www/html/xuiinfobot/config.php
        echo -e "${ASAS}dbHost = 'localhost';" >> /var/www/html/xuiinfobot/config.php
        echo -e "${ASAS}dbUser = '${dbuser}';" >> /var/www/html/xuiinfobot/config.php
        echo -e "${ASAS}dbPass = '${dbpass}';" >> /var/www/html/xuiinfobot/config.php
        echo -e "${ASAS}dbName = '${dbname}';" >> /var/www/html/xuiinfobot/config.php
        echo -e "${ASAS}adminId = ${YOUR_CHAT_ID};" >> /var/www/html/xuiinfobot/config.php
        echo -e "?>" >> /var/www/html/xuiinfobot/config.php

        sleep 1

        curl -F "url=http://${SERVER_HOST}/xuiinfobot/index.php" "https://api.telegram.org/bot${YOUR_BOT_TOKEN}/setWebhook"
        MESSAGE="✅ The X-UI Smart Query Bot has been successfully installed! @s_30j"
        curl -s -X POST "https://api.telegram.org/bot${YOUR_BOT_TOKEN}/sendMessage" -d chat_id="${YOUR_CHAT_ID}" -d text="$MESSAGE"
        
        
        sleep 1
        
        url="http://${SERVER_HOST}/xuiinfobot/CreateDB.php"
        curl $url
        
        sleep 2
        
        sudo rm /var/www/html/xuiinfobot/CreateDB.php
        sudo rm /var/www/html/xuiinfobot/database.sql
        sudo rm /var/www/html/xuiinfobot/README.md
            
        clear
        
        echo " "
        
        echo -e "\e[100mDatabase information if you need:\033[0m"
	    echo -e "\e[33maddress: \e[36mhttp://${SERVER_HOST}/phpmyadmin\033[0m"
        echo -e "\e[33mDatabase name: \e[36m${dbname}\033[0m"
        echo -e "\e[33mDatabase username: \e[36m${dbuser}\033[0m"
        echo -e "\e[33mDatabase password: \e[36m${dbpass}\033[0m"
        echo " "
        
        echo " "
        

        
        sleep 3
        echo -e "\e[0m"
        echo -e "   \e[1;33mX-UI Telegram Bot Installer\e[0m"
        echo -e "   \e[90mMaintained by:\e[0m \e[1;36m@asrnovin_ir\e[0m"
        echo -e "   \e[90mGitHub:\e[0m https://github.com/aminiyt1/X-UI-Telegram-Bot"
        echo -e ""
        sleep 2
        echo -e "   \e[1mInstaller script by:\e[0m \e[1;32ms-30j\e[0m"
        echo -e "   \e[90mTelegram:\e[0m @s_30j"
        echo -e ""
        sleep 2

        fi

    fi
