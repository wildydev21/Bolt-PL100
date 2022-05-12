#!/bin/sh
# By Langit7
# Author Github : github.com/langit7
# ===========================================

{ echo "ucfg set config wan lte apntable apn1 apn_name internet"; sleep 2; } | telnet 169.254.0.1

while sleep 5; do
{ echo "nvram_get cache wan_ipaddr"; echo "nvram_get cache wan_primary_dns"; sleep 2; } | telnet 169.254.0.1 | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -v "169.254.0.1"  > /tmp/ipmodem.txt

ethdataip=$(ifconfig modem.103 | grep 'inet addr' | cut -d: -f2 | awk '{print $1}')
lteip=$(head -1 /tmp/ipmodem.txt)
ltedns=$(tail -1 /tmp/ipmodem.txt)

if [ -z "$lteip" ]
then
      echo "IP modem tidak dapat di cek"
else
     if [[ "$ethdataip" != "$lteip" ]];then
        echo "eth_data $ethdataip \n LTE IP $lteip dns $ltedns"
         #ifconfig modem.103 $lteip netmask 255.255.255.255 up
        logger -p notice -t lte "IP berubah dari $ethdataip menjadi $lteip dns $ltedns"
         uci set network.eth_data.ipaddr="$lteip"
         uci set network.eth_data.dns="$ltedns"
         uci commit network
         /etc/init.d/network reload
         ip route add default dev modem.103
	 sleep 60
        else
         echo "OK IP eth_data $ethdataip"
        fi
fi
done
