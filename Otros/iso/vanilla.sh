cd /root
wget -O script-base.sh https://staging.karlaperezyt.com/locoskde/src/script-base_64b.sh.txt
chmod +x script-base.sh
./script-base.sh

./script-desktop.sh
./script-dependency.sh
./script-customs.sh
