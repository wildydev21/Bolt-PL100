ping -q -w 1 -c 1 google.com > /dev/null && STT=on || STT=off
if [[ $STT == "on" ]]; then
jsonnya=$( curl -s ipinfo.io )
echo " IP         : $( echo "$jsonnya" | jq -r .ip )"
echo " ISP        : $( echo "$jsonnya" | jq -r .org | cut -d " " -f 2-100 )"
echo " City       : $( echo "$jsonnya" | jq -r .city )"
echo " Region     : $( echo "$jsonnya" | jq -r .region )"
echo " Country    : $( echo "$jsonnya" | jq -r .country )"
echo ""
else
echo ""
echo "             No Have Internet Access"
echo ""
fi
echo "----------------- WildyDev21.Com -----------------"
