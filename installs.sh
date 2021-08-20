#!/bin/bash

# Hardcoded versions that will require testing for upgrades in the future
NEOFETCH="https://github.com/dylanaraps/neofetch/archive/7.1.0.zip"


#########################
######### START #########
#########################

sudo apt-get update
# Comment if you dont want upgrade, as this script is made to install from fresh image!
sudo apt-get upgrade -y
sudo apt-get autoremove
sudo apt-get autoclean
sudo apt-get clean
# Im serious... comment if you arent on an unedited image!!!1
sudo apt-get dist-upgrade -y

# Set /opt to group kali
sudo chown -R root:kali /opt
sudo chmod -R g+w /opt

#########################
####### CONFIGURE #######
#########################

# Set up profile and bashrc last to ensure overwriting automated installer additions
cp .bashrc ~/.bashrc
cp .profile ~/.profile
# root bashrc so su - will mirror the nice looks ;)
sudo cp .bashrc /root/.bashrc

# Sublime Text 3 settings copy
cp .config/sublime-text-3/Preferences.sublime-settings ~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings
cp .config/terminator/config ~/.config/terminator/config

# Source the configs so we can use the commands such as go in this script
# I think this works..
source ~/.bashrc

##########################
####### INSTALLERS #######
##########################

# Install Openvas dependencies
sudo apt-get install gcc cmake libglib2.0-dev libgnutls28-dev libpq-dev pkg-config libical-dev libgvm-dev libmicrohttpd-dev libxml2-dev libxslt1-dev cmake pkg-config libglib2.0-dev libgnutls28-dev uuid-dev libssh-gcrypt-dev libhiredis-dev xmltoman doxygen clang-format graphviz libpthread-stubs0-dev locales-all libjson-perl gettext libmicrohttpd-dev libxml2-dev gcc pkg-config libssh-gcrypt-dev libgnutls28-dev libglib2.0-dev libpcap-dev bison libksba-dev libgcrypt20-dev heimdal-dev heimdal-multidev libpopt-dev libpopt0 gcc-mingw* libsqlite3-dev libpq-dev sqlite3 sqlfairy xsltproc libgd-graph-perl redis-server icu-devtools libicu-dev libmicrohttpd-dev python3-dev gnutls-bin libical-dev git libldap2-dev libsnmp-dev -y
python3 -m pip install setuptools wheel gvm-tools

# Install - Sublime Text (command: "subl")
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text -y

# Install - Terminator and Terminal settings (command: "terminator")
sudo apt-get install terminator -y

# Install - Rust(up) and Cargo on user AND root
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
sudo sh -l -c "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
sudo sh -l -c ". \$HOME/.cargo/env" # set path of root whilst user

# Install - "exa" (a Rust replacement for ls)
cargo install exa
sudo sh -l -c "cargo install exa"

# Install - "Rustscan" (a fast port scan wrapper for nmap)
#cargo install rustscan
#sudo sh -l -c "cargo install rustscan"

# Install - "Rustbuster" (replacement for gobuster and dirbuster that supports more features than both)
echo "Installing latest version of Rustbuster from Github"
latest_version=`curl -s https://github.com/phra/rustbuster/releases | grep "rustbuster-v" | head -n1 | cut -d'/' -f6`
echo "Latest release: $latest_version"
mkdir -p /opt/rustbuster
wget -qP /opt/rustbuster https://github.com/phra/rustbuster/releases/download/$latest_version/rustbuster-$latest_version-x86_64-unknown-linux-gnu
ln -fs /opt/rustbuster/rustbuster-$latest_version-x86_64-unknown-linux-gnu /opt/rustbuster/rustbuster
sudo chmod +x /opt/rustbuster/rustbuster

# Install - Golang
#todo

# Install - Firefox Stable (all users setup)
wget -O /opt/ff.tar.bz2 https://download-installer.cdn.mozilla.net/pub/firefox/releases/79.0/linux-x86_64/en-US/firefox-79.0.tar.bz2
cd /opt;tar xvf ff.tar.bz2
echo -e "[Desktop Entry]\nName=Firefox Stable\nComment=Web Browser\nExec=/opt/firefox/firefox %u\nTerminal=false\nType=Application\nIcon=/opt/firefox/browser/chrome/icons/default/default128.png\nCategories=Network;WebBrowser;\nMimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/vnd.mozilla.xul+xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;\nStartupNotify=true"| sudo tee /usr/share/applications/firefox-stable.desktop
sudo ln -s /opt/firefox/firefox /usr/local/bin/firefox
sudo update-alternatives --install /usr/bin/x-www-browser x-www-browser /opt/firefox/firefox 200 && sudo update-alternatives --set x-www-browser /opt/firefox/firefox 

# Install - seclists and symlinks to shorter path (opt)
sudo apt-get install seclists -y
ln -s /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt /opt/wordlist-web-directories.txt
ln -s /usr/share/seclists/Discovery/Web-Content/common.txt /opt/wordlist-web-top.txt
ln -s /usr/share/seclists/Usernames/top-usernames-shortlist.txt /opt/wordlist-users-top.txt
ln -s /usr/share/seclists/Usernames/Names/names.txt /opt/wordlist-users-names.txt
if [[ -f /usr/share/wordlists/rockyou.txt.gz ]];then gzip -d /usr/share/wordlists/rockyou.txt.gz;ln -s /usr/share/wordlists/rockyou.txt /opt/rockyou.txt;fi

# Install - Pip3 and modules checker
sudo python3 -m pip install pip --upgrade
sudo python3 -m pip install pip-check

# Install - Rot13 and Caesar tools
sudo apt-get install bsdgames -y

# Install - PEzor
sudo apt-get install libcapstone-dev
mkdir -p /opt/evasion/PEzor
git clone https://github.com/phra/PEzor /opt/evasion/PEzor
sudo bash /opt/evasion/PEzor/install.sh
go get github.com/egebalci/sgn

#########################
######## UPDATES ########
#########################
sudo pip-check -H


########################
######## FINISH ########
########################

echo -e "\n\n"
echo "========================"
echo "All done!"
echo "========================"
echo "Added aliases:"
echo "exaa - 'exa' alias to show all sorted by date"
echo "exar - 'exa' alias to list all recursive directories - CAN BE VERY VERBOSE"
echo "lat - 'ls' alias to show all sorted by date (order matches exa)"
echo "========================"
echo "Breaking Changes:"
echo "'sudoedit <file>' will now use sublime text 3 !"
echo "========================"
#todo more
