#!/bin/bash

api=$( curl -s htttps://api.wildydev21.com/ip-info/json );

ip=$( echo $api | jq -r ".ip" );
isp=$( echo $api | jq -r ".isp" );
asn=$( echo $api | jq -r ".asn" );

echo $ip,$isp,$asn > /tmp/ip-info.conf
