mode=$1

opkg update
opkg install jq
opkg install openssh-sftp-server

if [[ $mode == "openclash" ]]; then
opkg install luci-app-openclash
elif [[ $mode == "passwall" ]]; then
opkg install luci-app-passwall
fi

echo 1 > /etc/config/auto_start
